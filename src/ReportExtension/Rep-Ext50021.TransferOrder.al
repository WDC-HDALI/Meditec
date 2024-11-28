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

            column(LotNoCaption; LotNoCaption)
            { }
            column(QtyTatal; QtyTatal)
            { }
        }
        addlast("Transfer Line")
        {
            dataitem("Reservation Entry"; "Reservation Entry")
            {
                DataItemLink = "Item No." = field("Item No."), "Source Id" = field("Document No."), "Source Ref. No." = field("Line No.");
                DataItemLinkReference = "Transfer Line";
                DataItemTableView = sorting("Item No.") where(Positive = const(false));
                column(Lot_No; "Lot No.")
                { }
                column(Quantity__Base_; "Quantity (Base)")
                { }

            }
        }
        modify("Transfer Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                lTransferLine: Record "Transfer Line";
            begin
                Clear(QtyTatal);
                lTransferLine.Reset();
                lTransferLine.SetRange("Document No.", "Transfer Line"."Document No.");
                lTransferLine.SetRange("Item No.", "Transfer Line"."Item No.");
                if lTransferLine.FindSet() then
                    repeat
                        QtyTatal += lTransferLine.Quantity;
                    until (lTransferLine.Next() = 0);
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
        Clear(QtyTatal);
    end;

    var
        CompanyInfo: Record 79;
        LotNoCaption: TextConst FRA = 'N° lot', ENU = 'Lot No.';
        QtyTatal: Decimal;
}

