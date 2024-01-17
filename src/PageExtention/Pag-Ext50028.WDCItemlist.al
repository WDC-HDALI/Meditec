pageextension 50028 "WDC Item list" extends "Item List"
{
    actions
    {
        addafter("Prepa&yment Percentages")
        {
            action(Barcode)
            {
                Image = BarCode;
                ApplicationArea = all;
                CaptionML = FRA = 'Code à barre article';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lItem: Record 27;
                    lRepItemBarcode: Report "WDC Item Barcode";


                begin
                    Clear(lItem);
                    lItem.Reset();
                    lItem.SetRange("Packaging Type", lItem."Packaging Type"::Carton);
                    If lItem.FindFirst() then begin
                        lRepItemBarcode.SetTableView(lItem);
                        lRepItemBarcode.Run();
                    end;

                end;
            }

        }
    }

}

