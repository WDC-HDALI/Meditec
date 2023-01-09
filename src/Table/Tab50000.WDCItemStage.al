table 50000 "WDC Item Stage"
{
    CaptionML = ENU = 'Stage', FRA = 'Etage';
    DataClassification = ToBeClassified;
    Permissions = tabledata "WDC Item Stage" = rimd;
    LookupPageId = "WDC Item Stage";
    DrillDownPageId = "WDC Item Stage";
    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = FRA = 'Code', ENU = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            CaptionML = FRA = 'Description', ENU = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
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
