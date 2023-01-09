tableextension 50001 "WDC Vendor" extends Vendor
{
    fields
    {
        field(50000; "Old Vendor Code"; Code[20])
        {
            CaptionML = FRA = 'Ancien code fournisseur', ENU = 'Old Vendor Code';
            DataClassification = ToBeClassified;
        }
    }
}

