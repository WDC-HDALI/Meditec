pageextension 50024 "WDC Released Production Order" extends "Released Production Order"
{
    layout
    {
        addafter("Source No.")
        {
            field("Version Model"; Rec."Model")
            {

                ApplicationArea = all;


            }
        }
    }
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
