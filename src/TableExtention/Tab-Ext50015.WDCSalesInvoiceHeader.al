tableextension 50015 "WDC Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Border Code No"; Code[20])
        {
            //Caption = 'Border Code No';
            CaptionML = ENU = 'Border Code No', FRA = 'N° code frontière';
            TableRelation = "Border Code";
            DataClassification = ToBeClassified;
        }
    }
}
