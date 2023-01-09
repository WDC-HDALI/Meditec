enum 50000 "WDC Packing Type"
{
    value(0; " ") { }
    value(1; Carton) { CaptionML = ENU = 'Carton'; }
    value(2; Pallet) { CaptionML = ENU = 'Pallet', FRA = 'Palette'; }
    value(3; Other) { CaptionML = ENU = 'Other', FRA = 'Autre'; }

}