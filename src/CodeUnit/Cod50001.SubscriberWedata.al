codeunit 50001 "Subscriber Wedata"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Templ. Mgt.", 'OnApplyTemplateOnBeforeItemModify', '', FALSE, FALSE)]
    local procedure OnApplyTemplateOnBeforeItemModify(var Item: Record Item; ItemTempl: Record "Item Templ.")
    begin

        Item.SubCategorie := ItemTempl.SubCategorie;
        Item."Packaging Type" := ItemTempl."Packaging Type";
        Item."Packing Item" := ItemTempl."Packing Item";
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterSalesLineCheck', '', FALSE, FALSE)]
    // Local procedure OnBeforePostPurchaseDoc(Var SalesLine: Record "Sales Line")
    // Var
    //     ltext001: Label 'Veuillez vérifier le code client d''article %1';
    //     lItem: Record Item;

    // begin
    //     If SalesLine.Type = SalesLine.Type::Item then
    //         If lItem.Get(SalesLine."No.") then
    //             if lItem."Customer Code" <> '' then
    //                 if SalesLine."Sell-to Customer No." <> lItem."Customer Code" then
    //                     Error(ltext001, SalesLine."No.");
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', FALSE, FALSE)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Initial Date" := GenJournalLine."Initial Date";
        GLEntry."Initial Document No." := GenJournalLine."Initial Document No.";
        GLEntry.Lettrage := GenJournalLine.Lettrage;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', FALSE, FALSE)]
    local procedure OnAfterInitCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Initial Date" := GenJournalLine."Initial Date";
        CustLedgerEntry."Initial Document No." := GenJournalLine."Initial Document No.";
        CustLedgerEntry.Lettrage := GenJournalLine.Lettrage;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', FALSE, FALSE)]
    local procedure OnAfterInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var GLRegister: Record "G/L Register")
    begin
        VendorLedgerEntry."Initial Date" := GenJournalLine."Initial Date";
        VendorLedgerEntry."Initial Document No." := GenJournalLine."Initial Document No.";
        VendorLedgerEntry.Lettrage := GenJournalLine.Lettrage;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', FALSE, FALSE)]
    local procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."Initial Date" := GenJournalLine."Initial Date";
        BankAccountLedgerEntry."Initial Document No." := GenJournalLine."Initial Document No.";
        BankAccountLedgerEntry.Lettrage := GenJournalLine.Lettrage;
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnSetUpNewLineOnBeforeIncrDocNo', '', FALSE, FALSE)]
    local procedure OnSetUpNewLineOnBeforeIncrDocNo(var GenJournalLine: Record "Gen. Journal Line"; LastGenJournalLine: Record "Gen. Journal Line"; var Balance: Decimal; var BottomLine: Boolean; var IsHandled: Boolean; var Rec: Record "Gen. Journal Line")
    begin
        GenJournalLine.validate("Account Type", LastGenJournalLine."Account Type");
        GenJournalLine.Validate("Account No.", LastGenJournalLine."Account No.");
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnSetUpNewLineOnBeforeSetBalAccount', '', FALSE, FALSE)]
    local procedure OnSetUpNewLineOnBeforeSetBalAccount(var GenJournalLine: Record "Gen. Journal Line"; LastGenJournalLine: Record "Gen. Journal Line"; var Balance: Decimal; var IsHandled: Boolean; GenJnlTemplate: Record "Gen. Journal Template"; GenJnlBatch: Record "Gen. Journal Batch"; BottomLine: Boolean; var Rec: Record "Gen. Journal Line"; CurrentFieldNo: Integer)
    begin
        rec.validate("Account Type", GenJnlBatch."Account Type");
        rec.Validate("Account No.", GenJnlBatch."Account No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', false, false)]
    local procedure OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var NextLineNo: Integer; var Handled: Boolean)
    var
        lSalesShipmentHeader: Record "Sales Shipment Header";
        text001: Label ' /doc. ext: %1';
    begin
        lSalesShipmentHeader.GET(SalesShptLine."Document No.");
        SalesLine.Description := CopyStr(SalesLine.Description + StrSubstNo(text001, lSalesShipmentHeader."External Document No."), 1, 100);
    end;

    //    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterSalesLineCheck', '', FALSE, FALSE)]
    // Local procedure OnBeforePostPurchaseDoc(Var SalesLine: Record "Sales Line")
    // Var
    //     ltext001: Label 'Veuillez vérifier le code client d''article %1';
    //     lCarton: Record Carton;

    // begin
    //     if SalesLine."Document Type"= SalesLine."Document Type"::Order Then 
    //     If SalesLine.Type = SalesLine.Type::Item then
    //             if lCarton."Customer Code" <> '' then
    //                 if SalesLine."Sell-to Customer No." <> lItem."Customer Code" then
    //                     Error(ltext001, SalesLine."No.");
    // end;
    // [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnBeforeTestStatusOpen', '', FALSE, FALSE)]
    // local procedure OnBeforeTestStatusOpen(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)

    // begin
    //     if (CallingFieldNo = 7) or (CallingFieldNo = 7) Then
    //         IsHandled := true;

    // end;
    //         [EventSubscriber(ObjectType::Page, PAGE::"Purchase Order", 'OnAfterValidateEvent', 'Ship-to Code', FALSE, FALSE)]
    //     local procedure OnAfterValidateEvent(var Rec: Record "Purchase Header")

    //     begin
    // Rec.TestStatusIsNotReleased()
    //     end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnBeforeInitExpirationDate', '', false, false)]
    local procedure OnBeforeInitExpirationDate(var TrackingSpecification: Record "Tracking Specification"; xRec: Record "Tracking Specification"; var IsHandled: Boolean)
    begin
        if TrackingSpecification."Source Type" = 5406 then
            if TrackingSpecification."Source Subtype" = TrackingSpecification."Source Subtype"::"3" Then begin
                TrackingSpecification."Lot No." := TrackingSpecification."Source ID";
                TrackingSpecification."Quantity (Base)" := 1;
            end;

    end;
    //<<WDC.IM
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptLine', '', FALSE, FALSE)]
    local procedure OnAfterInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    var
        ProdOrderComponent: Record "Prod. Order Component";
        ReserEntryComposant: Record "Reservation Entry";
        ReserEntryOT: Record "Reservation Entry";
        Existe: Boolean;
        SomQuantity: Decimal;
    begin
        ReserEntryOT.Reset();
        ReserEntryOT.SetRange("Item No.", TransLine."Item No.");
        ReserEntryOT.SetRange("Source ID", TransLine."Document No.");
        ReserEntryOT.SetRange("Source Prod. Order Line", TransLine."Line No.");
        if ReserEntryOT.FindSet() then begin
            repeat
                ProdOrderComponent.Reset();
                ProdOrderComponent.SetRange("Prod. Order No.", TransLine."Prod. Order No.");
                ProdOrderComponent.SetRange("Prod. Order Line No.", TransLine."Prod. Order Line");
                ProdOrderComponent.SetRange("Routing Link Code", TransLine."Routing Link Code");
                ProdOrderComponent.SetRange("Item No.", TransLine."Item No.");
                if ProdOrderComponent.FindSet() then begin
                    ReserEntryComposant.Reset();
                    ReserEntryComposant.SetCurrentKey("Item No.", "Variant Code", "Location Code", "Reservation Status", "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.", "Package No.");
                    ReserEntryComposant.SetRange("Item No.", ProdOrderComponent."Item No.");
                    ReserEntryComposant.SetRange("Source ID", ProdOrderComponent."Prod. Order No.");
                    ReserEntryComposant.SetRange("Source Prod. Order Line", ProdOrderComponent."Prod. Order Line No.");
                    ReserEntryComposant.SetRange("Source Ref. No.", ProdOrderComponent."Line No.");
                    If ReserEntryComposant.FindSet() then begin
                        Existe := true;
                        SomQuantity := CalSomQty(ProdOrderComponent."Item No.", ProdOrderComponent."Prod. Order No.", ProdOrderComponent."Prod. Order Line No.");
                        repeat
                            if ReserEntryComposant."Lot No." = ReserEntryOT."Lot No." then begin
                                Existe := false;
                                If TransLine."Qty. to Receive" > ProdOrderComponent."Remaining Quantity" then
                                    ReserEntryComposant.Validate("Quantity (Base)", (ProdOrderComponent."Remaining Quantity" - SomQuantity + ReserEntryComposant."Quantity (Base)" * (-1)) * (-1))
                                else if (ReserEntryOT."Quantity (Base)" + SomQuantity) < ProdOrderComponent."Remaining Quantity" then
                                    ReserEntryComposant.Validate("Quantity (Base)", (ReserEntryOT."Quantity (Base)" + ReserEntryComposant."Quantity (Base)" * (-1)) * (-1))
                                else
                                    ReserEntryComposant.Validate("Quantity (Base)", (ProdOrderComponent."Remaining Quantity" - SomQuantity) * (-1));
                                ReserEntryComposant.Modify(true);
                            end;
                        until (ReserEntryComposant.Next() = 0);
                        If Existe = true then begin
                            Clear(ReserEntryComposant);
                            ReserEntryComposant.Init();
                            ReserEntryComposant."Entry No." := ReserEntryComposant.GetLastEntryNo + 1;
                            ReserEntryComposant.Positive := false;
                            ReserEntryComposant."Item Tracking" := ReserEntryComposant."Item Tracking"::"Lot No.";
                            ReserEntryComposant."Item No." := ProdOrderComponent."Item No.";
                            ReserEntryComposant."Location Code" := TransLine."Transfer-to Code";
                            ReserEntryComposant.Validate("Qty. per Unit of Measure", ProdOrderComponent."Qty. per Unit of Measure");
                            If TransLine."Qty. to Receive" > ProdOrderComponent."Remaining Quantity" then
                                ReserEntryComposant.Validate("Quantity (Base)", (ProdOrderComponent."Remaining Quantity" - SomQuantity) * (-1))
                            else if (ReserEntryOT."Quantity (Base)" + SomQuantity) < ProdOrderComponent."Remaining Quantity" then
                                ReserEntryComposant.Validate("Quantity (Base)", ReserEntryOT."Quantity (Base)" * (-1))
                            else
                                ReserEntryComposant.Validate("Quantity (Base)", (ProdOrderComponent."Remaining Quantity" - SomQuantity) * (-1));
                            ReserEntryComposant."Reservation Status" := ReserEntryComposant."Reservation Status"::Surplus;
                            ReserEntryComposant."Creation Date" := WorkDate();
                            ReserEntryComposant."Source Type" := 5407;
                            ReserEntryComposant."Source Subtype" := 3;
                            ReserEntryComposant."Source ID" := ProdOrderComponent."Prod. Order No.";
                            ReserEntryComposant."Source Prod. Order Line" := ProdOrderComponent."Prod. Order Line No.";
                            ReserEntryComposant."Source Ref. No." := ProdOrderComponent."Line No.";
                            ReserEntryComposant."Created By" := USERID;
                            ReserEntryComposant."Planning Flexibility" := ReserEntryComposant."Planning Flexibility"::Unlimited;
                            ReserEntryComposant."Lot No." := ReserEntryOT."Lot No.";
                            ReserEntryComposant."Item Tracking" := ReserEntryComposant."Item Tracking"::"Lot No.";
                            ReserEntryComposant.INSERT(true);
                        end
                    end else begin
                        Clear(ReserEntryComposant);
                        ReserEntryComposant.Init();
                        ReserEntryComposant."Entry No." := ReserEntryComposant.GetLastEntryNo + 1;
                        ReserEntryComposant.Positive := false;
                        ReserEntryComposant."Item Tracking" := ReserEntryComposant."Item Tracking"::"Lot No.";
                        ReserEntryComposant."Item No." := ProdOrderComponent."Item No.";
                        ReserEntryComposant."Location Code" := TransLine."Transfer-to Code";
                        ReserEntryComposant.Validate("Qty. per Unit of Measure", ProdOrderComponent."Qty. per Unit of Measure");
                        If TransLine."Qty. to Receive" > ProdOrderComponent."Remaining Quantity" then
                            ReserEntryComposant.Validate("Quantity (Base)", ProdOrderComponent."Remaining Quantity" * (-1))
                        else
                            ReserEntryComposant.Validate("Quantity (Base)", ReserEntryOT."Quantity (Base)" * (-1));
                        ReserEntryComposant."Reservation Status" := ReserEntryComposant."Reservation Status"::Surplus;
                        ReserEntryComposant."Creation Date" := WorkDate();
                        ReserEntryComposant."Source Type" := 5407;
                        ReserEntryComposant."Source Subtype" := 3;
                        ReserEntryComposant."Source ID" := ProdOrderComponent."Prod. Order No.";
                        ReserEntryComposant."Source Prod. Order Line" := ProdOrderComponent."Prod. Order Line No.";
                        ReserEntryComposant."Source Ref. No." := ProdOrderComponent."Line No.";
                        ReserEntryComposant."Created By" := USERID;
                        ReserEntryComposant."Planning Flexibility" := ReserEntryComposant."Planning Flexibility"::Unlimited;
                        ReserEntryComposant."Lot No." := ReserEntryOT."Lot No.";
                        ReserEntryComposant."Item Tracking" := ReserEntryComposant."Item Tracking"::"Lot No.";
                        ReserEntryComposant.INSERT(true);
                    end;
                end;
            until (ReserEntryOT.Next() = 0);
        end;
    end;

    local procedure CalSomQty(pItem: Code[20]; pProdOrderNo: Code[20]; pProdOrderLineNo: Integer): Decimal;
    var
        lReservationEntry: Record "Reservation Entry";
    begin
        lReservationEntry.Reset();
        lReservationEntry.SetCurrentKey("Item No.", "Variant Code", "Location Code", "Reservation Status", "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.", "Package No.");
        lReservationEntry.SetRange("Item No.", pItem);
        lReservationEntry.SetRange("Source ID", pProdOrderNo);
        lReservationEntry.SetRange("Source Prod. Order Line", pProdOrderLineNo);
        If lReservationEntry.FindSet() then begin
            lReservationEntry.CalcSums("Quantity (Base)");
            exit(lReservationEntry."Quantity (Base)" * (-1));
        end;
    end;
    //>>WDC.IM
    //<< WDC.IM Déclaration production 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeRunProductionJnl', '', FALSE, FALSE)]
    local procedure OnBeforeRunProductionJnl(ToTemplateName: Code[10]; ToBatchName: Code[10]; ProdOrder: Record "Production Order"; ActualLineNo: Integer; PostingDate: Date; var IsHandled: Boolean)
    begin
        if ProdOrder.DeclProd = true then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertConsumptionJnlLine', '', FALSE, FALSE)]
    local procedure OnBeforeInsertConsumptionJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComp: Record "Prod. Order Component"; ProdOrderLine: Record "Prod. Order Line"; Level: Integer)
    var
        ProdOrder: Record "Production Order";
        ProductionBOMLine: Record "Production BOM Line";
    begin
        if ProdOrder.Get(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.") then
            if ProdOrder.DeclProd = true then begin
                ItemJournalLine."Journal Template Name" := 'Sortie';
                ItemJournalLine."Journal Batch Name" := 'PRODPF';
                ProductionBOMLine.Reset();
                ProductionBOMLine.SetRange(Type, ProductionBOMLine.Type::Item);
                ProductionBOMLine.SetRange("Production BOM No.", ProdOrderLine."Item No.");
                ProductionBOMLine.SetRange("Routing Link Code", ProdOrderComp."Routing Link Code");
                ProductionBOMLine.SetRange("No.", ProdOrderComp."Item No.");
                if ProductionBOMLine.FindSet() then
                    if ItemJournalLine.Quantity <> 0 then
                        ItemJournalLine.Validate(Quantity, ProductionBOMLine."Quantity per");
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertOutputJnlLine', '', FALSE, FALSE)]
    local procedure OnBeforeInsertOutputJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderRtngLine: Record "Prod. Order Routing Line"; ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrder: Record "Production Order";
    begin
        if ProdOrder.Get(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.") then
            if ProdOrder.DeclProd = true then begin
                ItemJournalLine."Journal Template Name" := 'Sortie';
                ItemJournalLine."Journal Batch Name" := 'PRODPF';
                ItemJournalLine.Validate("Output Quantity", 1);
            end;
    end;
    //>> WDC.IM

    //<<WDC.IM Il faut insérer tous les articles du carton dans la commande
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', FALSE, FALSE)]
    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lCartTrackLines: Record "Carton Tracking Lines";
        lCartTrackLines2: Record "Carton Tracking Lines";
        lcarton: Record Carton;
        CartonNo: Code[20];
    begin
        lCartTrackLines.Reset();
        lCartTrackLines.SetCurrentKey("Customer No.", "Carton No.", "Order No.");
        lCartTrackLines.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
        lCartTrackLines.SetRange("Order No.", SalesHeader."No.");
        if lCartTrackLines.FindSet() then begin
            CartonNo := '';
            repeat
                if CartonNo <> lCartTrackLines."Carton No." then begin
                    lcarton.Get(lCartTrackLines."Carton No.");
                    lCartTrackLines2.Reset();
                    lCartTrackLines2.SetRange("Carton No.", lcarton."No.");
                    if lCartTrackLines2.FindSet() then
                        repeat
                            if lCartTrackLines2."Order No." <> SalesHeader."No." then
                                Error('Merci d''insérer tous les articles du carton N°: %1', lCartTrackLines2."Carton No.");
                        until (lCartTrackLines2.Next() = 0);
                    CartonNo := lCartTrackLines."Carton No.";
                end;
            until (lCartTrackLines.Next() = 0)

        end;
    end;
    //>>WDC.IM
}

