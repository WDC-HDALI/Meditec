pageextension 50031 "WDC Posted Sales Shipment" extends "Posted Sales Shipment"
{
    actions
    {
        addafter("&Print")
        {
            action(PrintPackingList)
            {
                CaptionML = ENU = 'Print Packing List', FRA = 'Imprimer liste de colisage';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    SalesShipmentHeader: Record "Sales Shipment Header";
                    WDCPackingList: Report "WDC Packing List";
                begin
                    SalesShipmentHeader.Reset();
                    SalesShipmentHeader.SetRange("No.", Rec."No.");
                    Report.Run(50022, true, true, SalesShipmentHeader);
                end;
            }
        }
    }
}
