report 50023 "Update Purch. Rcpt. Line"
{
    ApplicationArea = All;
    Caption = 'Update Purch. Rcpt. Line';
    UsageCategory = Administration;
    Permissions = tabledata "Purch. Rcpt. Line" = rimd;
    ProcessingOnly = true;
    dataset
    {
        dataitem(PurchRcptLine; "Purch. Rcpt. Line")
        {
            DataItemTableView = where("Document No." = filter('RCA24-0122|RCA24-0155'));
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                // PurchRcptLine."VAT Bus. Posting Group" := 'ETRANGER';
                // PurchRcptLine.Modify();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
