tableextension 50024 WDCTransferLine extends "Transfer Line"
{
    fields
    {
        field(50000; "Prod. Order No."; Code[20])
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° O.F.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Prod. Order Line"; Integer)
        {
            CaptionML = ENU = 'Prod. Order Line', FRA = 'Ligne O.F.';
            DataClassification = ToBeClassified;
        }
        field(50002; "Routing Link Code"; Code[20])
        {
            CaptionMl = ENU = 'Routing Link Code', FRA = 'Code atelier';
            DataClassification = ToBeClassified;
        }
        //<<WDC.IM
        field(50003; "Tracking quantity"; Decimal)
        {
            CaptionML = ENU = 'Shipping tracking quantity', FRA = 'Quantité Traçabilité éxpédition';
            Editable = false;
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = field("Item No."),
            "Source ID" = field("Document No."),
            //"Source Prod. Order Line" = field("Prod. Order Line"),
            "Source Ref. No." = field("Line No."),
            "Source Subtype" = filter(1),
            "Source Type" = filter(5741)));
            FieldClass = FlowField;
        }
        //>>WDC.IM
    }
}
