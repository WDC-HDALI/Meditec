pageextension 50013 "WDC Posted Sales Invoice" extends "Posted Sales Invoice"
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
