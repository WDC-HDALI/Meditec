tableextension 50000 "WDC Customer" extends customer
{
    fields
    {
        field(50000; "Old Customer Code"; Code[20])
        {
            CaptionML = FRA = 'Ancien code client', ENU = 'Old Customer Code';
            DataClassification = ToBeClassified;
        }
    }
}
