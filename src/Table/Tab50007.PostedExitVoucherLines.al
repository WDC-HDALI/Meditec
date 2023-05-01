table 50007 "Posted Exit Voucher Lines"
{
    Caption = 'Lignes bon sortie';
    DrillDownPageID = "Posted Exit Voucher Lines";
    LookupPageID = "Posted Exit Voucher Lines";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Exit Voucher Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'No. Line';
        }
        field(3; "No."; Code[20])
        {

            Caption = 'No.';
            TableRelation = Item where("Gen. Prod. Posting Group" = filter('PDR'));
            trigger OnValidate()
            var
                lItem: Record Item;
            begin
                if lItem.Get("No.") then begin
                    Description := lItem.Description;
                    Quantity := 1;

                end;
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 3;
        }
        field(7; "Location Code"; Code[20])
        {
            Caption = 'Code magasin';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(8; "Machine reference"; Text[100])
        {
            Caption = 'Référnce machine';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    begin
        "Line No." := GetNextLines(Rec."Document No.")
    end;

    procedure GetNextLines(pDocumentNo: Code[20]): Integer
    var
        lExitVoucherLines: Record "Exit Voucher Lines";

    begin
        lExitVoucherLines.Reset();
        lExitVoucherLines.SetRange("Document No.", pDocumentNo);
        If lExitVoucherLines.FindLast() then
            exit(lExitVoucherLines."Line No." + 10000);
        exit(10000);

    end;
}

