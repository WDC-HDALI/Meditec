table 50011 "Item Model"
{
    //WDC01  17/01/2024  WDC.CHG  CREATE THIS CURRENT OBJECT 
    Caption = 'Modéles articles';
    DrillDownPageID = "Model List";
    LookupPageID = "Model List";
    fields
    {
        field(1; "Item No."; Code[20])
        {
            CaptionML = FRA = 'N° article', ENU = 'Item No.';
            TableRelation = Item;
            trigger OnValidate()
            begin
                Item.Reset();
                Item.SetRange(Item."No.", "Item No.");
                IF Item.findset THEN
                    "Item Description" := Item.Description;

            end;
        }
        field(2; "Item Description"; Text[50])
        {
            CaptionML = FRA = 'Description article', ENU = 'Item Description';
            Editable = false;

        }
        field(3; "Model No."; Code[20])
        {
            CaptionML = FRA = 'N° modéle', ENU = 'Model No.';
        }
        field(4; "Model Description"; Text[50])
        {
            CaptionML = FRA = 'Modéle Description', ENU = 'Description Model';
        }
        field(5; "Customer No."; Code[20])
        {
            CaptionML = FRA = 'N° client', ENU = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            begin
                customer.Reset();
                customer.SetRange(customer."No.", "Customer No.");
                IF customer.findset THEN
                    "Customer Name" := customer.Name;
            end;
        }
        field(6; "Customer Name"; Text[50])
        {
            CaptionML = FRA = 'Nom client', ENU = 'Customer Name';
            Editable = false;
        }
        field(7; "Creation date"; Date)
        {
            CaptionML = FRA = 'Date de Création', ENU = 'Creation date';
        }
        field(8; "Season"; Text[50])
        {
            CaptionML = FRA = 'Saison.', ENU = 'Season';
        }
    }
    keys
    {
        key(Key1; "Model No.", "Item No.")
        {
            Clustered = true;
        }

    }
    var
        Item: Record Item;
        customer: Record Customer;
}

