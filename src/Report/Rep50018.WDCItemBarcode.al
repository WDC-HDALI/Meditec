report 50018 "WDC Item Barcode"
{
    Caption = 'Liset Code à barre cartons emballage';
    RDLCLayout = './src/Report/RDLC/BarcodeItem.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");//where("Packaging Type" = filter(carton));
            RequestFilterFields = "No.";

            column(No_; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(ItemNo; ItemNo)
            {
            }

            trigger OnAfterGetRecord()
            var
                BarcodeSymbolygy: Enum "Barcode Symbology";
                BracodesFontProvider: Interface "Barcode Font Provider";
                BarcodeString: Text;

            begin
                BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;
                BarcodeString := "No.";
                BracodesFontProvider.ValidateInput(BarcodeString, BarcodeSymbolygy);
                ItemNo := BracodesFontProvider.EncodeFont(BarcodeString, BarcodeSymbolygy);
            end;
        }
    }
    var
        ItemNo: text[250];

}
