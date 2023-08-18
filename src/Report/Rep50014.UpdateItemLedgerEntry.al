report 50014 "Update Item Ledger Entry"
{
    Caption = 'Update Item Ledger Entry';
    ProcessingOnly = true;
    Permissions = TableData "Value Entry" = rimd, tabledata "Purch. Rcpt. Line" = rimd;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Entry No.";
            trigger OnPreDataItem()
            var

            begin
                ItemLedgerEntry.SetRange("Location Code", 'MAG-MC');
                //ItemLedgerEntry.SetFilter("Entry No.", '%1|%2', 1289, 1290);
            end;

            trigger OnPostDataItem()
            begin
                Message('Mise à jour avec succès');
            end;

            trigger OnAfterGetRecord()
            var
                PurchRcptLine: record "Purch. Rcpt. Line";
                ValueEntry: Record "Value Entry";
                Item: Record Item;
            begin
                if Item.get(ItemLedgerEntry."Item No.") then begin
                    Item.Validate("Inventory Posting Group", 'CONS');
                    Item.Validate("Gen. Prod. Posting Group", 'CONS');
                    Item.Modify();
                end;
                IF PurchRcptLine.get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.") THEN;
                PurchRcptLine.Validate("Posting Group", 'CONS');
                PurchRcptLine.Validate("Gen. Prod. Posting Group", 'CONS');
                PurchRcptLine.Modify();
                ValueEntry.reset();
                ValueEntry.SetRange("Posting Date", PurchRcptLine."Posting Date");
                ValueEntry.SetRange("Document No.", PurchRcptLine."Document No.");
                ValueEntry.SetRange("Item No.", PurchRcptLine."No.");
                if ValueEntry.FindSet() then
                    repeat
                        ValueEntry.Validate("Inventory Posting Group", 'CONS');
                        ValueEntry.Validate("Gen. Prod. Posting Group", 'CONS');
                        ValueEntry.Modify();
                    until ValueEntry.Next() = 0;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
