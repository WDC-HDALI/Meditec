page 50003 "WDC Item Mussel"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Item Mussel', FRA = 'Moule article';
    PageType = List;
    SourceTable = "WDC Item Mussel";
    UsageCategory = Lists;
    Permissions = tabledata "WDC Item Mussel" = rimd;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
