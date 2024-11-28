tableextension 50025 "WDC Production Order" extends "Production Order"
{
    //WDC01  17/01/2024  WDC.CHG Add nex field "Model"
    fields
    {
        field(50000; "Model"; Code[20])
        {
            CaptionML = FRA = 'Modéle', ENU = 'Model';
            TableRelation = "Item Model"."Model No." where("Item No." = field("Source No."));
        }
        field(50001; DeclProd; Boolean)
        {

        }
    }
}
