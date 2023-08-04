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
    }
}
