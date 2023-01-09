table 50001 "WDC SubCategory"
{
    CaptionML = ENU = 'SubCategory', FRA = 'Sous Catégorie';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC SubCategory";
    DrillDownPageId = "WDC SubCategory";
    fields
    {
        field(1; "Item Category Code"; Code[20])
        {
            CaptionML = FRA = 'Code Catégorie', ENU = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
        }
        field(2; Code; Code[20])
        {
            CaptionML = FRA = 'Code', ENU = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            CaptionML = FRA = 'Description', ENU = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Item Category Code", Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(code; Description)
        {

        }

    }
}
