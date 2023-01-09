tableextension 50013 "WDC GLAccount" extends "G/L Account"
{
    fields
    {
        field(50000; "GLEntry Type Filter"; Enum "WDC Entry Type")
        {
            CaptionML = ENU = 'G/L Entry Type Filter', FRA = 'Filtre type écriture';
            FieldClass = FlowFilter;
        }
    }

}