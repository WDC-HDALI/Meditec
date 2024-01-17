report 50019 "WDC PF Ticket"
{
    Caption = 'Ticket produit fini';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/PfTicket.rdl';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(SerialNoInformation; "Serial No. Information")
        {
            RequestFilterFields = "Serial No.";
            column(Serial_No_; "Serial No.")
            {

            }
            column(SerialNoBarcode; SerialNo)
            {

            }
            column(Description; Description)
            {

            }
            column(Item_No_; "Item No.")
            {

            }
            column(FactoryCode; FactoryCode)
            {

            }
            column(RetailCode; RetailCode)
            {

            }

            column(FactoryCodeBarreCode; FactoryCodeBarreCode)
            {

            }

            column(RetailCodeBarreCode; RetailCodeBarreCode)
            {

            }

            trigger OnAfterGetRecord()
            var
                Item: Record Item;
                ItemRef: Record "Item Reference";
                Variant: Record "Item Variant";

                BarcodeSymbolygy: Enum "Barcode Symbology";
                BracodesFontProvider: Interface "Barcode Font Provider";

                BarcodeString: Text;
                BarecodeString1: Text;
                BarecodeString2: Text;
            begin
                BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;

                BarcodeString := "Serial No.";
                BracodesFontProvider.ValidateInput(BarcodeString, BarcodeSymbolygy);
                SerialNo := BracodesFontProvider.EncodeFont(BarcodeString, BarcodeSymbolygy);

                Item.Reset();
                Item.Get(SerialNoInformation."Item No.");
                Description := Item.Description;
                Item.CalcFields("Customer Code");
                if Item."Customer Code" = 'C00001' then
                    if SerialNoInformation."Variant Code" = '' then begin
                        ItemRef.Reset();
                        ItemRef.SetRange(ItemRef."Item No.", Item."No.");
                        if ItemRef.FindFirst() then
                            FactoryCode := ItemRef."Reference No.";
                    end
                    else begin
                        ItemRef.Reset();
                        ItemRef.SetRange(ItemRef."Item No.", Item."No.");
                        ItemRef.SetRange(ItemRef."Variant Code", SerialNoInformation."Variant Code");
                        if ItemRef.FindFirst() then begin
                            FactoryCode := ItemRef."Reference No.";
                            RetailCode := ItemRef."Variant Code";
                        end;
                    end;
                IF FactoryCode <> '' then Begin
                    BarecodeString1 := FactoryCode;
                    BracodesFontProvider.ValidateInput(BarecodeString1, BarcodeSymbolygy);
                    FactoryCodeBarreCode := BracodesFontProvider.EncodeFont(BarecodeString1, BarcodeSymbolygy);
                End;
                if RetailCode <> '' then begin
                    BarecodeString2 := RetailCode;
                    BracodesFontProvider.ValidateInput(BarecodeString2, BarcodeSymbolygy);
                    RetailCodeBarreCode := BracodesFontProvider.EncodeFont(BarecodeString2, BarcodeSymbolygy);
                end;

            end;
        }

    }

    var
        SerialNo: Text;
        Description: Text;
        FactoryCode: Code[20];
        RetailCode: Code[20];
        FactoryCodeBarreCode: Text;
        RetailCodeBarreCode: Text;
}
