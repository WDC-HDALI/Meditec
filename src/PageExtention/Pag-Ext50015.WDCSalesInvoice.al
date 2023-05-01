pageextension 50015 "WDC Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter("Transport Method")
        {
            field("Border Code No"; Rec."Border Code No")
            {
                ApplicationArea = All;
            }
        }
    }
}
