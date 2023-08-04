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
            }
        }
    }



    var
        TotalQte: Decimal;
        CurrDocNo: Code[20];
        CurrItemNo: Code[20];
        CurrLocation: Code[20];
        CurrDocLineNo: Integer;
        DocQty: Decimal;
        CurrDocType: enum "Sales Document Type";
}
