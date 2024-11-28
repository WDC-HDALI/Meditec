page 50007 "Exit Voucher Lines"
{
    Caption = 'Lignes bon sortie';
    PageType = ListPart;
    SourceTable = "Exit Voucher Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")//WDC.IM
                {
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Inventory);
                    end;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Inventory);
                    end;

                }

                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Machine reference"; Rec."Machine reference")
                {
                    ApplicationArea = All;

                }

                field("Machine Name"; Rec."Machine Name")
                {
                    ApplicationArea = All;

                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ApplicationArea = All;

                }
                field("Work Center Name"; Rec."Work Center Name")
                {
                    ApplicationArea = All;

                }

            }
        }
    }
}
