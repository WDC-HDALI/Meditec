page 50025 "WDC Delete Package Line"
{
    CaptionML = ENU = 'Delete Package Line', FRA = 'Suppression ligne cartons';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = ALL;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(NCarton; NCarton)
                {
                    CaptionML = ENU = 'Carton NO.', FRA = 'N° carton';
                    trigger OnValidate()
                    var
                        CartonTrackingLines: Record "Carton Tracking Lines";
                        NbLigne: Decimal;
                    begin
                        CartonTrackingLines.Reset();
                        CartonTrackingLines.SetRange("Carton No.", NCarton);
                        NbLigne := CartonTrackingLines.Count;
                        CartonTrackingLines.DeleteAll();
                        Message('%1 Lignes ont été supprimées.', NbLigne);
                    end;
                }
            }
        }
    }
    var
        NCarton: Code[20];
}
