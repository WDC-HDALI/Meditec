page 50016 "Closed Carton List"
{

    Caption = 'Liste cartons fermés';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Carton;
    SourceTableView = sorting("No.") where(Status = filter(Release));
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "Closed Carton Card";
    ApplicationArea = all;

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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Serial No."; Rec."Serial No.")
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
                field("Not Tot. shipped"; Rec."Not Tot. Ordered")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}
