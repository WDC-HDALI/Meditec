pageextension 50010 "WDC Gen Journal Batch" extends 251
{
    layout
    {
        addafter(Description)
        {

            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = All;
            }
            field("Account No."; Rec."Account No.")
            {
                ApplicationArea = All;
            }
        }
    }
}