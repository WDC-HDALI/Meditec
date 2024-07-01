tableextension 50002 "WDC Item" extends Item
{
    DrillDownPageID = "Item Lookup"; //WDC01.CHG
    LookupPageID = "Item Lookup"; //WDC01.CHG
    fields
    {
        field(50000; "Item Stage"; Code[20])
        {
            CaptionML = FRA = 'Etage article', ENU = 'Item Stage';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Item Stage";
        }
        field(50001; "Customer Code"; Code[20])
        {
            CaptionML = FRA = 'Code client', ENU = 'Custmer Code';
            TableRelation = "Customer";
            DataClassification = ToBeClassified;
        }
        field(50002; "Packing Item"; Boolean)
        {
            CaptionML = FRA = 'Article d''emballage', ENU = 'Packing Item';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                if Not "Packing Item" then
                    "Packaging Type" := "Packaging Type"::" ";
            end;

        }
        field(50003; "Packaging Type"; Enum "WDC Packing Type")
        {
            CaptionML = FRA = 'Type d''emballage', ENU = 'Packaging Type';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ltext001: Label 'Le champs article d''emballage doit être activé';
            begin
                if (not "Packing Item") and ("Packaging Type" <> "Packaging Type"::" ") Then
                    error(ltext001);
            end;
        }
        field(50004; "SubCategorie"; Code[20])
        {
            CaptionML = FRA = 'Code sous catégorie', ENU = 'SubCategorie Code';
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                SubCatgList: page 50002;
                SubCategories: Record 50001;
            begin
                CLEAR(SubCatgList);
                SubCategories.RESET;
                SubCategories.SETRANGE("Item Category Code", rec."Item Category Code");
                SubCatgList.SETTABLEVIEW(SubCategories);
                SubCatgList.SETRECORD(SubCategories);
                IF SubCatgList.RUNMODAL = ACTION::OK THEN BEGIN
                    SubCatgList.GETRECORD(SubCategories);
                    SubCategorie := SubCategories.Code;
                END;
            end;


        }
        field(50005; "Item Mussel"; Code[20])
        {
            CaptionML = FRA = 'Moule article', ENU = 'Item Mussel';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Item Mussel";
        }
        field(50006; "Transport cost"; Boolean)
        {
            CaptionML = FRA = 'Frais Transport', ENU = 'Transport cost';
            DataClassification = ToBeClassified;
        }

        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            var

            begin
                Clear(SubCategorie);
            end;
        }




    }
}

