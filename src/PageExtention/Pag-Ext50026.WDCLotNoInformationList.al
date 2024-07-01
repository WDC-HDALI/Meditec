pageextension 50026 "WDC Lot No. Information List" extends "Lot No. Information List"
{
    actions
    {
        addbefore("&Lot No.")
        {

            action(LotList)
            {
                Image = Card;
                ApplicationArea = all;
                CaptionML = FRA = 'Fiche de Lot';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lLotInformation: Record "Lot No. Information";
                    lRepLotInfor: Report "WDC Lot Information";

                begin
                    Clear(lRepLotInfor);
                    lLotInformation.Reset();
                    lLotInformation.SetRange("Lot No.", Rec."Lot No.");
                    If lLotInformation.FindFirst() then begin
                        lRepLotInfor.SetTableView(lLotInformation);
                        lRepLotInfor.Run();
                    end;

                end;
            }
        }
    }
}
