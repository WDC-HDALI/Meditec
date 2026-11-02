report 50021 WDCDeleteLines
{
    ApplicationArea = All;
    Caption = 'WDC Delete Lines';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(ModeleFeuille; ModeleFeuille)
                    {
                        ApplicationArea = all;
                    }
                    field(NomFeuille; NomFeuille)
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        var
                            lReserEntry: Record "Reservation Entry";
                        begin
                            lReserEntry.Reset();
                            lReserEntry.SetRange("Source ID", ModeleFeuille);
                            lReserEntry.SetRange("Source Batch Name", NomFeuille);
                            lReserEntry.DeleteAll();
                        end;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }


    }


    var
        ModeleFeuille: Text[20];
        NomFeuille: Text[20];
        ProductionOrderNo: Text[20];
        lItemJnlLine: Record "Item Journal Line";
}
