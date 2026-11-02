pageextension 50029 WDCProdOrderComponents extends "Prod. Order Components"
{
    layout
    {
        addafter("Quantity per")
        {
            field("Tracking quantity"; Rec."Tracking quantity")
            {
                ApplicationArea = all;
            }
        }
        modify("Reserved Quantity")
        {
            Visible = false;
            ApplicationArea = all;

        }
        addafter("Qty. Picked (Base)")
        {
            field("Act. Consumption (Qty) 2"; Rec."Act. Consumption (Qty)")
            {
                ApplicationArea = all;
            }
        }
        modify("Remaining Quantity")
        {
            trigger OnAfterValidate()
            var
                lItem: Record Item;
                lQuantity: Decimal;
                lItemUnitofMeasure: record "Item Unit of Measure";
            begin
                lItem.Get(Rec."Item No.");
                lItemUnitofMeasure.Get(Rec."Item No.", Rec."Unit of Measure Code");
                lQuantity := round(Rec."Remaining Quantity" * lItemUnitofMeasure."Qty. per Unit of Measure", litem."Rounding Precision", '=');
                Rec.Validate("Remaining Qty. (Base)", lQuantity);
            end;
        }
    }
    actions
    {
        addafter(ItemTrackingLines)
        {
            action(SuppTracabilité)
            {
                CaptionML = FRA = 'Supprimer tracabilité', ENU = 'Delete tracking';
                ApplicationArea = Basic, Suite;
                Image = AllLines;
                trigger OnAction()
                var
                    ReservEntry: Record 337;
                    ProdOrderComp: Record "Prod. Order Component";
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Suppréssion tracabilité pour N° ligne ......#1######################\';
                    Text001: Label 'Voulez-vous supprimer les tracabilités des lignes d''éxpédition';
                begin
                    If Confirm(Text001) then begin
                        Clear(Counter);
                        if not GuiAllowed then
                            exit;
                        Progress.Open(ProgressMsg);
                        ProdOrderComp.Reset();
                        ProdOrderComp.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
                        ProdOrderComp.SetRange("Prod. Order Line No.", Rec."Prod. Order Line No.");
                        ProdOrderComp.SetRange(Status, ProdOrderComp.Status::Released);
                        if ProdOrderComp.FindSet() then
                            repeat
                                ReservEntry.Reset();
                                ReservEntry.SetRange("Item No.", ProdOrderComp."Item No.");
                                ReservEntry.SetRange("Source ID", ProdOrderComp."Prod. Order No.");
                                ReservEntry.SetRange("Source Ref. No.", ProdOrderComp."Line No.");
                                ReservEntry.SetRange("Source Type", 5407);
                                if ReservEntry.FindSet() then begin
                                    ReservEntry.DeleteAll();
                                end;
                                Counter += 1;
                                Progress.Update(1, Counter);
                                Sleep(50);
                            until (ProdOrderComp.Next() = 0);
                        Progress.Close();
                        Message('Traitement fini');
                    end;
                end;
            }
            action(UpdateQty)
            {
                CaptionML = ENU = 'Traceability Correction', FRA = 'Correction traçabilité';
                ApplicationArea = All;
                Image = UpdateDescription;
                trigger OnAction()
                var
                    ReservEntry: Record "Reservation Entry";
                    ReservEntry1: Record "Reservation Entry";
                    ProdOrderComp: Record "Prod. Order Component";
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Mise à jour quantité pour N° ligne ......#1######################\';
                    lItem: Record Item;
                    lQuantity: Decimal;
                    lItemUnitofMeasure: record "Item Unit of Measure";
                begin
                    Progress.Open(ProgressMsg);
                    ProdOrderComp.Reset();
                    ProdOrderComp.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
                    ProdOrderComp.SetRange("Prod. Order Line No.", Rec."Prod. Order Line No.");
                    ProdOrderComp.SetRange(Status, ProdOrderComp.Status::Released);
                    if ProdOrderComp.FindSet() then begin
                        repeat
                            ProdOrderComp.CalcFields("Act. Consumption (Qty)");
                            if ProdOrderComp."Qty. Picked (base)" <> ProdOrderComp."Act. Consumption (Qty)" then begin
                                ProdOrderComp.Validate("Qty. Picked (base)", ProdOrderComp."Act. Consumption (Qty)");
                                ProdOrderComp.Validate("Remaining Quantity", (ProdOrderComp."Expected Quantity" - ProdOrderComp."Qty. Picked"));
                                lItem.Get(ProdOrderComp."Item No.");
                                lItemUnitofMeasure.Get(ProdOrderComp."Item No.", ProdOrderComp."Unit of Measure Code");
                                lQuantity := round(ProdOrderComp."Remaining Quantity" * lItemUnitofMeasure."Qty. per Unit of Measure", litem."Rounding Precision", '=');
                                ProdOrderComp.Validate("Remaining Qty. (Base)", lQuantity);
                                ProdOrderComp.Modify();
                                ReservEntry.Reset();
                                ReservEntry.SetRange("Item No.", ProdOrderComp."Item No.");
                                ReservEntry.SetRange("Source ID", ProdOrderComp."Prod. Order No.");
                                ReservEntry.SetRange("Source Ref. No.", ProdOrderComp."Line No.");
                                ReservEntry.SetRange("Source Type", 5407);
                                if ReservEntry.FindSet() then begin
                                    ReservEntry1.Init();
                                    ReservEntry1 := ReservEntry;
                                    ReservEntry.Delete();
                                    ReservEntry1."Quantity (Base)" := -lQuantity;
                                    ReservEntry1."Qty. to Handle (Base)" := -lQuantity;
                                    ReservEntry1."Qty. to Invoice (Base)" := -lQuantity;
                                    ReservEntry1.Insert();
                                end;
                                Counter += 1;
                                Progress.Update(1, Counter);
                                Sleep(50);
                            end;
                        until (ProdOrderComp.Next() = 0);
                        Progress.Close();
                        if Counter <> 0 then
                            Message('Traitement fini');
                    end;
                end;
            }
        }
    }

}
