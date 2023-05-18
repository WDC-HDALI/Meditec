page 50011 "WDC Posted Assembly Orders"
{

    Caption = 'Liste des cartons assemblés';
    CardPageID = "Posted Assembly Order";
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = "Posted Assembly Header";
    SourceTableView = SORTING("Posting Date")
                      ORDER(Descending);
    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the number of the assembly order that the posted assembly order line originates from.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the description of the posted assembly item.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the date when the assembly order was posted.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the date when the assembled item is due to be available for use.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the date on which the posted assembly order started.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the date when the posted assembly order finished, which means the date on which all assembly items were output.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the posted assembly item.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies how many units of the assembly item were posted with this posted assembly order.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
            }
        }


    }
}

