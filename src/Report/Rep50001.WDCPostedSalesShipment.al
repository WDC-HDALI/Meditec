report 50001 "WDC Posted Sales Shipment"
{
    Caption = 'Bon Livraison';
    RDLCLayout = './src/Report/RDLC/PostSalesShipment.rdl';
    Description = 'Bon Livraison';

    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = SalesShipmentHeader;
    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
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
            column(BillToContactMobilePhoneNo; BillToContact."Phone No.")
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
            // column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            // {
            // }
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
            // column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            // {
            // }
            // column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            // {
            // }
            // column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            // {
            // }
            // column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            // {
            // }
            column(CompanyLegalStatement; SalesHeader.GetLegalStatement)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
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
                column(Quantity; SalesShipmentLine.Quantity)
                {
                }
                column(GrossWeight; Item."Gross Weight" * SalesShipmentLine.Quantity)
                {
                }
                column(Net_Weight; Item."Net Weight" * SalesShipmentLine.Quantity)
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                trigger OnAfterGetRecord()
                var
                begin
                    SalesHeader.get(SalesHeader."Document Type"::Order, SalesShipmentLine."Order No."); //WDC SH
                    Item.Get(SalesShipmentLine."No.");
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

    procedure GetSellToCustomerFaxNo(): Text
    var
        Customer: Record Customer;
    begin
        if Customer.Get(SalesHeader."Sell-to Customer No.") then
            exit(Customer."Fax No.");
    end;

    var
        TvaNotNull: Boolean;
        NumeroDescription: integer;//WDC 1809
        LineToAdd: Integer;
        NumeroWorkDescription: integer;
        //WDC 1809        PhoneNo: Text[30];//WDC 1809
        PhoneNo: Text[30];//WDC 1809
        FaxNo: Text[30]; //WDC 1809
        SalesHeader: Record "Sales Header"; //WDC SH
        Item: Record Item;
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        CompanyLogoPosition: Integer;
        DisplayAdditionalFeeNote: Boolean;
}

