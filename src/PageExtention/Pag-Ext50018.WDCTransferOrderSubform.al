pageextension 50018 "WDC Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;

            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;

            }
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                ApplicationArea = all;
            }
            field("Routing Link Code"; Rec."Routing Link Code")
            {
                ApplicationArea = all;
            }

        }
        //<<WDC.IM
        addafter(Quantity)
        {
            field("Tracking quantity"; Rec."Tracking quantity")
            {
                ApplicationArea = all;
            }
        }
        //>>WDC.IM
    }
    //<<WDC.IM
    actions
    {
        addafter("Item &Tracking Lines")
        {
            action(InsertLot)
            {
                CaptionML = FRA = 'Insérer Lot FIFO', ENU = 'Insert Lot FIFO';
                ApplicationArea = Basic, Suite;
                Image = AllLines;
                trigger OnAction()
                var
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Insérer tracabilité pour N° ligne ......#1######################\';
                    Text001: Label 'Voulez-vous insérer les tracabilités pour les lignes d''éxpédition ?';
                begin
                    if Confirm(text001) then begin
                        Clear(Counter);
                        if not GuiAllowed then
                            exit;
                        Progress.Open(ProgressMsg);
                        TransferHeader.Get(Rec."Document No.");
                        TransferLine.Reset();
                        TransferLine.SETRANGE("Document No.", Rec."Document No.");
                        if TransferLine.FindSet() then begin
                            repeat
                                Clear(LotItemQty);
                                ItemQty := TransferLine.Quantity;
                                ItemLedgEntry.Reset();
                                ItemLedgEntry.SetCurrentKey("Item No.", "Posting Date");
                                ItemLedgEntry.SetRange("Item No.", TransferLine."Item No.");
                                ItemLedgEntry.SetRange("Variant Code", TransferLine."Variant Code");
                                ItemLedgEntry.SetRange(Open, true);
                                ItemLedgEntry.SetRange(Positive, true);
                                ItemLedgEntry.SetRange("Location Code", TransferHeader."Transfer-from Code");
                                if ItemLedgEntry.FindSet() then
                                    repeat
                                        If ItemQty <> 0 then begin
                                            If ItemLedgEntry."Remaining Quantity" > ItemQty then begin
                                                InsertShipmLot(ItemQty);
                                                InsertReceptLot(ItemQty);
                                                ItemQty := 0;
                                            end
                                            else if (ItemLedgEntry."Remaining Quantity" <> 0) then begin
                                                InsertShipmLot(ItemLedgEntry."Remaining Quantity");
                                                InsertReceptLot(ItemLedgEntry."Remaining Quantity");
                                                ItemQty -= ItemLedgEntry."Remaining Quantity";
                                            end;
                                            Counter += 1;
                                        end;
                                    until (ItemLedgEntry.Next() = 0);

                                Progress.Update(1, Counter);
                                Sleep(50);
                                TransferLine."Qty. to Receive" := LotItemQty;
                                TransferLine.Modify();
                            until (TransferLine.Next() = 0);
                        end;
                        Progress.Close();
                        Message('Traitement fini');
                    end;
                end;
            }
            action(SuppTracabilité)
            {
                CaptionML = FRA = 'Supprimer tracabilité', ENU = 'Delete tracking';
                ApplicationArea = Basic, Suite;
                Image = AllLines;
                trigger OnAction()
                var
                    ReservEntry: Record 337;
                    TransferLine: Record "Transfer Line";
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Suppression traçabilité pour N° ligne ......#1######################\';
                    Text001: Label 'Voulez-vous supprimer les traçabilités des lignes d''éxpédition';
                begin
                    If Confirm(Text001) then begin
                        Clear(Counter);
                        if not GuiAllowed then
                            exit;
                        Progress.Open(ProgressMsg);
                        TransferLine.Reset();
                        TransferLine.SETRANGE("Document No.", Rec."Document No.");
                        if TransferLine.FindSet() then
                            repeat
                                ReservEntry.Reset();
                                ReservEntry.SetRange("Item No.", TransferLine."Item No.");
                                ReservEntry.SetRange("Reservation Status", ReservEntry."Reservation Status"::Surplus);
                                ReservEntry.SetRange("Source ID", TransferLine."Document No.");
                                ReservEntry.SetRange("Source Ref. No.", TransferLine."Line No.");
                                ReservEntry.SetRange("Source Type", 5741);
                                if ReservEntry.FindSet() then begin
                                    ReservEntry.DeleteAll();
                                end;
                                Counter += 1;
                                Progress.Update(1, Counter);
                                Sleep(50);
                            until (TransferLine.Next() = 0);
                        Progress.Close();
                        Message('Traitement fini');
                    end;
                end;
            }
        }
    }
    //>>WDC.IM
    procedure InsertShipmLot(pQuantity: Decimal)
    var
        ReserEntry: Record 337;
    begin
        ReserEntry.Init();
        ReserEntry."Entry No." := ReserEntry.GetLastEntryNo() + 1;
        ReserEntry."Item No." := TransferLine."Item No.";
        ReserEntry."Location Code" := TransferHeader."Transfer-from Code";
        ReserEntry.Validate("Quantity (Base)", -pQuantity);
        ReserEntry.Validate(Quantity, -pQuantity);
        ReserEntry."Reservation Status" := ReserEntry."Reservation Status"::Surplus;
        ReserEntry."Creation Date" := WorkDate();
        ReserEntry."Source Type" := 5741;
        ReserEntry."Source Subtype" := 0;
        ReserEntry."Source ID" := TransferLine."Document No.";
        ReserEntry."Source Ref. No." := TransferLine."Line No.";
        ReserEntry."Shipment Date" := TransferLine."Shipment Date";
        ReserEntry.Positive := false;
        ReserEntry."Lot No." := ItemLedgEntry."Lot No.";
        ReserEntry.Correction := false;
        ReserEntry."Item Tracking" := ReserEntry."Item Tracking"::"Lot No.";
        ReserEntry.Insert(true);
        LotItemQty += ReserEntry."Quantity (Base)" * (-1);
    end;

    procedure InsertReceptLot(pQuantity: Decimal)
    var
        ReserEntry: Record 337;
    begin
        ReserEntry.Init();
        ReserEntry."Entry No." := ReserEntry.GetLastEntryNo() + 1;
        ReserEntry."Item No." := TransferLine."Item No.";
        ReserEntry."Location Code" := TransferHeader."Transfer-to Code";
        ReserEntry.Validate("Quantity (Base)", pQuantity);
        ReserEntry.Validate(Quantity, pQuantity);
        ReserEntry."Reservation Status" := ReserEntry."Reservation Status"::Surplus;
        ReserEntry."Creation Date" := WorkDate();
        ReserEntry."Source Type" := 5741;
        ReserEntry."Source Subtype" := 1;
        ReserEntry."Source ID" := TransferLine."Document No.";
        ReserEntry."Source Ref. No." := TransferLine."Line No.";
        ReserEntry."Expected Receipt Date" := TransferLine."Receipt Date";
        ReserEntry.Positive := true;
        ReserEntry."Lot No." := ItemLedgEntry."Lot No.";
        ReserEntry.Correction := false;
        ReserEntry."Item Tracking" := ReserEntry."Item Tracking"::"Lot No.";
        ReserEntry.Insert(true);
    end;

    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        ItemQty: Decimal;
        ItemLedgEntry: Record 32;
        LotItemQty: Decimal;
}

