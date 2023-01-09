tableextension 50008 "WDC Item Template" extends "Item Templ."
{
    fields
    {
        field(50000; "Item Stage"; Code[20])
        {
            CaptionML = FRA = 'Etage article', ENU = 'Item Stage';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Item Stage";
        }
        //50001 don't use it on account of transferField
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
                if not "Packing Item" then
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
    }

}