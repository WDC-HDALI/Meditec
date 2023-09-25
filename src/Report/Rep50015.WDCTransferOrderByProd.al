report 50015 WDCTransferOrderByProd
{
    ApplicationArea = All;
    Captionml = ENU = 'WDC Transfer Order By Production', FRA = 'WDC Ordre tranfert par O.F.';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Prod. Order Component"; "Prod. Order Component")
        {
            DataItemTableView = sorting("Item No.") where(Status = const(Released));
            RequestFilterFields = "Prod. Order No.", "Item No.", "Routing Link Code";

            trigger OnAfterGetRecord()
            var
                lNeededQty: Decimal;

                TransOrder: Boolean;
            begin
                //Vérification de type de composant
                clear(ItemCategory);
                Item.Get("Item No.");
                if (LocationCodeDepart = '') or (LocationCodeDepart = 'MAG-MP') then begin
                    if item."Inventory Posting Group" <> 'MP' then
                        CurrReport.Skip();
                end else
                    if (LocationCodeDepart = 'MAG-MC') then begin
                        if (item."Inventory Posting Group" <> 'CONS') and (item."Inventory Posting Group" <> 'EMB') then
                            CurrReport.Skip();
                    end;

                TransOrder := false;
                TempProdOrderComp.reset;
                TempProdOrderComp.SetRange("Item No.", "Item No.");
                if TempProdOrderComp.FindSet() then begin
                    //Ajouter le même composant dans la table temporaire
                    InsertTempProdOrderCompt("Prod. Order Component");
                end else begin
                    clear(lNeededQty);
                    clear(lRestNeedQty);
                    TempProdOrderComp.reset;
                    Clear(Item);
                    //Calculer la quantité totale du composant !!!! COMP-1 !!!!! pour tout les O.F
                    if TempProdOrderComp.FindSet() then
                        repeat
                            lNeededQty += TempProdOrderComp.Quantity;
                        until TempProdOrderComp.Next() = 0;

                    //vérifier le stock disponible de ce composant dans le magasin destination
                    if TempProdOrderComp."Item No." <> '' then
                        Item.Get(TempProdOrderComp."Item No.")
                    else
                        Item.Get("Item No.");

                    if LocationCodeDest = '' then
                        Item.SetFilter("Location Filter", 'MAG-PROD')
                    else
                        Item.SetFilter("Location Filter", LocationCodeDest);

                    //Vérification
                    Item.CalcFields(Inventory);
                    lRestNeedQty := lNeededQty - item.Inventory;
                    if lRestNeedQty > 0 then begin
                        TempProdOrderComp.reset();
                        lRestNeedQty := item.Inventory;
                        if TempProdOrderComp.FindSet() then
                            repeat
                                //Vérification si le composant de cet O.F existe sur un autre ordre de transfer
                                if not CheckCompInTransfOrder(TempProdOrderComp) then begin
                                    //Création d'un ordre de transfer
                                    if TransferNo = '' then
                                        CreateTransferHeader();
                                    //CreateTransferOrder(TempProdOrderComp, TempProdOrderComp.Quantity);

                                    CreateTransferOrder(TempProdOrderComp, lRestNeedQty);
                                end;
                            until TempProdOrderComp.Next() = 0;

                    end;

                    TempProdOrderComp.DeleteAll();
                    InsertTempProdOrderCompt("Prod. Order Component");
                end;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(LocationCodeDepart; LocationCodeDepart)
                    {
                        ApplicationArea = Location;
                        CaptionML = FRA = 'Magasin provenance';
                        ToolTip = 'Specifies the location from where you want the program to post the items.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Location: Record Location;
                        begin
                            if PAGE.RunModal(0, Location) = ACTION::LookupOK then begin
                                Text := Location.Code;
                                exit(true);
                            end;
                            exit(false);
                        end;
                    }
                    field(LocationCodeDest; LocationCodeDest)
                    {
                        ApplicationArea = Location;
                        CaptionML = FRA = 'Magasin destination';
                        ToolTip = 'Specifies the location from where you want the program to post the items.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Location: Record Location;
                        begin
                            if PAGE.RunModal(0, Location) = ACTION::LookupOK then begin
                                Text := Location.Code;
                                exit(true);
                            end;
                            exit(false);
                        end;
                    }
                }
            }
        }

    }
    trigger OnPreReport()
    begin
        clear(LineNo);
        clear(TransferNo);
        Clear(TempProdOrderComp);
        TempProdOrderComp.DeleteAll();
    end;

    trigger OnPostReport()
    var
        lNeededQty: Decimal;

    begin
        clear(lNeededQty);
        Clear(lRestNeedQty);
        TempProdOrderComp.reset;
        Clear(Item);
        //Calculer la quantité totale de ce composant pour tout les O.F
        if not TempProdOrderComp.FindSet() then
            exit;

        repeat
            lNeededQty += TempProdOrderComp.Quantity;
        until TempProdOrderComp.Next() = 0;

        //vérifier le stock disponible de ce composant dans le magasin destination
        Item.Get(TempProdOrderComp."Item No.");
        if LocationCodeDest = '' then
            Item.SetFilter("Location Filter", 'MAG-PROD')
        else
            Item.SetFilter("Location Filter", LocationCodeDest);

        //Vérification
        Item.CalcFields(Inventory);
        lRestNeedQty := lNeededQty - item.Inventory;
        if lRestNeedQty > 0 then begin
            TempProdOrderComp.reset();
            lRestNeedQty := item.Inventory;
            if TempProdOrderComp.FindSet() then
                repeat
                    //Vérification si le composant de cet O.F existe sur un autre ordre de transfer
                    if not CheckCompInTransfOrder(TempProdOrderComp) then begin
                        //Création d'un ordre de transfer
                        if TransferNo = '' then
                            CreateTransferHeader();
                        //CreateTransferOrder(TempProdOrderComp, TempProdOrderComp.Quantity);

                        CreateTransferOrder(TempProdOrderComp, lRestNeedQty);
                    end;
                until TempProdOrderComp.Next() = 0;

        end;
    end;

    var
        Item: Record Item;
        TempProdOrderComp: Record "Prod. Order Component" temporary;
        LocationCodeDepart: Code[10];
        LocationCodeDest: Code[10];
        TransferNo: code[20];
        LineNo: Integer;
        lRestNeedQty: Decimal;
        ItemCategory: code[20];

    local procedure CheckCompInTransfOrder(pProdOrderComponent: Record "Prod. Order Component"): Boolean
    var
        TransferLine: record "Transfer Line";
    begin
        TransferLine.reset;
        TransferLine.SetRange("Item No.", pProdOrderComponent."Item No.");
        TransferLine.setrange("Prod. Order No.", pProdOrderComponent."Prod. Order No.");
        TransferLine.SetRange("Prod. Order Line", pProdOrderComponent."Prod. Order Line No.");
        TransferLine.SetRange("Routing Link Code", pProdOrderComponent."Routing Link Code");
        if TransferLine.Count = 0 then
            exit(false)
        else
            exit(true);
    end;

    local procedure CreateTransferHeader()
    var
        TransferHeader: Record "Transfer Header";
    begin
        clear(TransferHeader);

        TransferHeader."No." := '';
        TransferHeader.Insert(true);

        if LocationCodeDepart = '' then
            //TransferHeader.Validate("Transfer-from Code", 'MAG-MP')
            TransferHeader."Transfer-from Code" := 'MAG-MP'
        else
            //TransferHeader.Validate("Transfer-from Code", LocationCodeDepart);
            TransferHeader."Transfer-from Code" := LocationCodeDepart;

        if LocationCodeDest = '' then
            //TransferHeader.Validate("Transfer-from Code", 'MAG-PROD')
            TransferHeader."Transfer-to Code" := 'MAG-PROD'
        else
            //TransferHeader.Validate("Transfer-to Code", LocationCodeDest);
            TransferHeader."Transfer-to Code" := LocationCodeDest;

        TransferHeader.Validate("In-Transit Code", 'TRANSIT');
        TransferHeader.validate("Posting Date", WorkDate());
        TransferHeader.Modify();

        TransferNo := TransferHeader."No.";
    end;

    local procedure CreateTransferOrder(pProdOrderComponent: Record "Prod. Order Component"; var pRestNeededQty: Decimal)
    var
        TransferLine: record "Transfer Line";
    begin

        if pRestNeededQty >= pProdOrderComponent.Quantity then begin
            pRestNeededQty -= pProdOrderComponent.Quantity;
            if pRestNeededQty < 0 then
                pRestNeededQty := 0;
            exit;
        end else begin
            Clear(TransferLine);
            LineNo += 1000;

            TransferLine."Document No." := TransferNo;
            TransferLine."Line No." := LineNo;
            TransferLine.Validate("Item No.", pProdOrderComponent."Item No.");
            TransferLine.validate(Quantity, pProdOrderComponent.Quantity - pRestNeededQty);
            pRestNeededQty -= pProdOrderComponent.Quantity;
            if pRestNeededQty < 0 then
                pRestNeededQty := 0;
            TransferLine."Prod. Order No." := pProdOrderComponent."Prod. Order No.";
            TransferLine."Prod. Order Line" := pProdOrderComponent."Prod. Order Line No.";

            TransferLine."Routing Link Code" := pProdOrderComponent."Routing Link Code";

            TransferLine.Insert();
        end;
    end;

    local procedure InsertTempProdOrderCompt(pProdOrderComponent: Record "Prod. Order Component")
    var
        lReservQty: Decimal;
    begin
        //Vérifier si le composant pour cet O.F existe ou pas
        lReservQty := GetReservationQty(pProdOrderComponent);
        TempProdOrderComp.Reset();
        TempProdOrderComp.SetRange(Status, pProdOrderComponent.Status);
        TempProdOrderComp.SetRange("Prod. Order No.", pProdOrderComponent."Prod. Order No.");
        TempProdOrderComp.SetRange("Prod. Order Line No.", pProdOrderComponent."Prod. Order Line No.");
        TempProdOrderComp.SetRange("Item No.", pProdOrderComponent."Item No.");
        TempProdOrderComp.SetRange("Routing Link Code", pProdOrderComponent."Routing Link Code");
        if TempProdOrderComp.FindFirst() then begin
            TempProdOrderComp.Quantity += pProdOrderComponent."Remaining Quantity" + lReservQty;
            TempProdOrderComp.modify();
        end else
            if ((pProdOrderComponent."Remaining Quantity" + lReservQty) > 0) then begin
                TempProdOrderComp.Init();
                TempProdOrderComp.Status := pProdOrderComponent.Status;
                TempProdOrderComp."Prod. Order No." := pProdOrderComponent."Prod. Order No.";
                TempProdOrderComp."Prod. Order Line No." := pProdOrderComponent."Prod. Order Line No.";
                TempProdOrderComp."Line No." := pProdOrderComponent."Line No.";
                TempProdOrderComp."Item No." := pProdOrderComponent."Item No.";
                TempProdOrderComp.Quantity := pProdOrderComponent."Remaining Quantity" + lReservQty;
                TempProdOrderComp."Routing Link Code" := pProdOrderComponent."Routing Link Code";
                TempProdOrderComp.Insert();
            end;
    end;

    local procedure GetReservationQty(pProdOrderComponent: Record "Prod. Order Component"): Decimal
    var
        lReservEntry: Record "Reservation Entry";
        lTotalQty: Decimal;
    begin
        //Chercher la Qté traçabilité du composant sur l’OF
        lTotalQty := 0;
        lReservEntry.Reset();
        lReservEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        lReservEntry.SetRange("Source Type", 5407);
        lReservEntry.SetRange("Source ID", pProdOrderComponent."Prod. Order No.");
        lReservEntry.SetRange("Source Prod. Order Line", pProdOrderComponent."Prod. Order Line No.");
        lReservEntry.SetRange("Source Ref. No.", pProdOrderComponent."Line No.");
        lReservEntry.SetRange("Item No.", pProdOrderComponent."Item No.");
        if lReservEntry.FindSet() then
            lTotalQty += lReservEntry.Quantity;

        exit(lTotalQty);
    end;

}
