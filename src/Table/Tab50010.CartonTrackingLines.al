table 50010 "Carton Tracking Lines"
{
    Caption = 'Lignes Traçabilité Carton';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Carton No."; Code[20])
        {
            Caption = 'No. Carton';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'No. article';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Ref Line No."; Integer)
        {
            Caption = 'Ref Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Serial No."; Code[50])
        {
            Caption = 'No. de série';
            DataClassification = ToBeClassified;
            TableRelation = "Serial No. Information"."Serial No." where(Inventory = filter(<> 0),
                                                         "Assembled in Carton" = filter(''));
            trigger OnValidate()
            var
                lItemLedgEnt: Record "Item Ledger Entry";
                lItem: Record Item;
                ltext001: Label 'N° serie ne doit pas être vide';
            begin
                if "Serial No." <> '' then begin
                    Rec."Item No." := '';
                    Rec."Lot No." := '';
                    Rec."Variant Code" := '';
                    Quantity := 0;
                    lItemLedgEnt.Reset;
                    lItemLedgEnt.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                    lItemLedgEnt.SetRange("Serial No.", rec."Serial No.");
                    if lItemLedgEnt.FindFirst() then begin
                        Quantity := 1;
                        Rec."Lot No." := lItemLedgEnt."Lot No.";
                        Rec."Variant Code" := lItemLedgEnt."Variant Code";
                        Rec."Item No." := lItemLedgEnt."Item No.";
                        lItem.Get(lItemLedgEnt."Item No.");
                        Rec."Item Description" := lItem.Description;
                    end;
                    ControlItemRefCustomer;
                end else
                    Error(ltext001);
            end;

        }
        field(6; "Lot No."; Code[50])
        {
            Caption = 'No. de lot';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Lot No. Information" where("Item No." = field("Item No."),
                                                         Inventory = filter(<> 0));
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantité';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Order No."; Code[20])
        {
            Caption = 'N° Commande';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(9; "Shipment No."; Code[20])
        {
            Caption = 'N° Expédition';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Item Ledger Entry"."Document No." WHERE("Serial No." = FIELD("Serial No."),
                                                                  "Entry Type" = const(Sale),
                                                                  "Document Type" = const("Sales Shipment")));
        }


        field(10; "Customer No."; Code[20])
        {
            Caption = 'No. client';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Editable = false;
            trigger OnValidate()
            var
                lCustomer: Record Customer;
            begin
                Rec."Customer Name" := '';
                if lCustomer.Get(rec."Customer No.") then
                    Rec."Customer Name" := lCustomer.Name;
            end;
        }
        field(11; "Customer Name"; Text[100])
        {
            Caption = 'Nom client';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(12; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            Editable = false;
        }
        field(13; "Shipment Line No."; Integer)
        {
            Caption = 'Ligne Expédition';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Item Ledger Entry"."Document Line No." WHERE("Serial No." = FIELD("Serial No."),
                                                                  "Entry Type" = const(Sale),
                                                                  "Document Type" = const("Sales Shipment")));
        }
        field(14; "Order Line No."; Integer)
        {
            Caption = 'No. ligne commande ';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Ship to code"; Code[20])
        {
            Caption = 'Code destinataire';
            DataClassification = ToBeClassified;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Customer No."));
            trigger OnValidate()
            var
                lShipAdresse: Record "Ship-to Address";
            begin
                Rec."Ship to name" := '';
                lShipAdresse.Reset();
                lShipAdresse.SetRange(Code, Rec."Ship to code");
                if lShipAdresse.FindFirst() Then
                    Rec."Ship to name" := lShipAdresse.Name;
            end;

        }
        field(16; "Ship to name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom destinataire';
            Editable = false;
        }
        field(17; "Item Description"; Text[100])
        {
            Caption = 'Description article';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Carton No.", "Item No.", "Ref Line No.", "Serial No.", "Customer No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        lCarton: Record Carton;
        ltext001: Label 'N° serie ne doit pas être vide';
    begin
        if "Serial No." = '' then
            Error(ltext001);
        if lCarton.Get(Rec."Carton No.") then
            rec.Validate("Ship to code", lCarton."Ship to code");

    end;

    trigger OnModify()
    var
        lCarton: Record Carton;
        ltext001: Label 'N° serie ne doit pas être vide';
    begin
        if "Serial No." = '' then
            Error(ltext001);
        if lCarton.Get(Rec."Carton No.") then
            rec.Validate("Ship to code", lCarton."Ship to code");


    end;

    procedure ControlItemRefCustomer()
    var
        lItemRef: record "Item Reference";
        lText001: Label 'Cet article n''est pas à ce client.\ Veuillez vérifier!!';
        lText002: Label 'Article de client inconnu,\veillez remplir le client pour cet article';
    begin
        lItemRef.Reset();
        lItemRef.SetRange("Item No.", Rec."Item No.");
        if lItemRef.FindFirst() then BEGIN // Pour éviter les erreurs des articles qui n'ont pas des réference 
            lItemRef.SetRange("Reference Type", lItemRef."Reference Type"::Customer);
            lItemRef.SetRange("Reference Type No.", Rec."Customer No.");
            If Not lItemRef.FindFirst() then
                Error(ltext001);
        END ELSE
            Error(lText002);
    end;
}
