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


}
