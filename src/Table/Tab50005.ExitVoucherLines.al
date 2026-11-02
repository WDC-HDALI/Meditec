table 50005 "Exit Voucher Lines"
{
    //*************************************Documentation******************************
    //WDC01     30.08.2024      WDC.IM      Add filter "Variant code"
    //WDC02     04.09.2024      WDC.IM      Include MP 
    //********************************************************************************
    Caption = 'Lignes bon sortie';
    DrillDownPageID = "Exit Voucher Lines";
    LookupPageID = "Exit Voucher Lines";

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
            TableRelation = Item where("Gen. Prod. Posting Group" = filter('PDR|CONS'));
            //TableRelation = Item where("Gen. Prod. Posting Group" = filter('PDR|CONS|MP'));//WDC02
            trigger OnValidate()
            var
                lItem: Record Item;
                text001: TextConst ENU = 'This item is not allowed to use in Exit Voucher', FRA = 'Cet Article N''est pas autorisé à utiliser dans Bon sortie';
            begin
                if lItem.Get("No.") then begin
                    //<<WDC02
                    //If (lItem."Gen. Prod. Posting Group" = 'MP') and (lItem."Include In Exit Voucher" = false) then
                    //  error(text001);
                    //>>WDC02    
                    Description := lItem.Description;
                    Quantity := 1;
                    //"Location Code" := 'MAG-PDR';
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
        field(8; "Machine reference"; Code[20])
        {
            Caption = 'Référnce machine';
            TableRelation = Resource where(Type = filter('Machine'));
            trigger OnValidate()
            var
                lMachine: Record Resource;
            begin
                Rec."Machine Name" := '';
                if lMachine.Get(rec."Machine reference") then
                    Rec."Machine Name" := lMachine.Name;
            end;
        }
        field(9; "Machine Name"; Text[100])
        {
            Caption = 'Nom machine';
            Editable = false;
        }

        field(10; "Work Center No."; Code[20])
        {
            Caption = 'N° Atelier';
            TableRelation = "Work Center";
            trigger OnValidate()
            var
                lWorkCenter: Record "Work Center";
            begin
                Rec."Work Center Name" := '';
                if lWorkCenter.Get("Work Center No.") then
                    Rec."Work Center Name" := lWorkCenter.Name;
            end;
        }
        field(11; "Work Center Name"; Text[100])
        {
            Caption = 'Nom Atelier';
            Editable = false;
        }

        field(12; "Lot No."; Code[20])
        {
            Caption = 'No. Lot';
            TableRelation = "Lot No. Information"."Lot No." where("Item No." = field("No."),
                                                                 "Location Filter" = field("Location Code"),
                                                                 Inventory = filter(<> 0),
                                                                 "Variant Code" = field("Variant Code"));//WDC01
        }
        field(13; Inventory; Decimal)
        {

            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Lot No." = FIELD("Lot No."),
                                                                  "Location Code" = FIELD("Location code"),
                                                                  "Variant Code" = field("Variant Code")));//WDC01
            Caption = 'Stock';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Variant Code"; Code[10])//WDC.IM
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = field("No."));
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

