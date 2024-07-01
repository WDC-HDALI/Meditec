tableextension 50000 "WDC Customer" extends customer
{
    //WDC02  18/01/2024  WDC.CHG  ADD A NEW FIELD

    DrillDownPageID = "Customer List"; //WDC01.CHG
    LookupPageID = "Customer List"; //WDC01.CHG
    fields
    {
        field(50000; "Old Customer Code"; Code[20])
        {
            CaptionML = FRA = 'Ancien code client', ENU = 'Old Customer Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "Customer Abreviation"; Code[20]) //WDC02
        {
            CaptionML = FRA = 'Abréviation client ', ENU = 'Customer Abreviation';
            DataClassification = ToBeClassified;
        }

    }
}
