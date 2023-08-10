pageextension 50024 "WDC Released Production Order" extends "Released Production Order"
{
    actions
    {
        addlast("&Print")
        {
            action("FicheProd")
            {
                ApplicationArea = all;
                Caption = 'Fiche production';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    FicheProd: Report "WDC Prod. Order - Mat. Requis.";
                    ProductionOrder: Record "Production Order";
                begin
                    ProductionOrder.SetRange(Status, Rec.Status);
                    ProductionOrder.SetRange("No.", Rec."No.");
                    if ProductionOrder.FindFirst() then
                        Report.Run(50016, true, false, ProductionOrder);
                end;
            }
        }
    }
}
