page 50015 "Carton List"
{
    ApplicationArea = All;
    Caption = 'Liste cartons';
    PageType = List;
    SourceTable = Carton;
    SourceTableView = sorting("No.") where(Status = filter(Open));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Carton Card";

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
                field("Assembly Date"; Rec."Assembly Date")
                {
                    ApplicationArea = All;
                }
                field("Item Carton No."; Rec."Item Carton No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;

                }

                field("Ship to code"; Rec."Ship to code")
                {
                    ApplicationArea = All;

                }
                field("Ship to name"; Rec."Ship to name")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}
