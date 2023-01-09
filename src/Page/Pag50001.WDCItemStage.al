page 50001 "WDC Item Stage"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Item Stage', FRA = 'Etage article';
    PageType = List;
    SourceTable = "WDC Item Stage";
    UsageCategory = Lists;
    ///AccessByPermission= '026be21d-5b33-40d9-b637-5af19643d0ad';
    Permissions = tabledata "WDC Item Stage" = rimd;

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
