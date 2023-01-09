pageextension 50002 "WDC Item Card" extends "Item Card"
{
    layout
    {
        addbefore(Blocked)
        {
            field("Item Stage"; Rec."Item Stage")
            {
                ApplicationArea = all;

            }
            field("Item Mussel"; Rec."Item Mussel")
            {
                ApplicationArea = all;

            }
            field("Customer Code"; Rec."Customer Code")
            {
                ApplicationArea = all;
                ShowMandatory = true;
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
