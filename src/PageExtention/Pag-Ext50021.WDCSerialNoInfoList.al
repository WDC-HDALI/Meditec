pageextension 50021 "WDC Serial No. Info List" extends "Serial No. Information List"
{
    layout
    {
        addafter(Inventory)
        {
            field("Assembled in Carton"; Rec."Assembled in Carton")
            {
                ApplicationArea = all;

            }
            field(shipped; Rec.shipped)
            {
                ApplicationArea = all;

            }

        }
    }
}
