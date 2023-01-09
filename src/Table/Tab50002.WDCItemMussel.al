table 50002 "WDC Item Mussel"
{
    CaptionML = ENU = 'Mussel', FRA = 'Moule';
    DataClassification = ToBeClassified;
    Permissions = tabledata "WDC Item Mussel" = rimd;
    LookupPageId = "WDC Item Mussel";
    DrillDownPageId = "WDC Item Mussel";
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
