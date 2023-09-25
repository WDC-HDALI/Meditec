page 50022 "Update Destination Carton"
{

    Caption = 'Changer destination cartons';
    PageType = List;
    UsageCategory = Documents;
    SourceTable = Carton;
    SourceTableView = sorting("No.") where(Status = filter(Release),
    "Not Tot. Ordered" = filter(true));
    DeleteAllowed = false;
    InsertAllowed = false;
    CardPageId = "Closed Carton Card";
    ApplicationArea = all;
    Editable = true;
    layout
    {
        area(content)
        {
            group(Destination)
            {
                field(CustomerNo; CustomerNo)
                {
                    ApplicationArea = all;
                    TableRelation = Customer;
                    trigger OnValidate()
                    var
                        lCust: Record Customer;
                    begin
                        CustName := '';
                        DestCode := '';
                        DestName := '';
                        if lCust.get(CustomerNo) then
                            CustName := lCust.Name;
                    end;
                }

                field(CustName; CustName)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(DestCode; DestCode)
                {
                    Caption = 'Nouvelle destination';
                    ApplicationArea = all;
                    TableRelation = "Ship-to Address".Code;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lShipToadrPage: Page "Ship-to Address List";
                        lShiptoAdr: Record "Ship-to Address";
                    begin
                        DestCode := '';
                        DestName := '';
                        Clear(lShipToadrPage);
                        lShiptoAdr.Reset();
                        lShiptoAdr.SetRange("Customer No.", CustomerNo);
                        lShipToadrPage.SetTableView(lShiptoAdr);
                        if lShipToadrPage.RunModal() = ACTION::Ok then begin
                            lShipToadrPage.GetRecord(lShiptoAdr);
                            DestCode := lShiptoAdr.Code;
                            DestName := lShiptoAdr.Name;
                        end;


                    end;

                    trigger OnValidate()
                    begin
                        DestName := '';
                        ShiptoAdr.Reset();
                        ShiptoAdr.SetRange(Code, DestCode);
                        if ShiptoAdr.FindFirst() then
                            DestName := ShiptoAdr.Name;
                    end;
                }
                field(DestName; DestName)
                {
                    Caption = 'Nom destination';
                    ApplicationArea = all;
                    Editable = false;
                }

            }
            repeater(General)
            {
                Editable = true;
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Assembly Date"; Rec."Assembly Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Not Tot. shipped"; Rec."Not Tot. Ordered")
                {
                    ApplicationArea = All;

                }
                field("Ship to code"; Rec."Ship to code")
                {
                    ApplicationArea = All;

                }
                field("Ship to name"; Rec."Ship to name")
                {
                    ApplicationArea = All;

                }

            }
        }
    }

    actions
    {

        area(Processing)
        {


            action("Select all / Deselect all")
            {

                caption = 'Select all/Deselect all';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                Image = SelectLineToApply;
                InFooterBar = true;
                trigger OnAction()
                begin
                    SeelectDeselectAll;
                end;
            }
            action(ActChangeShipTo)
            {
                Image = Post;
                CaptionML = FRA = 'Changer code distinataire';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    ltext001: Label 'Voulez-vous changer la desination des cartons séléctionnés';
                begin
                    if Confirm(ltext001) then
                        ChangeShipTo();
                end;
            }
        }
    }
    procedure ChangeShipTo()
    var
        lsalesLines: Record "Sales Line";
        lCarton: Record Carton;
        lCarton2: Record Carton;
        lCartTrackLines: Record "Carton Tracking Lines";
        lcustomerNo: Code[20];
        ltext001: Label 'Le client de carton %1 est different de %2';
        ltext002: Label 'Veuillez renseigner le code client';
        ltext003: Label 'Veuillez renseigner la nouvelle destination';
        ltext004: Label 'Veuillez cocher les cartons à modifier';
    begin
        If DestCode = '' Then
            Error(ltext003);
        lCarton.Reset();
        lCarton.SetCurrentKey("Selected", "Customer No.", "No.");
        lCarton.SetRange(Selected, true);
        if lCarton.FindFirst() then begin
            repeat
                if lCarton."Customer No." <> CustomerNo then
                    Error(ltext001, lCarton."No.", CustomerNo);
                lCarton.Validate("Ship to code", DestCode);
                lCarton."Ship to name" := DestName;
                lCarton.Modify();
                lCartTrackLines.Reset();
                lCartTrackLines.SetRange("Carton No.", lCarton."No.");
                lCartTrackLines.ModifyAll("Ship to code", DestCode);
                lCartTrackLines.ModifyAll("Ship to name", DestName);
            until lCarton.Next() = 0;
        end ELSE
            Error(ltext004);
    END;

    trigger OnOpenPage()
    var
        lCarton: Record Carton;
    begin

        CurrPage.Editable := true;
        lCarton.ModifyAll("selected", false);
        CurrPage.Update();
    end;

    procedure SeelectDeselectAll()
    var

    begin
        If Not SelectedAll then begin
            Rec.ModifyAll(Rec.Selected, true);
            SelectedAll := true;
            CurrPage.Update;
        end Else begin
            SelectedAll := false;
            Rec.ModifyAll(Rec.Selected, false);
            CurrPage.Update;
        end;

    end;

    var
        TotalQte: Decimal;
        CurrDocNo: Code[20];
        CurrItemNo: Code[20];
        CurrLocation: Code[20];
        CurrDocLineNo: Integer;
        DocQty: Decimal;
        CurrDocType: enum "Sales Document Type";
        SelectedAll: Boolean;
        //QteToShip: Decimal;
        VariantLineNo: Integer;
        DestCode: Code[20];
        DestName: Text[100];
        ShiptoAdr: Record "Ship-to Address";
        CustomerNo: code[20];
        CustName: Text[100];
}
