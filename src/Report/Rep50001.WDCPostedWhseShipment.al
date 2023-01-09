report 50001 "WDC Posted Whse Shipment"
{
    Caption = 'Bon Livraison';
    RDLCLayout = './src/Report/RDLC/PostWhseShipment.rdl';
    Description = 'Bon Livraison';

    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = WarehouseShipmentHeader;
    dataset
    {
        //dataitem(SalesShipmentHeader; "Sales Shipment Header")
        dataitem(WarehouseShipmentHeader; "Posted Whse. Shipment Header")
        {
            RequestFilterFields = "No.";
            column(Posting_Date; "Posting Date")
            {
            }
            column(BilltoAddress; SalesHeader."Bill-to Address")
            {
            }
            column(BilltoAddress2; SalesHeader."Bill-to Address 2")
            {
            }
            column(BilltoCity; SalesHeader."Bill-to City")
            {
            }
            column(BilltoContact; SalesHeader."Bill-to Contact")
            {
            }
            column(BilltoContactNo; SalesHeader."Bill-to Contact No.")
            {
            }
            column(BilltoCountryRegionCode; SalesHeader."Bill-to Country/Region Code")
            {
            }
            column(BilltoCounty; SalesHeader."Bill-to County")
            {
            }
            column(BilltoCustomerNo; SalesHeader."Bill-to Customer No.")
            {
            }
            column(BilltoName; SalesHeader."Bill-to Name")
            {
            }
            column(BilltoName2; SalesHeader."Bill-to Name 2")
            {
            }
            column(BilltoCountry; SalesHeader."Bill-to County")
            {
            }
            column(BilltoPostCode; SalesHeader."Bill-to Post Code")
            {
            }
            column(No; "No.")
            {
            }

            column(NoSeries; "No. Series")
            {
            }
            column(OrderDate; SalesHeader."Order Date")
            {
            }
            column(SelltoAddress; SalesHeader."Sell-to Address")
            {
            }
            column(SelltoAddress2; SalesHeader."Sell-to Address 2")
            {
            }
            column(SelltoCity; SalesHeader."Sell-to City")
            {
            }
            column(SelltoContact; SalesHeader."Sell-to Contact")
            {
            }
            column(SelltoContactNo; SalesHeader."Sell-to Contact No.")
            {
            }
            column(SelltoCountryRegionCode; SalesHeader."Sell-to Country/Region Code")
            {
            }
            column(SelltoCounty; SalesHeader."Sell-to County")
            {
            }

            column(SelltoCustomerName; SalesHeader."Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2; SalesHeader."Sell-to Customer Name 2")
            {
            }
            column(SelltoCustomerNo; SalesHeader."Sell-to Customer No.")
            {
            }
            column(SelltoEMail; SalesHeader."Sell-to E-Mail")
            {
            }

            column(SelltoPhoneNo; SalesHeader."Sell-to Phone No.")
            {
            }
            column(SelltoPostCode; SalesHeader."Sell-to Post Code")
            {
            }
            column(ShiptoAddress; SalesHeader."Ship-to Address")
            {
            }
            column(ShiptoAddress2; SalesHeader."Ship-to Address 2")
            {
            }
            column(ShiptoCity; SalesHeader."Ship-to City")
            {
            }
            column(ShiptoCode; SalesHeader."Ship-to Code")
            {
            }
            column(ShiptoContact; SalesHeader."Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode; SalesHeader."Ship-to Country/Region Code")
            {
            }
            column(ShiptoCountry; SalesHeader."Ship-to County")
            {
            }
            column(ShiptoName; SalesHeader."Ship-to Name")
            {
            }
            column(ShiptoName2; SalesHeader."Ship-to Name 2")
            {
            }
            column(ShiptoPostCode; SalesHeader."Ship-to Post Code")
            {
            }
            column(ShipmentDate; "Shipment Date")
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentServiceCode; "Shipping Agent Service Code")
            {
            }
            column(ShippingTime; SalesHeader."Shipping Time")
            {
            }

            column(CompanyCity; companyinfo.City)  //WDC
            {
            }

            column(CompanyName; CompanyInfo."Name") //WDC 1809
            {
            }
            column(FaxNo; FaxNo) //WDC 1809
            {
            }
            column(PhoneNo; PhoneNo) //WDC 1809
            {
            }
            column(SellToNo; SellToContact."No.")
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SelltoFaxNo; GetSellToCustomerFaxNo)
            {
            }

            column(SellToContactFaxNo; SellToContact."Fax No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactFaxNo; BillToContact."Fax No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(TVA_Intra; Cust."VAT Registration No.")
            {
            }
            column(CompanyPostCod; companyinfo."Post Code")  //WDC
            {
            }
            column(CompanyAdress; companyinfo.Address)  //WDC
            {
            }
            column(CompanyAdress2; companyinfo."Address 2")  //WDC
            {
            }
            column(CompanyTVAINTRA; companyinfo."VAT Registration No.")  //WDC
            {
            }
            column(CompanySIRET; companyinfo."Registration No.")  //WDC
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(BDMRCompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }

            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            {
            }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            {
            }
            column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            {
            }
            column(CompanyLegalStatement; SalesHeader.GetLegalStatement)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
            }
            dataitem(WarehouseShipmentLine; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = WarehouseShipmentHeader;
                DataItemTableView = SORTING("No.", "Line No.");
                column(ItemNo; WarehouseShipmentLine."Item No.")
                {
                }
                column(Description; WarehouseShipmentLine.Description)
                {
                }
                column(Type; Item.Type)
                {
                }
                column(Quantity; WarehouseShipmentLine.Quantity)
                {
                }
                column(GrossWeight; Item."Gross Weight" * WarehouseShipmentLine.Quantity)
                {
                }
                column(Net_Weight; Item."Net Weight" * WarehouseShipmentLine.Quantity)
                {
                }
                trigger OnAfterGetRecord()
                var
                begin
                    SalesHeader.get(SalesHeader."Document Type"::Order, WarehouseShipmentLine."Source No."); //WDC SH
                    Item.GetItemNo(WarehouseShipmentLine."Item No.");
                    if not Cust.Get(SalesHeader."Bill-to Customer No.") then
                        Clear(Cust);
                    if SellToContact.Get(SalesHeader."Sell-to Contact No.") then;
                    if BillToContact.Get(SalesHeader."Bill-to Contact No.") then;

                end;
            }



        }

    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        Clear(PhoneNo); //WDC 1809
        Clear(FaxNo); //WDC 1809
        Clear(NumeroDescription); //WDC 1809
        Clear(LineToAdd);
        Clear(NumeroWorkDescription); //WDC 1809
        CompanyInfo.Get();
        PhoneNo := CompanyInfo."Phone No."; //WDC 1809
        FaxNo := CompanyInfo."Fax No."; //WDC 1809
        CompanyInfo.CalcFields(Picture); //WDC 1809
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo;
        TvaNotNull := false;
    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        TvaNotNull: Boolean;
        NbInvoiceLine: Integer;//WDC HD
        CounterLine: Integer;//WDC HD
        SalesInvoiceLine: Record 113;//WDC HD
        SalesCommentLine: record 44; //WDC HD

        TotPage: Integer;   //WDC HD
        CurrentPage: Integer;   //WDC HD
        Paiement: Text;  //WDC 
        CustSell: Record Customer;  //WDC
        MonthTxt: Text;       //WDC
        BDMRInvoiceNo: Text;  //WDC
        NumeroDescription: integer;//WDC 1809
        LineToAdd: Integer;
        NumeroWorkDescription: integer;//WDC 1809
        Groupe: Integer;//WDC 1809
        TotalRemise: Decimal;//WDC 1809
        GsalesLine: Record "Sales invoice line";
        PhoneNo: Text[30];//WDC 1809
        FaxNo: Text[30]; //WDC 1809
        SalesHeader: Record "Sales Header"; //WDC SH
        SalesLine: Record "Sales Line"; //WDC SH
        Item: Record Item; //WDC SH
        SalespersonLbl: Label 'Salesperson';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Invoice No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesInvoiceLbl: Label 'Invoice';
        YourSalesInvoiceLbl: Label 'Your Invoice';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        GLSetup: Record "General Ledger Setup";

        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;

        SellToContact: Record Contact;
        BillToContact: Record Contact;
        JobNo: Code[20];
        JobTaskNo: Code[20];
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[100];
        ChecksPayableText: Text;
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        PmtDiscText: Text;
        RemainingAmountTxt: Text;
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        TotalAmountExclInclVATTextValue: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        ShowShippingAddr: Boolean;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        RemainingAmount: Decimal;
        TransHeaderAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        PaymentInstructionsTxt: Text;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        TotalAmountExclInclVATValue: Decimal;
        DisplayAdditionalFeeNote: Boolean;
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your invoice is attached to this message.';
        AlreadyPaidLbl: Label 'The invoice has been paid.';
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = '%1=an amount';
        FromLbl: Label 'From';
        BilledToLbl: Label 'Billed to';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        QuestionsLbl: Label 'Questions?';
        ThanksLbl: Label 'Thank You!';
        JobNoLbl2: Label 'Job No.';
        JobTaskNoLbl2: Label 'Job Task No.';
        JobTaskDescription: Text[100];
        JobTaskDescLbl: Label 'Job Task Description';
        UnitLbl: Label 'Unit';
        VATClausesText: Text;
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';

    procedure GetSellToCustomerFaxNo(): Text
    var
        Customer: Record Customer;
    begin
        if Customer.Get(SalesHeader."Sell-to Customer No.") then
            exit(Customer."Fax No.");
    end;


}

