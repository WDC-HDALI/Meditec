page 50025 "WDC Delete Package Line"
{
    CaptionML = ENU = 'Update carton', FRA = 'Mise à jour carton';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = ALL;

    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Générale';

                field(NCarton; NCarton)
                {
                    CaptionML = ENU = 'Carton NO.', FRA = 'N° carton';
                    trigger OnValidate()
                    var
                        Carton: Record "Carton";
                    begin
                        Carton.Init();
                        Carton."No." := '004169';
                        Carton."Customer No." := 'C00011';
                        Carton."Customer Name" := 'DECATHLON';
                        Carton.Status := Carton.Status::Release;
                        Carton."Assembly Date" := DMY2Date(04, 12, 2025);
                        Carton."Item Carton No." := '030010007';
                        Carton."Item Description" := 'CARTON SNOWBOARDS 1700*110*330';
                        Carton."Lot No." := '657/2025';
                        Carton."Serial No." := 'DECATHLON-004169';
                        Carton.Insert();
                    end;
                }

            }
        }
    }
    var
        NCarton: Code[20];
        NProdOrder: Code[20];
        SourceID: Code[20];
        TransferOrder: Code[20];
        EntryNO: Code[20];
}
