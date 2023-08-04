pageextension 50018 "WDC Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;

            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;

            }
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                ApplicationArea = all;
            }
            field("Routing Link Code"; Rec."Routing Link Code")
            {
                ApplicationArea = all;
            }

        }
    }
}
