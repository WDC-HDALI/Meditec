pageextension 50000 "WDC Customer Card" extends "Customer Card"
{
    layout
    {
        addbefore(Blocked)
        {
            field("Old Customer Code"; Rec."Old Customer Code")
            {
                ApplicationArea = all;

            }
        }
    }
}
