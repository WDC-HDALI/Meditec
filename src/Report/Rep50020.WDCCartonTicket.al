report 50020 "WDC Carton Ticket"
{
    Caption = 'Ticket Carton';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/CartonTicket.rdl';
    PreviewMode = PrintLayout;

    dataset
    {

        dataitem(Carton; Carton)
        {
            RequestFilterFields = "No.";

            column(Carton_No_; "No.")
            {

            }
            column(SerialCarton; SerialCarton)
            {

            }
            column(SNCart_Num; "Serial No.")
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Quantity; TotalQty)
            {

            }
            dataitem("Carton Tracking Lines"; "Carton Tracking Lines")
            {
                DataItemLink = "Carton No." = field("No.");
                DataItemLinkReference = carton;


                column(Serial_No_; "Serial No.")
                {

                }
                column(SerialNoBarcode; SerialItem)
                {

                }
                column(Description; "Item Description")
                {

                }
                column(Item_No_; "Item No.")
                {

                }



                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                    ItemRef: Record "Item Reference";
                    Variant: Record "Item Variant";
                begin
                    Clear(BarcodeString);
                    BarcodeString := "Serial No.";
                    BracodesFontProvider.ValidateInput(BarcodeString, BarcodeSymbolygy);
                    SerialItem := BracodesFontProvider.EncodeFont(BarcodeString, BarcodeSymbolygy);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TotalQty := 0;
                Clear(BracodesFontProvider);
                Clear(BarcodeSymbolygy);
                Clear(BarcodeStringSNCarton);
                BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;
                BarcodeStringSNCarton := "Serial No.";
                BracodesFontProvider.ValidateInput(BarcodeStringSNCarton, BarcodeSymbolygy);
                SerialCarton := BracodesFontProvider.EncodeFont(BarcodeStringSNCarton, BarcodeSymbolygy);

                CartonTrackLine.Reset();
                CartonTrackLine.SetCurrentKey("Carton No.", "Item No.", "Ref Line No.", "Serial No.", "Customer No.");
                CartonTrackLine.SetRange("Carton No.", "No.");
                if CartonTrackLine.FindFirst() then
                    repeat
                        TotalQty += CartonTrackLine.Quantity;
                    until CartonTrackLine.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
                Carton.Reset();
                Carton.SetFilter("No.", cartonfilter);

            end;
        }

    }


    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(cartonfilter; cartonfilter)
                    {
                        ApplicationArea = Basic, Suite;
                        TableRelation = "Carton Tracking Lines";
                    }

                }
            }
        }
    }
    var
        SerialItem: Text;
        SerialCarton: Text;
        BarcodeSymbolygy: Enum "Barcode Symbology";
        BracodesFontProvider: Interface "Barcode Font Provider";
        BarcodeString: Text;
        BarcodeStringSNCarton: Text;
        CartonTrackLine: Record "Carton Tracking Lines";
        TotalQty: Integer;
        cartonfilter: Code[20];

}
