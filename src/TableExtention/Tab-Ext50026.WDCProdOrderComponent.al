tableextension 50026 "WDCProdOrderComponent " extends "Prod. Order Component"
{
    fields
    {
        field(50000; "Tracking quantity"; Decimal)
        {
            CaptionML = ENU = 'Tracking quantity', FRA = 'Quantité Traçabilité';
            Editable = false;
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = field("Item No."),
            "Source ID" = field("Prod. Order No."),
            "Source Prod. Order Line" = field("Prod. Order Line No."),
            "Source Ref. No." = field("Line No."),
            "Source Type" = filter(5407)));
            FieldClass = FlowField;
        }

    }
    //<<WDC.IM

    trigger OnModify()
    var
        TransferLine: Record "Transfer Line";
        text001: TextConst FRA = 'Vous ne pouvez pas modifier une ligne composant liée par un ordre de transfert ouvert', ENU = 'You cannot change componant line linked by a transfer order';
    begin
        TransferLine.Reset();
        TransferLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        //TransferLine.SetRange("Prod. Order Line", Rec."Prod. Order Line No.");
        //TransferLine.SetRange("Item No.", Rec."Item No.");
        //TransferLine.SetRange("Routing Link Code", Rec."Routing Link Code");
        if TransferLine.FindSet() then
            Error(text001, Rec."Item No.");
    end;

    trigger OnDelete()
    var
        TransferLine: Record "Transfer Line";
        text001: TextConst FRA = 'Vous ne pouvez pas supprimer une ligne composant liée par un ordre de transfert ouvert', ENU = 'You cannot delete a componant line linked by a transfer order';
    begin
        TransferLine.Reset();
        TransferLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        //TransferLine.SetRange("Prod. Order Line", Rec."Prod. Order Line No.");
        //TransferLine.SetRange("Item No.", Rec."Item No.");
        //TransferLine.SetRange("Routing Link Code", Rec."Routing Link Code");
        if TransferLine.FindSet() then
            Error(text001, Rec."Item No.");

    end;
    //>>WDC.IM
}
