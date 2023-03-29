pageextension 50012 "WDC Item Journal" extends "Item Journal"
{
    actions
    {
        addbefore("&Print")
        {

            action(ImportStock)
            {
                RunObject = xmlport "WDC Import Stock";
                Image = Import;
                ApplicationArea = all;
                CaptionML = FRA = 'Import stock';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
            }
        }
    }
}
