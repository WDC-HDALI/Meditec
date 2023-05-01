table 50004 "Exit Voucher Header"
{

    Caption = 'Bon de sortie';
    DrillDownPageID = "Exit Voucher List PDR";
    LookupPageID = "Exit Voucher List PDR";

    fields
    {

        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
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
        "No." := NoSeriesManagement.GetNextNo(WhseSetup."Exit Voucher PDR Nos.", 0D, TRUE);
        "Posting Date" := WorkDate();
        "Created by" := UserId;
    end;

    trigger OnDelete()

    Var
        ExitVoucherLines: Record "Exit Voucher Lines";
    begin
        ExitVoucherLines.Reset();
        ExitVoucherLines.SetRange("Document No.", Rec."No.");
        ExitVoucherLines.DeleteAll();
    end;

    var
        WhseSetup: Record "Warehouse Setup";
        NoSeriesManagement: Codeunit 396;
}

