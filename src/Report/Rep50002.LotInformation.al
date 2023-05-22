report 50002 "Lot Information"
{
    Caption = 'Lot Information';
    RDLCLayout = './src/Report/RDLC/LotNoInformation.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    WordMergeDataItem = LotNoInformation;
    dataset
    {
        dataitem(LotNoInformation; "Lot No. Information")
        {
            RequestFilterFields = "Lot No.";
            column(Description; Description)
            {
            }
            column(ExpiredInventory; "Expired Inventory")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(LotNo; "Lot No.")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TestQuality; "Test Quality")
            {
            }
            column(VariantCode; "Variant Code")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(CertificateNumber; "Certificate Number")
            {
            }
            column(Comment; Comment)
            {
            }
            column(VendorNo; VendorNo)
            {
            }
            column(ReceptionDate; ReceptionDate)
            {
            }
            column(ItemText; ItemText)
            {
            }
            trigger OnAfterGetRecord()
            var

                Item: Record Item;
                ItemLedgerEntry: Record "Item Ledger Entry";
                PurchRcptHeader: Record "Purch. Rcpt. Header";


            begin
                if Item.Get("Item No.") then
                    ItemText := Item.Description;
                ItemLedgerEntry.SetCurrentKey("Lot No.");
                ItemLedgerEntry.SetRange("Lot No.", "Lot No.");
                ItemLedgerEntry.SetRange("Item No.", "Item No.");
                ItemLedgerEntry.SetRange("Source Type", ItemLedgerEntry."Source Type"::Vendor);
                if ItemLedgerEntry.FindSet() then begin
                    VendorNo := ItemLedgerEntry."Source No.";
                    if PurchRcptHeader.Get(ItemLedgerEntry."Document No.") then
                        ReceptionDate := PurchRcptHeader."Expected Receipt Date";
                end;

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
    var
        VendorNo: code[20];
        ExpirationDate: date;
        ReceptionDate: date;
        ItemText: text;
}
