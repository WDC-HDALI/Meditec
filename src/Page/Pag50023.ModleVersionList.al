page 50023 "Model List"
{
    //WDC01  17/01/2024  WDC.CHG  CREATE THIS CURRENT OBJECT 


    Caption = 'Modéle version articles';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Item Model";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                }
                field("Model Description"; Rec."Model Description")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;


                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Creation date"; Rec."Creation date")
                {
                    ApplicationArea = All;
                }
                field("Season"; Rec."Season")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}
