table 50008 Carton
{
    CaptionML = ENU = 'Boxe', FRA = 'Carton';
    DataClassification = ToBeClassified;
    // LookupPageId = "Carton List";
    //DrillDownPageId = "Carton List";

    LookupPageId = "Closed Carton List";
    DrillDownPageId = "Closed Carton List";

    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            DataClassification = ToBeClassified;
        }
        field(2; "Item Carton No."; Code[20])
        {
            CaptionML = ENU = 'Item Boxe No.', FRA = 'N° article carton';
            DataClassification = ToBeClassified;
            TableRelation = Item where("Packaging Type" = const(Carton));
            trigger OnValidate()
            var
                lItem: Record Item;
                lItemLedgerEnties: record "Item Ledger Entry";
                LotInformation: Record "Lot No. Information";
            begin
                Rec."Item Description" := '';
                "Lot No." := '';
                if lItem.Get(rec."Item Carton No.") then
                    Rec."Item Description" := lItem.Description;

                // lItemLedgerEnties.Reset();
                // lItemLedgerEnties.SetCurrentKey("Item No.", "Posting Date");
                // lItemLedgerEnties.SetRange("Item No.", "Item Carton No.");
                // lItemLedgerEnties.SetRange(Open, true);
                // lItemLedgerEnties.SetFilter("Lot No.", '<>%1', '');
                // lItemLedgerEnties.SetFilter("Remaining Quantity", '<>%1', 0);
                // IF lItemLedgerEnties.FindFirst() then
                //     "Lot No." := lItemLedgerEnties."Lot No.";
                LotInformation.Reset();
                LotInformation.SetRange("Item No.", "Item Carton No.");
                LotInformation.SetFilter(Inventory, '<>%1', 0);
                LotInformation.SetFilter("Location Filter", 'MAG-MC');
                If LotInformation.FindFirst() then
                    "Lot No." := LotInformation."Lot No.";

            end;
        }
        field(3; "Item Description"; Text[100])
        {
            CaptionML = FRA = 'Description article', ENU = 'Item Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Serial No."; Text[50])
        {
            CaptionML = FRA = 'N° serie carton', ENU = 'Boxe Serial No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Assembly Date"; Date)
        {
            CaptionML = FRA = 'Date assemblage', ENU = 'Assembly';
            DataClassification = ToBeClassified;
        }
        field(6; Status; Enum "WDC Carton Status")
        {
            CaptionML = ENU = 'Statut', FRA = 'Statut';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Shipped; Boolean)
        {
            CaptionML = FRA = 'Expédié', ENU = 'Shipped';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Customer No."; Code[20])
        {
            CaptionML = FRA = 'N° client', ENU = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
                lCustomer: Record Customer;
                lCartTrackLines: Record "Carton Tracking Lines";
                ltext001: TextConst FRA = 'Les lignes carton seront supprimés\ voulez-vous continuez?',
                                    ENU = 'The boxe lines will be removed; do you want to continue?';
            begin
                lCartTrackLines.Reset();
                lCartTrackLines.SetRange("Carton No.", "No.");
                if lCartTrackLines.FindFirst() Then
                    if Not Confirm(lText001) Then
                        Error('Cliquer F5 pour actualiser')
                    ELSE
                        lCartTrackLines.DeleteAll();
                Rec."Customer Name" := '';
                Rec.Validate("Ship to code", '');
                Rec.Validate("Item Carton No.", '');
                Rec."Serial No." := '';
                if lCustomer.Get(rec."Customer No.") then begin
                    Rec."Customer Name" := lCustomer.Name;
                    Rec."Serial No." := CopyStr("Customer Name" + '-' + Rec."No.", 1, 50);
                end;

            end;
        }
        field(9; "Customer Name"; Text[100])
        {
            CaptionML = FRA = 'Nom client', ENU = 'Customer Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Item No. Filter"; Code[20])
        {
            CaptionML = FRA = 'Filtre N° article', ENU = 'Item No. Filter';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Qty Item"; Decimal)
        {
            CaptionML = FRA = 'Quantité article', ENU = 'Item Qty';
            FieldClass = FlowField;
            CalcFormula = sum("Carton Tracking Lines".Quantity where("Item No." = field("Item No. Filter"),
            "Carton No." = field("No.")));
            Editable = false;
        }
        field(12; "Lot No."; Code[50])
        {
            CaptionML = FRA = 'N° Lot', ENU = 'Lot No.';
            DataClassification = ToBeClassified;
            TableRelation = "Lot No. Information"."Lot No." where("Item No." = field("Item Carton No."),
                                                         Inventory = filter(<> 0),
                                                         "Location Filter" = filter('MAG-MC'));
        }
        field(13; Selected; Boolean)
        {
            CaptionML = FRA = 'Sélectionné', ENU = 'Selected';
            DataClassification = ToBeClassified;

        }
        field(14; "Not Tot. Ordered"; Boolean)
        {
            CaptionML = FRA = 'Rester à utiliser', ENU = 'Not Tot. Ordered';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist("Carton Tracking Lines" WHERE("Carton No." = field("No."),
            "Order No." = filter('')));
        }

        field(15; "Ship to code"; Code[20])
        {
            CaptionML = FRA = 'Code destinataire', ENU = 'Ship to code';
            DataClassification = ToBeClassified;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Customer No."));
            trigger OnValidate()
            var
                lShipAdresse: Record "Ship-to Address";
                ltrackCarton: Record "Carton Tracking Lines";
            begin
                Rec."Ship to name" := '';
                lShipAdresse.Reset();
                lShipAdresse.SetRange(Code, Rec."Ship to code");
                if lShipAdresse.FindFirst() Then begin
                    Rec."Ship to name" := lShipAdresse.Name;
                    ltrackCarton.Reset();
                    ltrackCarton.Setrange("Carton No.", rec."No.");
                    ltrackCarton.SetRange("Customer No.", Rec."Customer No.");
                    ltrackCarton.ModifyAll("Ship to code", rec."Ship to code");
                    ltrackCarton.ModifyAll("Ship to name", rec."Ship to name");
                end;
            end;
        }
        field(16; "Ship to name"; Text[100])
        {
            DataClassification = ToBeClassified;
            CaptionML = FRA = 'Nom destinataire', ENU = 'Ship to name';
            Editable = false;
        }
        field(17; "Not Tot. Shipped"; Boolean)
        {
            CaptionML = FRA = 'Reste à expédier', ENU = 'Not Tot. Shipped';
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
        NoSeriesManagement: Codeunit "No. Series";
}
