reportextension 50021 "WDC Transfer Order" extends "Transfer Order"
{
    RDLCLayout = './src/ReportExtension/RDLC/TransferOrder.rdlc';

    dataset
    {
        add("Transfer Header")
        {

            column(Transfer_from_Code; "Transfer-from Code")
            {

            }
            column(Transfer_to_Code; "Transfer-to Code")
            {

            }
            column(Picture; CompanyInfo.Picture)
            {

            }
        }

        add("Transfer Line")
        {

            column(CodeAtelier; "Routing Link Code")
            {

            }
            column(CodeOF; "Prod. Order No.")
            {

            }

        }

    }

    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record 79;
}

