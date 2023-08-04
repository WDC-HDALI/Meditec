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
            begin
                ///Need Control to Item and customer
                Rec."Lot No." := '';
                Quantity := 0;
                lItemLedgEnt.Reset;
                lItemLedgEnt.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                lItemLedgEnt.SetRange("Serial No.", rec."Serial No.");
                if lItemLedgEnt.FindFirst() then begin
                    Quantity := 1;
                    Rec."Lot No." := lItemLedgEnt."Lot No.";
                    Rec."Item No." := lItemLedgEnt."Item No.";

                end;

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
    }
    keys
    {
        key(PK; "Carton No.", "Item No.", "Ref Line No.", "Serial No.", "Customer No.")
        {
            Clustered = true;
        }
    }

}
