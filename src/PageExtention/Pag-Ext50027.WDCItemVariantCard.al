pageextension 50027 "WDC Item Variant Card" extends "Item Variant Card"
{
    layout
    {
        addafter(Description)
        {
            field("SKU"; Rec."SKU")
            {
                ApplicationArea = All;
            }
            field("Retail Code"; Rec."Retail Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
