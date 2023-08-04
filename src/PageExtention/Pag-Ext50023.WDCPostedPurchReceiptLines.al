pageextension 50023 "WDC Posted Purch Receipt Lines" extends "Posted Purchase Receipt Lines"
{
    actions
    {
        addlast(Creation)
        {
            action("Update Purch Lines")
            {
                ApplicationArea = all;
                Image = UpdateShipment;
                trigger OnAction()
                var

                begin
                    Report.Run(50014);
                end;

            }
        }

    }
}
