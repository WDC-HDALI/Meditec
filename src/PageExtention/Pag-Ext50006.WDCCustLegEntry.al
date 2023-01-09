pageextension 50006 "WDC CustLegEntry" extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Initial Date"; Rec."Initial Date")
            {
                ApplicationArea = All;
            }
            field("Initial Document No."; Rec."Initial Document No.")
            {
                ApplicationArea = All;
            }
            field(Lettrage; Rec.Lettrage)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {

    }
}