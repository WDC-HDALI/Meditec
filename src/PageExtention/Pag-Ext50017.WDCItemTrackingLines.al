pageextension 50017 "WDC Item Tracking Lines" extends "Item Tracking Lines"
{
    actions
    {
        addbefore("Select Entries")
        {
            action("Select Package")
            {
                ApplicationArea = all;
                Image = Compress;
                // RunObject = page 50011;
                CaptionML = FRA = 'Sélectionner carton';
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lAssembOrdersPage: page 50011;
                    lPostedAssembOrders: Record "Posted Assembly Header";
                begin
                    //                       Item.RESET;
                    //   CLEAR(ModelVersionList);
                    //   Item.SETRANGE("Make Code",Rec.Mark);
                    //   Item.SETRANGE("Model Code",Model);
                    //   Item.SETRANGE("Item Type", Item."Item Type"::"Model Version");
                    //   lAssembOrdersPage.SETTABLEVIEW(Item);
                    //   lAssembOrdersPage.SETRECORD(Item);
                    IF lAssembOrdersPage.RUNMODAL = ACTION::OK THEN BEGIN
                        Message('ok');
                    END;
                end;
            }

        }

    }
}
