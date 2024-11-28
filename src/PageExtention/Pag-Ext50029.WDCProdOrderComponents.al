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
        }
    }

}
