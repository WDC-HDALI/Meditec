pageextension 50021 "WDC Serial No. Info List" extends "Serial No. Information List"
{
    layout
    {
        addafter(Inventory)
        {
            field("Assembled in Carton"; Rec."Assembled in Carton")
            {
                ApplicationArea = all;

            }
            field(shipped; Rec.shipped)
            {
                ApplicationArea = all;

            }
            field(DescriptionItem; Rec.DescriptionItem)
            {
                ApplicationArea = All;
            }
        }
        modify(Description)
        {
            visible = false;
        }
    }
    actions
    {
        addafter("&Item Tracing")
        {
            action(Barcode)
            {
                Image = BarCode;
                ApplicationArea = all;
                CaptionML = FRA = 'Ticket Article';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lSerialInfo: Record 6504;
                    lRepPFTicket: Report "WDC PF Ticket";


                begin
                    Clear(lSerialInfo);
                    lSerialInfo.Reset();
                    lSerialInfo.SetRange("Serial No.", Rec."Serial No.");
                    If lSerialInfo.FindFirst() then begin
                        lRepPFTicket.SetTableView(lSerialInfo);
                        lRepPFTicket.Run();
                    end;

                end;
            }

        }
    }
}
