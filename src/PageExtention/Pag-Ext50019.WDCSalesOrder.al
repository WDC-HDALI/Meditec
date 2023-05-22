pageextension 50019 "WDC Sales Order" extends "Sales Order"
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
