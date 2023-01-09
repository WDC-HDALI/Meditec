page 50000 "WDC Page"
{
    Caption = 'WDC Page ';
    ApplicationArea = Basic, Suite;
    PageType = List;
    SourceTable = "WDC Item Stage";
    Editable = false;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            field(""; WDCText)
            {
                ApplicationArea = all;
                Style = StrongAccent;
                RowSpan = 5;
            }
        }


    }
    actions
    {
        area(Creation)
        {
            action(Import)
            {
                RunObject = xmlport "WDC Import grand livre";
                Image = Import;
                ApplicationArea = all;
                CaptionML = FRA = 'Import grand livre', ENU = 'Ledger Import';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

            }
            action(Import2)
            {
                RunObject = xmlport "WDC Import Stock";
                Image = Import;
                ApplicationArea = all;
                CaptionML = FRA = 'Import stock';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
            }
        }

    }
    var
        WDCText: Label 'WEDATA CONSULT';
}
