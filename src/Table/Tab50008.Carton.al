table 50008 Carton
{
    Caption = 'Carton';
    DataClassification = ToBeClassified;
    LookupPageId = "Carton List";
    DrillDownPageId = "Carton List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Item Carton No."; Code[20])
        {
            Caption = 'No. article carton';
            DataClassification = ToBeClassified;
            TableRelation = Item where("Packaging Type" = const(Carton));
            trigger OnValidate()
            var
                lItem: Record Item;
            begin
                Rec."Item Description" := '';
                if lItem.Get(rec."Item Carton No.") then
                    Rec."Item Description" := lItem.Description;
            end;
        }
        field(3; "Item Description"; Text[100])
        {
            Caption = 'Description article';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Serial No."; Text[50])
        {
            Caption = 'No. Serie carton';
            DataClassification = ToBeClassified;
        }
        field(5; "Assembly Date"; Date)
        {
            Caption = 'Date assemblage';
            DataClassification = ToBeClassified;
        }
        field(6; Status; Enum "WDC Carton Status")
        {
            Caption = 'Statut';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Shipped; Boolean)
        {
            Caption = 'Expédié';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Customer No."; Code[20])
        {
            Caption = 'No. client';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
                lCustomer: Record Customer;
                lCartTrackLines: Record "Carton Tracking Lines";
                ltext001: Label 'Les lignes carton seront supprimés\ voulez-vous continuez?';


            begin
                lCartTrackLines.Reset();
                lCartTrackLines.SetRange("Carton No.", "No.");
                if lCartTrackLines.FindFirst() Then //begin
                    if Not Confirm(lText001) Then
                        Error('Cliquer F5 pour actualiser')
                    ELSE
                        lCartTrackLines.DeleteAll();
                Rec."Customer Name" := '';
                if lCustomer.Get(rec."Customer No.") then begin
                    Rec."Customer Name" := lCustomer.Name;
                    Rec."Serial No." := CopyStr("Customer Name" + '-' + Rec."No.", 1, 50);
                end;

            end;
        }
        field(9; "Customer Name"; Text[100])
        {
            Caption = 'Nom client';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Item No. Filter"; Code[20])
        {
            Caption = 'Filtre No.article';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Qty Item"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Carton Tracking Lines".Quantity where("Item No." = field("Item No. Filter"),
            "Carton No." = field("No.")));
            Editable = false;
        }
        field(12; "Lot No."; Code[50])
        {
            Caption = 'No. Lot';
            DataClassification = ToBeClassified;
            TableRelation = "Lot No. Information"."Lot No." where("Item No." = field("Item Carton No."),
                                                         Inventory = filter(<> 0));                                             //WDC.SH


        }
        field(13; Selected; Boolean)
        {
            Caption = 'Sélectionné';
            DataClassification = ToBeClassified;

        }
        field(14; "Not Tot. shipped"; Boolean)
        {
            Caption = 'Reste à expédier';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist("Carton Tracking Lines" WHERE("Carton No." = field("No."),
            "Order No." = filter('')));
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(PK1; "Selected", "Customer No.", "No.")
        {

        }
    }
    trigger OnInsert()
    begin
        WhseSetup.get;
        "No." := NoSeriesManagement.GetNextNo(WhseSetup."Carton Nos.", 0D, TRUE);
        "Assembly Date" := WorkDate();
    end;

    trigger OnDelete()

    Var
        lCartonLines: Record "Carton Tracking Lines";
    begin
        lCartonLines.Reset();
        lCartonLines.SetRange("Carton No.", Rec."No.");
        lCartonLines.DeleteAll();
    end;

    var
        WhseSetup: Record "Warehouse Setup";
        NoSeriesManagement: Codeunit 396;
}
