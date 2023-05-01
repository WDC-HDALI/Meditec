tableextension 50018 "Wdc Warhouse Setup" extends "Warehouse Setup"
{
    fields
    {
        field(50000; "Exit Voucher PDR Nos."; Code[20])
        {
            Caption = 'N° bon sortie PDR';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Posted Exit Voucher PDR Nos."; Code[20])
        {
            Caption = 'N° bon sortie PDR Enreg.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
