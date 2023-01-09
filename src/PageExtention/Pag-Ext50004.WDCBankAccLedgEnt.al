pageextension 50004 "WDC BankAccLedgEnt" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Currency Code")
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