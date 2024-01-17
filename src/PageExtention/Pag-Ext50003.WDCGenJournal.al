pageextension 50003 "WDC GenJournal" extends "General Journal"
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
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = All;
            }
        }
    }
}