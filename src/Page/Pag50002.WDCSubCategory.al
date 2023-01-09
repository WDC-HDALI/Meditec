page 50002 "WDC SubCategory"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Sub-Category', FRA = 'Sous Catégorie';
    PageType = List;
    SourceTable = "WDC SubCategory";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                }

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
