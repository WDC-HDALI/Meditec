pageextension 50001 "WDC Vendor Card" extends "Vendor Card"
{
    layout
    {
        addbefore(Blocked)
        {
            field("Old Customer Code"; Rec."Old Vendor Code")
            {
                ApplicationArea = all;

            }
        }
    }
}
