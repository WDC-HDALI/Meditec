pageextension 50002 "WDC Item Card" extends "Item Card"
{
    /*******************************Documentation*************************************************
    //WDC02     WDC.IM      10/10/2024      Include MP In Exit Voucher
    //WDC03     WDC.IM      31/10/2024      Add Fields
    **********************************************************************************************/
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
            field("Transport cost"; Rec."Transport cost")
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
            //<<WDC02
            //field("Include In Exit Voucher"; Rec."Include In Exit Voucher")
            // {
            //     ApplicationArea = all;
            // }
            //>>WDC02
        }
        //<<WDC03
        addafter(GTIN)
        {
            field(SKU; Rec.SKU)
            {
                ApplicationArea = all;
            }
            field("Factory Code"; Rec."Factory Code")
            {
                ApplicationArea = all;
            }
            field("Retail Code"; Rec."Retail Code")
            {
                ApplicationArea = all;
            }
        }
        //>>WDC03
    }
}
