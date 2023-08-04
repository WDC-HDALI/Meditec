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
}

