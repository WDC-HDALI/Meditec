tableextension 50002 "WDC Item" extends Item
{
    /*******************************Documentation*************************************************
    WDC02     WDC.IM      10/10/2024      Include MP In Exit Voucher
    WDC03     WDC.IM      31/10/2024      Add Fields
    **********************************************************************************************/
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
        //<<WDC02
        field(50007; "Include In Exit Voucher"; Boolean)
        {
            CaptionML = FRA = 'Inclure bon sorti', ENU = 'Include In Exit Voucher';
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     ApprovalEntry: Record "Approval Entry";
            // begin
            //     if "Include In Exit Voucher" = true then begin
            //         ApprovalEntry.Reset();
            //         ApprovalEntry.SetRange("Table ID", 27);
            //         ApprovalEntry.Setrange("Record ID to Approve", Rec.RecordId);
            //         if ApprovalEntry.FindLast() then begin
            //             if ApprovalEntry.Status = ApprovalEntry.Status::Open then
            //                 Error('Demande d''approbation pour inclure cet article dans bon sortie est encour')
            //             else if ApprovalEntry.Status = ApprovalEntry.Status::Approved then
            //                 Error('Cet article est déja approuvé');
            //         end
            //         else begin
            //             Message('Demande d''approbation pour inclure cet article dans bon sortie est envoyer');
            //         end;
            //     end;
            //     // else begin
            //     //     ApprovalEntry.Reset();
            //     //     ApprovalEntry.SetRange("Table ID", 27);
            //     //     ApprovalEntry.Setrange("Record ID to Approve", Rec.RecordId);
            //     //     if ApprovalEntry.FindLast() then begin
            //     //         if ApprovalEntry.Status = ApprovalEntry.Status::Open then
            //     //             Error('Demande d''approbation pour exlure cet article du bon sorti est encour')
            //     //         else if ApprovalEntry.Status = ApprovalEntry.Status::Approved then
            //     //             Message('Demande d''approbation pour exlure cet article du bon sorti est envoyer');
            //     //     end
            //     //     else begin

            //     //     end;
            //     // end;
            // end;
        }
        /*field(50008; "Demand Approve"; Enum "WDCItemDemandApprove")
        {
            DataClassification = ToBeClassified;
            CaptionML = FRA = 'Inclure bon sorti', ENU = 'Include In Exit Voucher';
        }*/
        //>>WDC02
        //<<WDC03
        field(50009; SKU; Text[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'SKU', FRA = 'SKU';
        }
        field(50010; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Factory Code', FRA = 'Factory Code';
        }
        field(50011; "Retail Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Retail Code', FRA = 'Retail Code';
        }
        //>>WDC03
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

