page 50019 "Closed Carton Track. Lines"
{
    Caption = 'Lignes traçabilités cartons';
    PageType = ListPart;
    SourceTable = "Carton Tracking Lines";
    Editable = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;

                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Carton No."; Rec."Carton No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
