tableextension 50016 "WDCSalesHeader" extends "Sales Header"
{
    fields
    {
        field(50000; "Border Code No"; Code[20])
        {
            CaptionML = ENU = 'Border Code No', FRA = 'N° code frontière';
            TableRelation = "Border Code";
            DataClassification = ToBeClassified;
        }
    }
}
