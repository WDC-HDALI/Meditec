tableextension 50022 "WDC Item Variant" extends "Item Variant"
{
    fields
    {
        field(50000; SKU; Text[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'SKU', FRA = 'SKU';
        }
        field(50001; "Retail Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Retail Code', FRA = 'Retail Code';
        }
    }
}
