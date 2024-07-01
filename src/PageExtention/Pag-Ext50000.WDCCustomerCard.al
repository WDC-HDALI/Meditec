pageextension 50000 "WDC Customer Card" extends "Customer Card"
{
    //WDC02  18/01/2024   WDC.CHG  ADD NEW FIELD 
    layout
    {
        addbefore(Blocked)
        {
            field("Old Customer Code"; Rec."Old Customer Code")
            {
                ApplicationArea = all;

            }
        }
        addafter(Name)
        {
            field("Customer Abreviation"; Rec."Customer Abreviation")//WDC02
            {
                ApplicationArea = all;
            }
        }
    }
}
