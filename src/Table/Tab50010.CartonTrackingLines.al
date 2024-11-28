table 50010 "Carton Tracking Lines"
{
    Caption = 'Lignes Traçabilité Carton';
    DataClassification = ToBeClassified;
    LookupPageId = "Carton Tracking List";
    DrillDownPageId = "Carton Tracking List";

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
                                                         "Assembled in Carton" = filter(''),
                                                         "Location Filter" = filter('MAG-PF'));
            trigger OnValidate()
            var
                SerialNoInfo: Record "Serial No. Information";//WDC.IM
                lItemLedgEnt: Record "Item Ledger Entry";
                lItem: Record Item;
                ltext001: Label 'N° serie ne doit pas être vide';
                WDCSerialNoInformationList: page 50013;
            begin
                if "Serial No." <> '' then begin
                    Rec."Item No." := '';
                    Rec."Lot No." := '';
                    Rec."Variant Code" := '';
                    Quantity := 0;
                    lItemLedgEnt.Reset;
                    lItemLedgEnt.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                    lItemLedgEnt.SetRange("Serial No.", rec."Serial No.");
                    lItemLedgEnt.SetFilter("Location Code", 'MAG-PF');
                    lItemLedgEnt.SetRange(Open, TRUE);//WDC.IM
                    if lItemLedgEnt.FindFirst() then begin
                        if lItemLedgEnt.Count > 1 then begin
                            SerialNoInfo.Reset();
                            SerialNoInfo.SetRange("Serial No.", "Serial No.");
                            SerialNoInfo.SetFilter(Inventory, '<>%1', 0);
                            SerialNoInfo.SetFilter("Assembled in Carton", '= %1', '');
                            SerialNoInfo.SetFilter("Location Filter", '%1', 'MAG-PF');
                            if SerialNoInfo.FindSet() then begin
                                WDCSerialNoInformationList.SetTableView(SerialNoInfo);
                                if WDCSerialNoInformationList.RunModal = Action::LookupOK then begin
                                    WDCSerialNoInformationList.GetRecord(SerialNoInfo);
                                    lItemLedgEnt.Reset;
                                    lItemLedgEnt.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                                    lItemLedgEnt.SetRange("Serial No.", SerialNoInfo."Serial No.");
                                    lItemLedgEnt.SetFilter("Location Code", 'MAG-PF');
                                    lItemLedgEnt.SetRange(Open, TRUE);
                                    lItemLedgEnt.SetRange("Item No.", SerialNoInfo."Item No.");
                                    if lItemLedgEnt.FindFirst() then
                                        Rec."Lot No." := lItemLedgEnt."Lot No.";
                                    Quantity := 1;
                                    Rec."Variant Code" := SerialNoInfo."Variant Code";
                                    Rec."Item No." := SerialNoInfo."Item No.";
                                    lItem.Get(SerialNoInfo."Item No.");
                                    Rec."Item Description" := lItem.Description;
                                end;
                            end;
                        end else begin
                            Quantity := 1;
                            Rec."Lot No." := lItemLedgEnt."Lot No.";
                            Rec."Variant Code" := lItemLedgEnt."Variant Code";
                            Rec."Item No." := lItemLedgEnt."Item No.";
                            lItem.Get(lItemLedgEnt."Item No.");
                            Rec."Item Description" := lItem.Description;
                        end;
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
            Editable = false;//WDC.IM
            TableRelation = "Lot No. Information" where("Item No." = field("Item No."),
                                                                    Inventory = filter(<> 0),
                                                                    "Location Filter" = filter('MAG-PF'));
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
        //<<WDC.IM
        field(9; "Entry No. doc"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Item Ledger Entry"."Entry No." where("Serial No." = field("Serial No."), "Entry Type" = const(sale)));
        }
        field(10; "Entry No. Filter"; Integer)
        {

        }
        field(11; "Shipment No."; Code[20])
        {
            Caption = 'N° Expédition';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Item Ledger Entry"."Document No." WHERE("Entry No." = field("Entry No. Filter")));//WDC.IM
            //"Document Type" = const("Sales Shipment"))); //CMT WDC.IM
        }
        //>>WDC.IM
        field(12; "Customer No."; Code[20])
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
        field(13; "Customer Name"; Text[100])
        {
            Caption = 'Nom client';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(14; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            Editable = false;
        }
        field(15; "Shipment Line No."; Integer)
        {
            Caption = 'Ligne Expédition';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Item Ledger Entry"."Document Line No." WHERE("Entry No." = field("Entry No. Filter"))); //WDC.IM
            //                                                       "Document Type" = const("Sales Shipment"))); //CMT WDC.IM
        }
        field(16; "Order Line No."; Integer)
        {
            Caption = 'No. ligne commande ';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Ship to code"; Code[20])
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
        field(18; "Ship to name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom destinataire';
            Editable = false;
        }
        field(19; "Item Description"; Text[100])
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
        key(Key1; "Item No.", "Variant Code")//WDC.IM
        {
        }
        key(Key2; "Customer No.", "Carton No.", "Order No.")//WDC.IM
        {
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
        lItem: Record item;
        lText001: Label 'Cet article n''est pas à ce client.\ Veuillez vérifier!!';
        lText002: Label 'Article de client inconnu,\veillez remplir le client pour cet article';
    begin
        If lItem.Get(rec."Item No.") Then
            if (lItem."Customer Code" <> Rec."Customer No.") and (lItem."Customer Code" <> '') then
                Error(ltext001)
            else
                if (lItem."Customer Code" = '') then
                    Error(lText002);
    end;
}
