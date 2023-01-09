tableextension 50012 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Posting Allowed From"; Date)
        {
            CalcFormula = Min("Accounting Period"."Starting Date" WHERE("Fiscally Closed" = FILTER(false)));
            Caption = 'Posting Allowed From';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Posting Allowed To"; Date)
        {
            CalcFormula = Max("Accounting Period"."Starting Date" WHERE("New Fiscal Year" = FILTER(true),
                                                                         "Fiscally Closed" = FILTER(false)));
            Caption = 'Posting Allowed To';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Local Currency"; Option)
        {
            Caption = 'Local Currency';
            OptionCaption = 'Euro,Other';
            OptionMembers = Euro,Other;

            trigger OnValidate()
            begin
                if "Local Currency" = "Local Currency"::Euro then
                    "Currency Euro" := '';
            end;
        }
        field(50003; "Currency Euro"; Code[10])
        {
            Caption = 'Currency Euro';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if ("Local Currency" = "Local Currency"::Euro) and ("Currency Euro" <> '') then
                    Error(
                      Text10802,
                      FieldCaption("Currency Euro"),
                      FieldCaption("Local Currency"),
                      "Local Currency");
            end;
        }
    }
    var
        Text10802: Label 'It is not allowed to specify %1 when %2 is %3.';
}