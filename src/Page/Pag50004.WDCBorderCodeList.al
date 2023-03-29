page 50004 "WDC Border Code List"
{
    CaptionML = ENU = 'WDC Border Code List', FRA = 'Liste des code frontière';
    PageType = List;
    SourceTable = "Border Code";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
