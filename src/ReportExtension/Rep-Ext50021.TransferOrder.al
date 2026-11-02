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
            column(OrdresTransfertNO; OrdresTransfertNO)
            {

            }
        }
        modify("Transfer Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                TransferLine: Record "Transfer Line";
                lProdOrderNo: Text[250];
            begin
                TransferLine.Reset();
                TransferLine.SetCurrentKey("Prod. Order No.");
                TransferLine.SetRange("Document No.", "Transfer Header"."No.");
                if TransferLine.FindSet() then begin
                    lProdOrderNo := TransferLine."Prod. Order No.";
                    OrdresTransfertNO := lProdOrderNo;
                    repeat
                        if lProdOrderNo <> TransferLine."Prod. Order No." then begin
                            OrdresTransfertNO += '/' + TransferLine."Prod. Order No.";
                        end;
                        lProdOrderNo := TransferLine."Prod. Order No.";
                    until (TransferLine.Next() = 0)
                end;
            end;
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
            column(RoutinkLinkCode; "Transfer Line"."Routing Link Code")
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
                if lTransferLine.FindSet() then begin
                    repeat
                        QtyTatal += lTransferLine.Quantity;
                    until (lTransferLine.Next() = 0);
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
        Clear(QtyTatal);
        Clear(OrdresTransfertNO);
    end;

    var
        CompanyInfo: Record "Company Information";
        LotNoCaption: TextConst FRA = 'N° lot', ENU = 'Lot No.';
        QtyTatal: Decimal;
        OrdresTransfertNO: Text[500];
}

