pageextension 50019 "WDC Item Variants" extends "Item Variants"
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
