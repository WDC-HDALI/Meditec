table 50003 "Border Code"
{
    Caption = 'Border Code';
    DataClassification = ToBeClassified;
    DrillDownPageId = "WDC Border Code List";
    LookupPageId = "WDC Border Code List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
