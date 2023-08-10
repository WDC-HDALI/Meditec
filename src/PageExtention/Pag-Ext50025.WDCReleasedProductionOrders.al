pageextension 50025 "WDCReleased Production Orders" extends "Released Production Orders"
{
    actions
    {
        addlast(reporting)
        {
            action("FicheProd")
            {
                ApplicationArea = all;
                Caption = 'Fiche production';
                Image = "Report";
                trigger OnAction()
                begin
                    Report.Run(50016, true, false, Rec);
                end;
            }
        }
    }
}
