page 50011 "WDC Production Declaration"
{
    CaptionML = FRA = 'Déclaration production', ENU = 'Production declaration';
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = FRA = 'Général', ENU = 'General';
                field("OF No."; OFNO)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the value of the OF No. field.', FRA = 'Spécifie la valeur du champ N° OF';
                    CaptionML = ENU = 'OF No.', FRA = 'N° OF';
                    TableRelation = "Production Order"."No." where(Status = const(Released));
                    trigger OnValidate()
                    var

                        lCustomer: Record Customer;
                        ResEntry: Record "Reservation Entry";
                    begin
                        ProductionOrder.SetCurrentKey(Status, "No.");
                        ProductionOrder.Get(ProductionOrder.Status::Released, OFNO);
                        ProdOrderLine.Reset();
                        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                        if ProdOrderLine.FindSet() then begin
                            lItem.GET(ProdOrderLine."Item No.");
                            ItemNo := lItem."No.";
                            lCustomer.Get(lItem."Customer Code");
                            SN := lCustomer."Customer Abreviation" + ProductionOrder.Model;
                            //VariantCode := ProductionOrder."Variant Code";
                            QtyTotal := ProdOrderLine.Quantity;
                            RemainingQty := ProdOrderLine."Remaining Quantity";
                        end;
                    end;
                }
                field(SN; SN)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the value of the SN field.', FRA = 'Spécifie la valeur du champ SN';
                }
                field(VariantCode; VariantCode)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the value of the SN field.', FRA = 'Indique la variante de l''article sur la ligne';
                    //Editable = false;
                    trigger OnLookup(var text: Text): Boolean
                    var
                        ItemVariants: Page "Item Variants";
                        ItemVarient: Record "Item Variant";
                    begin
                        ItemVarient.Reset();
                        ItemVarient.SetRange("Item No.", ItemNo);
                        if ItemVarient.FindSet() then begin
                            ItemVariants.SetTableView(ItemVarient);
                            ItemVariants.Editable(false);
                            ItemVariants.RunModal();
                            ItemVariants.GetRecord(ItemVarient);
                            VariantCode := ItemVarient.code;
                        end;
                    end;
                }
                field(QtyTotal; QtyTotal)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = FRA = 'Quantité total', ENU = 'Total Quantity';
                    DecimalPlaces = 0 : 5;
                }
                field(RemainingQty; RemainingQty)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = FRA = 'Quantité restante', ENU = 'Remaining Quantity';
                    DecimalPlaces = 0 : 5;
                }
                field(ItemNo; ItemNo)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ValiderEtImprimer)
            {
                CaptionML = FRA = 'Valider & Imprimer', ENU = 'Validate & Print';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lItemJnlLine: Record "Item Journal Line";
                    lItemJnlLine1: Record "Item Journal Line";
                    lItemJnlLine2: Record "Item Journal Line";
                    lReservationEntry: Record "Reservation Entry";
                    lReserEntry: Record "Reservation Entry";
                    Item: Record Item;
                    ModeleFeuille: Text;
                    NomFeuille: Text;
                    ProductionOrder: Record "Production Order";
                    ProdOrderLine: Record "Prod. Order Line";
                    SerialNoInformation: Record "Serial No. Information";
                    ProductionJrnlMgt: Codeunit "Production Journal Mgt";
                    ProductionBOMLine: Record "Production BOM Line";
                    ProdOrderComp: Record "Prod. Order Component";
                    FirstLine: Boolean;
                    SumQty: Decimal;
                    SumQty2: Decimal;
                    lQuantity: Decimal;
                    Qty: Decimal;
                    lItem: record item;
                    lItemUnitofMeasure: record "Item Unit of Measure";
                    SerialNOInfo: Record "Serial No. Information";
                begin
                    If OFNO = '' then
                        Error(Text001);
                    If SN = '' then
                        Error(text002);
                    If StrLen(SN) < 12 then
                        Error(text003)
                    else begin
                        SerialNOInfo.Reset();
                        SerialNOInfo.SetRange("Serial No.", SN);
                        if SerialNOInfo.FindSet() then
                            Error(Text004);
                    end;
                    ModeleFeuille := 'Sortie';
                    NomFeuille := 'PRODPF';
                    Init_ItemJNLLine;
                    Init_ItemJNLLineConso;
                    Init_ItemTracability;
                    Init_ItemTracabilityCONSO;

                    ProductionOrder.Get(ProductionOrder.Status::Released, OFNO);
                    ProdOrderLine.Reset();
                    ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                    if ProdOrderLine.FindSet() then
                        Item.GET(ProdOrderLine."Item No.");

                    ProductionOrder.DeclProd := true;
                    ProductionOrder.Modify();
                    ProductionJrnlMgt.Handling(ProductionOrder, ProdOrderLine."Line No.");
                    ProductionOrder.DeclProd := false;
                    ProductionOrder.Modify();

                    if VariantCode <> '' then begin
                        lItemJnlLine2.Reset();
                        lItemJnlLine2.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Operation No.");
                        lItemJnlLine2.SetRange("Journal Template Name", ModeleFeuille);
                        lItemJnlLine2.SetRange("Journal Batch Name", NomFeuille);
                        lItemJnlLine2.SetRange("Document No.", ProductionOrder."No.");
                        if lItemJnlLine2.FindSet() then
                            repeat
                                lItemJnlLine2."Variant Code" := VariantCode;
                                lItemJnlLine2.Modify();
                            until (lItemJnlLine2.Next() = 0);
                    end;

                    lItemJnlLine.Reset();
                    lItemJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Operation No.");
                    lItemJnlLine.SetRange("Journal Template Name", ModeleFeuille);
                    lItemJnlLine.SetRange("Journal Batch Name", NomFeuille);
                    lItemJnlLine.SetRange("Document No.", ProductionOrder."No.");
                    lItemJnlLine.SetFilter("No.", '%1', 'BICHONNAGE');
                    if lItemJnlLine.FindLast() then begin
                        lReserEntry.Init();
                        Clear(lReserEntry);
                        lReserEntry."Entry No." := lReserEntry.GetLastEntryNo + 1;
                        lReserEntry."Item Tracking" := lReserEntry."Item Tracking"::"Lot and Serial No.";
                        lReserEntry."Source ID" := lItemJnlLine."Journal Template Name";
                        lReserEntry."Source Batch Name" := lItemJnlLine."Journal Batch Name";
                        lReserEntry."Source Ref. No." := lItemJnlLine."Line No.";
                        lReserEntry.validate("Item No.", lItemJnlLine."Item No.");
                        lReserEntry."Location Code" := lItemJnlLine."Location Code";
                        lReserEntry."Reservation Status" := lReserEntry."Reservation Status"::Surplus;
                        lReserEntry."Creation Date" := WorkDate;
                        lReserEntry."Source Type" := 83;
                        lReserEntry."Source Subtype" := 6;
                        lReserEntry."Serial No." := SN;
                        lReserEntry."Variant Code" := VariantCode;
                        lReserEntry."Lot No." := lItemJnlLine."Order No.";
                        lReserEntry.Quantity := 1;
                        lReserEntry."Quantity (Base)" := 1;
                        lReserEntry."Qty. to Handle (Base)" := 1;
                        lReserEntry."Qty. to Invoice (Base)" := 1;
                        lReserEntry.Insert();
                    end;
                    lItemJnlLine.Reset();
                    lItemJnlLine.SETFILTER("Journal Template Name", 'CONSOMMATI');
                    lItemJnlLine.SETFILTER("Journal Batch Name", 'CONSOPF');
                    lItemJnlLine.SetRange("Document No.", ProductionOrder."No.");
                    lItemJnlLine.SetRange("Flushing Method", lItemJnlLine."Flushing Method"::Manual);
                    if lItemJnlLine.FindSet() then begin
                        repeat
                            FirstLine := false;
                            Clear(Qty);
                            Clear(SumQty);
                            Clear(SumQty2);
                            lReservationEntry.Reset();
                            lReservationEntry.SetRange("Source ID", lItemJnlLine."Journal Template Name");
                            lReservationEntry.SetRange("Source Batch Name", lItemJnlLine."Journal Batch Name");
                            lReservationEntry.SetRange("Source Ref. No.", lItemJnlLine."Line No.");
                            lReservationEntry.SetRange("Item No.", lItemJnlLine."Item No.");
                            lReservationEntry.SetRange("Source Type", 83);
                            lReservationEntry.Setrange("Source Subtype", 5);
                            if lReservationEntry.FindSet() then begin
                                repeat
                                    if not FirstLine then begin
                                        ProdOrderComp.Reset();
                                        ProdOrderComp.SetRange("Prod. Order No.", lItemJnlLine."Order No.");
                                        ProdOrderComp.SetRange("Item No.", lItemJnlLine."Item No.");
                                        ProdOrderComp.SetRange("Line No.", lItemJnlLine."Prod. Order Comp. Line No.");
                                        If ProdOrderComp.FindSet() then begin
                                            lQuantity := ProdOrderComp."Quantity per";
                                            Qty := lQuantity;
                                            litem.Get(ProdOrderComp."Item No.");
                                            If lItem."Base Unit of Measure" <> ProdOrderComp."Unit of Measure Code" then begin
                                                lItemUnitofMeasure.Get(ProdOrderComp."Item No.", ProdOrderComp."Unit of Measure Code");
                                                lQuantity := round(ProdOrderComp."Quantity per" * lItemUnitofMeasure."Qty. per Unit of Measure", litem."Rounding Precision", '=');
                                                Qty := lQuantity;
                                            end;

                                            if (lQuantity < -lReservationEntry."Quantity (Base)") then begin
                                                lReservationEntry.Quantity := -lQuantity;
                                                lReservationEntry."Quantity (Base)" := -lQuantity;
                                                lReservationEntry."Qty. to Handle (Base)" := -lQuantity;
                                                lReservationEntry."Qty. to Invoice (Base)" := -lQuantity;
                                                lReservationEntry.Modify();
                                                FirstLine := true;
                                                Qty -= lQuantity;
                                            end
                                            else begin
                                                SumQty += -lReservationEntry."Quantity (Base)";
                                                if SumQty <= lQuantity then begin
                                                    SumQty2 += -lReservationEntry."Quantity (Base)";
                                                    Qty -= SumQty;
                                                    FirstLine := true;
                                                end
                                                else begin
                                                    lReservationEntry.Quantity := -(lQuantity - SumQty2);
                                                    lReservationEntry."Quantity (Base)" := -(lQuantity - SumQty2);
                                                    lReservationEntry."Qty. to Handle (Base)" := -(lQuantity - SumQty2);
                                                    lReservationEntry."Qty. to Invoice (Base)" := -(lQuantity - SumQty2);
                                                    lReservationEntry.Modify();
                                                    FirstLine := true;
                                                end;
                                            end;
                                        end;
                                    end else
                                        if Qty <> 0 then begin
                                            if (Qty <= -lReservationEntry."Quantity (Base)") then begin
                                                lReservationEntry.Quantity := -Qty;
                                                lReservationEntry."Quantity (Base)" := -Qty;
                                                lReservationEntry."Qty. to Handle (Base)" := -Qty;
                                                lReservationEntry."Qty. to Invoice (Base)" := -Qty;
                                                lReservationEntry.Modify();
                                                FirstLine := true;
                                            end

                                        end else begin
                                            lReservationEntry.Delete();
                                        end;
                                until (lReservationEntry.Next() = 0)
                            end
                            else
                                if (lItemJnlLine."No." = '') and (lItemJnlLine."Source No." <> '') then
                                    Error('Vous devez attribuer un numéro de lot à l''article %1.', lItemJnlLine."Item No."); //WDC.SH
                        until (lItemJnlLine.Next() = 0)
                    end;

                    lItemJnlLine.Reset();
                    lItemJnlLine.SetRange("Journal Template Name", ModeleFeuille);
                    lItemJnlLine.SetRange("Journal Batch Name", NomFeuille);
                    lItemJnlLine.SetRange(Quantity, 0);
                    lItemJnlLine.DeleteAll();

                    lItemJnlLine.Reset();
                    lItemJnlLine.SetRange("Journal Template Name", ModeleFeuille);
                    lItemJnlLine.SetRange("Journal Batch Name", NomFeuille);
                    if lItemJnlLine.FindSet() then begin
                        ItemJnlPostBatch.SetSuppressCommit(true);
                        ItemJnlPostBatch.Run(lItemJnlLine);
                        lItemJnlLine1.Reset();
                        lItemJnlLine1.SetRange("Journal Template Name", 'CONSOMMATI');
                        lItemJnlLine1.SetRange("Journal Batch Name", 'CONSOPF');
                        lItemJnlLine1.SetRange(Quantity, 0);
                        lItemJnlLine1.SetRange("Flushing Method", lItemJnlLine1."Flushing Method"::Manual);
                        lItemJnlLine1.DeleteAll();

                        lItemJnlLine1.Reset();
                        lItemJnlLine1.SetRange("Journal Template Name", 'CONSOMMATI');
                        lItemJnlLine1.SetRange("Journal Batch Name", 'CONSOPF');
                        lItemJnlLine1.SetRange("Flushing Method", lItemJnlLine1."Flushing Method"::Manual);
                        if lItemJnlLine1.FindSet() then begin
                            ItemJnlPostBatch.Run(lItemJnlLine1);

                            SerialNoInformation.Reset();
                            SerialNoInformation.SetRange("Item No.", Item."No.");
                            SerialNoInformation.SetRange("Serial No.", SN);
                            If SerialNoInformation.FindSet() then
                                Report.Run(50019, false, true, SerialNoInformation);
                        end;
                    end;
                    OFNO := '';
                    SN := '';
                    VariantCode := '';
                    Clear(QtyTotal);
                    Clear(RemainingQty);
                    CurrPage.Update();
                end;
            }
        }
    }
    procedure Init_ItemJNLLine()
    var
        lItemJnlLine: Record 83;
    begin
        lItemJnlLine.Reset();
        lItemJnlLine.SetFilter("Journal Batch Name", 'PRODPF');
        lItemJnlLine.SetFilter("Journal Template Name", 'Sortie');
        lItemJnlLine.DeleteAll();
    end;

    procedure Init_ItemJNLLineConso()
    var
        lItemJnlLine: Record 83;
    begin
        lItemJnlLine.Reset();
        lItemJnlLine.SetFilter("Journal Batch Name", 'CONSOPF');
        lItemJnlLine.SetFilter("Journal Template Name", 'CONSOMMATI');
        lItemJnlLine.DeleteAll();
    end;

    procedure Init_ItemTracability()
    var
        lResEntry: Record 337;
    begin
        lResEntry.Reset();
        lResEntry.SetFilter("Source Batch Name", 'PRODPF');
        lResEntry.SetFilter("Source ID", 'Sortie');
        lResEntry.SetFilter(Quantity, '<%1', 0);
        lResEntry.DeleteAll();
    end;

    procedure Init_ItemTracabilityCONSO()
    var
        lResEntry: Record 337;
    begin
        lResEntry.Reset();
        lResEntry.SetFilter("Source Batch Name", 'CONSOPF');
        lResEntry.SetFilter("Source ID", 'CONSOMMATI');
        lResEntry.SetFilter(Quantity, '<%1', 0);
        lResEntry.DeleteAll();
    end;

    var
        ItemNo: Code[20];
        VariantCode: Code[10];
        OFNO: Code[20];
        SN: Text[50];
        QtyTotal: Decimal;
        lItem: Record Item;
        RemainingQty: Decimal;
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        TrackingSpecification: Record "Tracking Specification";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        text001: Label 'Veuiller entrez la numéro d''OF';
        Text002: Label 'Veuillez entrer un numéro de série';
        text003: Label 'N° série doit avoir au minimum 12 caractères';
        Text004: Label 'Le N° série existe déjà';
}
