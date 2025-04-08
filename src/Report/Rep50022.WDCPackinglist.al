report 50022 "WDC Packing List"
{
    /************************************Documentation***********************************************
    WDC01   26/12/2024  WDC.IM  Create Current Object
    *************************************************************************************************/
    CaptionML = ENU = 'Packing list', FRA = 'Liste de colisage';
    RDLCLayout = './src/Report/RDLC/Packinglist.rdl';
    Description = 'Liste de colisage';

    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";
            column(Posting_Date; "Posting Date")
            {
            }
            column(No; "No.")
            {
            }
            dataitem(SalesShipmentLine; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = SalesShipmentHeader;
                DataItemTableView = SORTING("Document No.", "Line No.") where(Quantity = filter(<> 0));
                column(ItemNo; SalesShipmentLine."No.")
                {
                }
                column(Description; SalesShipmentLine.Description)
                {
                }
                column(Type; Item.Type)
                {
                }
                column(GrossWeight; Item."Gross Weight")
                {
                }
                column(Order_No_; "Order No.")
                { }
                column(Variant_Code; "Variant Code")
                { }
                dataitem(CartonTrackingLines; "Carton Tracking Lines")
                {
                    DataItemLink = "Order No." = field("Order No."), "Item No." = field("No."),
                                                                    "Variant Code" = field("Variant Code");
                    DataItemLinkReference = SalesShipmentLine;
                    column(Carton_No_; "Carton No.")
                    { }
                    column(Lot_No_; "Serial No.")
                    { }
                    column(Quantity; Quantity)
                    { }
                    column(Net_Weight; Item."Net Weight")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        CartonTrackingLines.CalcFields("Entry No. doc");
                        CartonTrackingLines."Entry No. Filter" := CartonTrackingLines."Entry No. doc";
                        CartonTrackingLines.CalcFields("Shipment No.");
                        if CartonTrackingLines."Shipment No." <> SalesShipmentLine."Document No." then
                            CurrReport.Break();
                    end;
                }
                trigger OnAfterGetRecord()
                var
                begin
                    Item.Get(SalesShipmentLine."No.");
                end;
            }
        }
    }
    var
        Item: Record Item;
}
