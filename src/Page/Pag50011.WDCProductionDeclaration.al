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
                        lItem: Record Item;
                        lCustomer: Record Customer;
                    begin
                        ProductionOrder.SetCurrentKey(Status, "No.");
                        ProductionOrder.Get(ProductionOrder.Status::Released, OFNO);
                        ProdOrderLine.Reset();
                        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                        if ProdOrderLine.FindSet() then begin
                            lItem.GET(ProdOrderLine."Item No.");
                            lCustomer.Get(lItem."Customer Code");
                            SN := lCustomer."Customer Abreviation" + ProductionOrder.Model;
                            VariantCode := ProductionOrder."Variant Code";
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
                    Editable = false;
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
                begin
                    If OFNO = '' then
                        Error(Text001);
                    If SN = '' then
                        Error(text002);
                    ModeleFeuille := 'Sortie';
                    NomFeuille := 'PRODPF';
                    Init_ItemJNLLine;

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

                    lItemJnlLine.Reset();
                    lItemJnlLine.SetRange("Journal Template Name", ModeleFeuille);
                    lItemJnlLine.SetRange("Journal Batch Name", NomFeuille);
                    lItemJnlLine.SetRange("Document No.", ProductionOrder."No.");
                    if lItemJnlLine.FindSet() then begin
                        repeat
                            if lItemJnlLine."No." = 'BICHONNAGE' then begin
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
                                lReserEntry."Lot No." := lItemJnlLine."Order No.";
                                lReserEntry.Quantity := 1;
                                lReserEntry."Quantity (Base)" := 1;
                                lReserEntry."Qty. to Handle (Base)" := 1;
                                lReserEntry."Qty. to Invoice (Base)" := 1;
                                lReserEntry.Insert();
                            end;
                        until (lItemJnlLine.Next() = 0);
                    end;
                    lItemJnlLine.Reset();
                    lItemJnlLine.SetRange("Journal Template Name", ModeleFeuille);
                    lItemJnlLine.SetRange("Journal Batch Name", NomFeuille);
                    lItemJnlLine.SetRange("Document No.", ProductionOrder."No.");
                    if lItemJnlLine.FindSet() then begin
                        repeat
                            lReservationEntry.Reset();
                            lReservationEntry.SetRange("Source ID", lItemJnlLine."Journal Template Name");
                            lReservationEntry.SetRange("Source Batch Name", lItemJnlLine."Journal Batch Name");
                            lReservationEntry.SetRange("Source Ref. No.", lItemJnlLine."Line No.");
                            lReservationEntry.SetRange("Item No.", lItemJnlLine."Item No.");
                            lReservationEntry.SetRange("Source Type", 83);
                            lReservationEntry.Setrange("Source Subtype", 5);
                            if lReservationEntry.FindSet() then begin
                                ProdOrderComp.Reset();
                                ProdOrderComp.SetRange("Prod. Order No.", lItemJnlLine."Order No.");
                                ProdOrderComp.SetRange("Item No.", lItemJnlLine."Item No.");
                                ProdOrderComp.SetRange("Line No.", lItemJnlLine."Prod. Order Comp. Line No.");
                                If ProdOrderComp.FindSet() then begin
                                    ProductionBOMLine.Reset();
                                    ProductionBOMLine.SetRange(Type, ProductionBOMLine.Type::Item);
                                    ProductionBOMLine.SetRange("Production BOM No.", lItemJnlLine."Source No.");
                                    ProductionBOMLine.SetRange("Routing Link Code", ProdOrderComp."Routing Link Code");
                                    ProductionBOMLine.SetRange("No.", ProdOrderComp."Item No.");
                                    if ProductionBOMLine.FindSet() then begin
                                        lReservationEntry.Quantity := -ProductionBOMLine."Quantity per";
                                        lReservationEntry."Quantity (Base)" := -ProductionBOMLine."Quantity per";
                                        lReservationEntry."Qty. to Handle (Base)" := -ProductionBOMLine."Quantity per";
                                        lReservationEntry."Qty. to Invoice (Base)" := -ProductionBOMLine."Quantity per";
                                        lReservationEntry.Modify();
                                    end;
                                end;
                            end;
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
                        ItemJnlPostBatch.Run(lItemJnlLine);
                        SerialNoInformation.Reset();
                        SerialNoInformation.SetRange("Item No.", Item."No.");
                        SerialNoInformation.SetRange("Serial No.", SN);
                        If SerialNoInformation.FindSet() then
                            Report.Run(50019, false, true, SerialNoInformation);
                    end;
                    OFNO := '';
                    SN := '';
                    VariantCode := '';
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
        lItemJnlLine.SetRange("Journal Template Name", 'ARTICLE');
        lItemJnlLine.DeleteAll();
    end;

    var
        VariantCode: Code[10];
        OFNO: Code[20];
        SN: Text[50];
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        TrackingSpecification: Record "Tracking Specification";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        text001: Label 'Veuiller entrez la numéro d''OF';
        Text002: Label 'Veuillez entrer un numéro de série';
}
