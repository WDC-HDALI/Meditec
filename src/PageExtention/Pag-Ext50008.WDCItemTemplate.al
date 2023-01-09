pageextension 50008 "WDC Item Template" extends "Item Templ. Card"
{
    layout
    {
        addbefore(Blocked)
        {
            field("Old Customer Code"; Rec."Item Stage")
            {
                ApplicationArea = all;

            }
        }
        addbefore("Base Unit of Measure")
        {
            field("Packing Item"; Rec."Packing Item")
            {
                ApplicationArea = all;
            }
            field("Packaging Type"; Rec."Packaging Type")
            {
                ApplicationArea = all;
            }

        }
        addafter("Item Category Code")
        {
            field(SubCategorie; Rec.SubCategorie)
            {
                ApplicationArea = all;
            }
        }

    }
}
