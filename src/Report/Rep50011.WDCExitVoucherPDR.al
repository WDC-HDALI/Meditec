report 50011 "WDC Exit Voucher PDR"
{
    Caption = 'Bon sortie magasin';
    RDLCLayout = './src/Report/RDLC/ExitVoucherPDR.rdl';
    Description = 'Bon sortie magasin ';

    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(PostedExitVoucherPDR; "Posted Exit Voucher Header")
        {
            RequestFilterFields = "No.";

            column(No_; "No.")
            {
            }
            column(Name_CompanyInfo; CompanyInfo.Name)
            {
            }
            column(Picture_CompanyInfo; CompanyInfo.Picture)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Name_Concerned_Person; "Name Concerned Person")
            {
            }
            column(Created_by; "Created by")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }


            dataitem(PostedExitVoucherLines; "Posted Exit Voucher Lines")
            {

                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = PostedExitVoucherPDR;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(ItemNo; PostedExitVoucherLines."No.")
                {
                }
                column(Description; PostedExitVoucherLines.Description)
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Quantity; PostedExitVoucherLines.Quantity)
                {
                }
                column(Machine_reference; "Machine reference")
                {
                }
                column(Machine_Name; "Machine Name")
                {

                }
                column(Work_Center_No_; "Work Center No.")
                {

                }
                column(Work_Center_Name; "Work Center Name")
                {

                }
                column(Lot_No_; "Lot No.")
                {

                }


                trigger OnAfterGetRecord()
                var
                begin

                end;
            }
            trigger OnAfterGetRecord()
            begin

            end;


        }

    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture); //WDC 1809

    end;

    var
        CompanyInfo: record "Company Information";

}

