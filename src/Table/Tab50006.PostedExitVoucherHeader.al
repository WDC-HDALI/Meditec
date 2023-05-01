table 50006 "Posted Exit Voucher Header"
{

    Caption = 'Bon de sortie Enreg.';
    DrillDownPageID = "Posted Exit Voucher List PDR";
    LookupPageID = "Posted Exit Voucher List PDR";

    fields
    {

        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Date Comptabilisation';
        }

        field(3; Status; Enum "WDC PDR Status")
        {
            Caption = 'Statut';
            Editable = false;
        }
        field(4; "Name Concerned Person"; Text[100])
        {
            Caption = 'Nom Personne concerné';
        }

        field(5; Comment; Text[100])
        {
            Caption = 'Commentaire';
        }

        field(6; "Pre-Assigned No."; Code[20])
        {
            Caption = 'N° pré-attribués';
        }
        field(7; "Created by"; Text[50])
        {
            Caption = 'Crée par';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {

        }

    }


    fieldgroups
    {
        fieldgroup(DropDown; "No.")
        {
        }
    }
    trigger OnInsert()
    begin
        WhseSetup.get;
        "No." := NoSeriesManagement.GetNextNo(WhseSetup."Posted Exit Voucher PDR Nos.", 0D, TRUE);
    end;

    var
        WhseSetup: Record "Warehouse Setup";
        NoSeriesManagement: Codeunit 396;
}

