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
            column(CustomerName; customer.Name)
            {

            }
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
            column(combinaisonSN; combinaisonSN)
            {

            }
            column(SKU; SKU)
            { }

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

                Item.Get(SerialNoInformation."Item No.");
                Description := Item.Description;
                SKU := 'SKU: ' + Item.SKU;
                //<<WDC01
                //if Item."Customer Code" = 'C00001' then begin

                // if SerialNoInformation."Variant Code" = '' then begin
                //     ItemRef.Reset();
                //     ItemRef.SetRange(ItemRef."Item No.", Item."No.");
                //     if ItemRef.FindFirst() then
                //         FactoryCode := ItemRef."Reference No.";
                // end
                // else begin
                //     ItemRef.Reset();
                //     ItemRef.SetRange(ItemRef."Item No.", Item."No.");
                //     ItemRef.SetRange("Variant Code", SerialNoInformation."Variant Code");
                //     if ItemRef.FindFirst() then begin
                //         FactoryCode := ItemRef."Reference No.";
                //         RetailCode := ItemRef."Variant Code";
                //     end;
                // end;
                FactoryCode := Item."Factory Code";
                RetailCode := Item."Retail Code";
                //end;
                //>>WDC01
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
                if customer.get(Item."Customer Code") then
                    abv := customer."Customer Abreviation";

                itemledgerEntry.Reset();
                itemledgerEntry.SetRange("Serial No.", SerialNoInformation."Serial No.");
                if itemledgerEntry.FindSet() then Begin
                    if (itemledgerEntry."Entry Type" = itemledgerEntry."Entry Type"::Output) AND (itemledgerEntry.Quantity > 0) then begin
                        OFlance.Reset();
                        OFlance.SetRange("No.", itemledgerEntry."Document No.");
                        if OFlance.FindSet() then
                            modele := OFlance.model;
                    end;
                end;

                combinaisonSN := SerialNoInformation."Serial No.";//abv + '-' + modele + '-' + SerialNoInformation."Serial No.";








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
        ItemRef2: Record "Item Reference";
        customer: Record Customer;

        //itemvar: Page "Item Tracking Lines";
        Iemtrachingline: page "Enter Customized SN";
        abv: text;
        itemledgerEntry: Record "Item Ledger Entry";
        OFlance: Record "Production Order";
        modele: Text;
        combinaisonSN: text[500];
        SKU: Code[30];//WDC01
}
