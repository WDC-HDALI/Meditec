report 50016 "WDC Prod. Order - Mat. Requis."

{
    //WDC01  20-10-2023  WDC.CHG  Add new field
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDLC/ProdOrderMatRequisition.RDL';
    ApplicationArea = Manufacturing;
    Caption = 'Prod. Order - Mat. Requisition';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = Status, "No.", "Source Type", "Source No.";
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(ProdOrderTableCaptionFilter; TableCaption + ':' + ProdOrderFilter)
            {
            }
            column(No_ProdOrder; "No.")
            {
            }
            column(Desc_ProdOrder; Description)
            {
            }
            column(SourceNo_ProdOrder; "Source No.")
            {
                IncludeCaption = true;
            }
            column(Status_ProdOrder; Status)
            {
            }
            column(Qty_ProdOrder; Quantity)
            {
                IncludeCaption = true;
            }
            column(Filter_ProdOrder; ProdOrderFilter)
            {
            }
            column(ProdOrderMaterialRqstnCapt; ProdOrderMaterialRqstnCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            //<<WDC.IM
            column(ItemStage; Item."Item Stage")
            {
                IncludeCaption = true;
            }
            column(ItemMussel; item."Item Mussel")
            {
                IncludeCaption = true;
            }
            //>>WDC.IM
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING("Status", "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                column(ItemNo_ProdOrderComp; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_ProdOrderComp; Description)
                {
                    IncludeCaption = true;
                }
                column(Qtyper_ProdOrderComp; "Quantity per")
                {
                    IncludeCaption = true;
                }
                column(UOMCode_ProdOrderComp; "Unit of Measure Code")
                {
                    IncludeCaption = true;
                }
                column(RemainingQty_ProdOrderComp; "Remaining Quantity")
                {
                    IncludeCaption = true;
                }
                column(Scrap_ProdOrderComp; "Scrap %")
                {
                    IncludeCaption = true;
                }
                column(DueDate_ProdOrderComp; Format("Due Date"))
                {
                    IncludeCaption = false;
                }
                column(LocationCode_ProdOrderComp; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(ComponentQty; ComponentQty)           //WDC.SH
                {
                }
                column(RoutingLinkCode; "Routing Link Code")           //WDC.SH
                {
                }
                column(No; No)           //WDC.SH
                {
                }
                column(QtyCons; QtyCons)           //WDC.CHG
                {
                }
                trigger OnAfterGetRecord()
                begin
                    with ReservationEntry do begin
                        SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");

                        SetRange("Source Type", DATABASE::"Prod. Order Component");
                        SetRange("Source ID", "Production Order"."No.");
                        SetRange("Source Ref. No.", "Line No.");
                        SetRange("Source Subtype", Status);
                        SetRange("Source Batch Name", '');
                        SetRange("Source Prod. Order Line", "Prod. Order Line No.");

                        if FindSet() then begin
                            RemainingQtyReserved := 0;
                            repeat
                                if ReservationEntry2.Get("Entry No.", not Positive) then
                                    if (ReservationEntry2."Source Type" = DATABASE::"Prod. Order Line") and
                                       (ReservationEntry2."Source ID" = "Prod. Order Component"."Prod. Order No.")
                                    then
                                        RemainingQtyReserved += ReservationEntry2."Quantity (Base)";
                            until Next() = 0;
                            if "Prod. Order Component"."Remaining Qty. (Base)" = RemainingQtyReserved then
                                CurrReport.Skip();
                        end;
                    end;
                    ComponentQty := "Prod. Order Component"."Quantity per" * "Production Order".Quantity;   //WDC.SH
                    No += 1;
                    ////////////
                    //<<CHG
                    QtyCons := 0;
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                    ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
                    ItemLedgerEntry.SetRange("Order No.", "Prod. Order No.");
                    ItemLedgerEntry.SetRange("Order Line No.", "Prod. Order Line No.");
                    ItemLedgerEntry.SetRange("Item No.", "Item No.");
                    If ItemLedgerEntry.FindSet then
                        repeat
                            QtyCons += Abs(ItemLedgerEntry."Invoiced Quantity");
                        until ItemLedgerEntry.Next() = 0;
                    //CHG>>
                end;


                trigger OnPreDataItem()
                begin
                    //  SetFilter("Remaining Quantity", '<>0');
                end;
            }

            trigger OnPreDataItem()
            begin
                ProdOrderFilter := GetFilters();
                No := 0;
            end;
            //<<WDC.IM
            trigger OnAfterGetRecord()
            begin
                Item.Get("Production Order"."Source No.");
            end;
            //>>WDC.IM
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        ProdOrderCompDueDateCapt = 'Due Date';
    }

    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ProdOrderFilter: Text;
        RemainingQtyReserved: Decimal;
        ProdOrderMaterialRqstnCaptLbl: Label 'FICHE OF';
        CurrReportPageNoCaptLbl: Label 'Page';
        ComponentQty: Decimal;
        No: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry"; //WDC.CHG
        QtyCons: Decimal;  //WDC.CHG
        Item: Record Item;

}

