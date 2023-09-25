page 50021 "Carton to Post"
{

    Caption = 'Cartons à expédier';
    PageType = List;
    SourceTable = Carton;
    SourceTableView = sorting("No.") where(Status = filter(Release),
    "Not Tot. Ordered" = filter(true));
    DeleteAllowed = false;
    InsertAllowed = false;
    CardPageId = "Closed Carton Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Item Carton No."; Rec."Item Carton No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            action(InsertTracking)
            {
                Image = Post;
                CaptionML = FRA = 'Valider';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    ltext001: Label 'Voulez-vous insérer les traçabiltés des cartons séléctionnées';
                begin
                    if Confirm(ltext001) then
                        createTracking();
                end;
            }


        }
    }

    trigger OnAfterGetRecord()
    begin

    end;

    procedure createTracking()
    var
        lsalesLines: Record "Sales Line";
        lCarton: Record Carton;
        lCarton2: Record Carton;
        lCartTrackLines: Record "Carton Tracking Lines";
    begin
        lsalesLines.Reset();
        lsalesLines.SetRange("Document No.", CurrDocNo);
        lsalesLines.SetRange(type, lsalesLines.Type::Item);
        if lsalesLines.FindFirst() then
            repeat
                lCarton.Reset();
                lCarton.SetCurrentKey("Selected", "Customer No.", "No.");
                lCarton.SetRange(Selected, true);
                if lCarton.FindFirst() then
                    repeat
                        lCarton2.Get(lCarton."No.");
                        lCarton2."Item No. Filter" := lsalesLines."No.";
                        lCarton2.SetFilter("Item No. Filter", lsalesLines."No.");
                        lCarton2.CalcFields("Qty Item");
                        lCartTrackLines.Reset();
                        lCartTrackLines.SetCurrentKey("Carton No.", "Item No.", "Ref Line No.", "Serial No.", "Customer No.");
                        lCartTrackLines.SetRange("Carton No.", lCarton."No.");
                        if lCartTrackLines.FindFirst() then
                            repeat
                                If (lCartTrackLines."order No." = '') and (lCartTrackLines."Item No." = lsalesLines."No.") THEN begin// CurrItemNo) then Begin
                                    If (lCartTrackLines."Variant Code" <> '') then BEGIN
                                        UpdateSalesLinewithvariant(CurrDocNo, lCartTrackLines."Order Line No.", lCartTrackLines."Item No.", lCartTrackLines."Variant Code");
                                        InsertItemSpecification(lCartTrackLines."Item No.", CurrLocation, lCartTrackLines."Serial No.", lCartTrackLines."Lot No.", lCartTrackLines."Variant Code", VariantLineNo);
                                        lCartTrackLines."Order Line No." := VariantLineNo;
                                        lCartTrackLines."Order No." := CurrDocNo;
                                        lCartTrackLines.Modify();
                                    END ELSE BEGIN
                                        InsertItemSpecification(lCartTrackLines."Item No.", CurrLocation, lCartTrackLines."Serial No.", lCartTrackLines."Lot No.", lCartTrackLines."Variant Code", lsalesLines."Line No.");
                                        lCartTrackLines."Order No." := CurrDocNo;
                                        lCartTrackLines."Order Line No." := lsalesLines."Line No.";
                                        lCartTrackLines.Modify();
                                    END;
                                End
                            until lCartTrackLines.Next() = 0;
                    until lCarton.Next() = 0;
                Update_Qty_SalesLines(lsalesLines."Document No.", lsalesLines."Line No.");
            until lsalesLines.Next() = 0;


    END;

    procedure InsertSalesLinewithvariant(pItemNo: code[20]; pVariantCode: Code[10]; pQty: Decimal)
    var
        lSalesLines: Record "Sales Line";
    begin
        lSalesLines.Reset();
        lSalesLines.SetRange("Document No.", CurrDocNo);
        if lSalesLines.FindLast() then
            VariantLineNo := lSalesLines."Line No." + 10000
        else
            VariantLineNo := 10000;

        lSalesLines.init;
        lSalesLines."Document Type" := lSalesLines."Document Type"::Order;
        lSalesLines."Document No." := CurrDocNo;
        lSalesLines.Type := lSalesLines.Type::Item;
        lSalesLines."Line No." := VariantLineNo;
        lSalesLines.Insert(true);
        lSalesLines.Validate("No.", pItemNo);
        lSalesLines."Location Code" := 'MAG-PF';
        lSalesLines."Variant Code" := pVariantCode;
        lSalesLines.Validate(Quantity, pQty);
        lSalesLines.Validate("Qty. to Ship", pQty);
        lsalesLines."Qty. to Invoice" := 0;
        lSalesLines.Modify(true);
    end;

    procedure InsertItemSpecification(pItem: code[20]; pLocationCode: code[20]; pSerialNo: Code[50]; pLotNo: Code[50]; pVariantCode: code[10]; pLineNo: Integer)
    var
        lReservationEntry: Record 337;
        lItem: Record Item;

    begin
        lItem.Get(pItem);
        if (lItem."Item Tracking Code" = 'PF') THEN BEGIN
            Clear(lReservationEntry);
            lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo + 1;
            lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot and Serial No.";
            lReservationEntry.validate("Item No.", lItem."No.");
            lReservationEntry."Location Code" := pLocationCode;
            lReservationEntry.Validate("Quantity (Base)", -1);
            lReservationEntry.Validate("Qty. per Unit of Measure", 1);
            lReservationEntry.Validate(Quantity, -1);
            lReservationEntry.validate("Qty. to Handle (Base)", -1);
            lReservationEntry."Qty. to Invoice (Base)" := -1;
            lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Surplus;
            lReservationEntry."Creation Date" := WorkDate;
            lReservationEntry."Shipment Date" := WorkDate();
            lReservationEntry."Source Type" := 37;
            lReservationEntry."Source Subtype" := 1;
            lReservationEntry."Source ID" := CurrDocNo;
            lReservationEntry."Source Ref. No." := pLineNo;
            lReservationEntry."Source Batch Name" := '';
            lReservationEntry."Creation Date" := WorkDate;
            lReservationEntry."Created By" := USERID;
            lReservationEntry."Planning Flexibility" := lReservationEntry."Planning Flexibility"::Unlimited;
            lReservationEntry."Serial No." := pSerialNo;
            lReservationEntry."Lot No." := pLotNo;
            lReservationEntry."Variant Code" := pVariantCode;
            lReservationEntry.INSERT;
        end;
    end;

    procedure getQtyDocLines(pDocType: enum "Sales Document Type"; pDocNo: code[20];
                                           pRefLineNo: integer): Decimal
    var
        LsalesLines: Record "Sales Line";
    begin
        if LsalesLines.Get(pDocType, pDocNo, pRefLineNo) Then;
        exit(LsalesLines.Quantity);

    end;

    procedure Update_Qty_SalesLines(pDocNo: code[20]; pRefLineNo: Integer)
    var
        LsalesLines: Record "Sales Line";
        lTrackLines: Record "Carton Tracking Lines";
    begin

        if LsalesLines.Get(LsalesLines."Document Type"::Order, pDocNo, pRefLineNo) Then begin
            lTrackLines.Reset();
            lTrackLines.SetCurrentKey("Carton No.", "Item No.", "Ref Line No.", "Serial No.", "Customer No.");
            lTrackLines.SetRange("Order No.", LsalesLines."Document No.");
            lTrackLines.SetRange("Item No.", LsalesLines."No.");
            lTrackLines.SetRange("Order Line No.", pRefLineNo);
            lTrackLines.Setfilter("Variant Code", '%1', '');
            if lTrackLines.FindFirst() Then begin
                if lTrackLines.Count < LsalesLines.Quantity Then
                    LsalesLines.Validate("Qty. to Ship", lTrackLines.Count)
                else
                    LsalesLines.Validate(Quantity, lTrackLines.Count);
                LsalesLines."Qty. to Invoice" := 0;
                LsalesLines.Modify(true);
            end else begin
                LsalesLines.Validate("Qty. to Ship", 0);
                LsalesLines.Modify(true);
            end;
        end;
    end;

    procedure UpdateSalesLinewithvariant(pDocNo: code[20]; pRefLineNo: Integer; pItemNo: Code[20]; pVariantCode: Code[20])
    var
        LsalesLines: Record "Sales Line";
    begin
        LsalesLines.RESET;
        LsalesLines.SetRange("Document Type", LsalesLines."Document Type"::Order);
        LsalesLines.SetRange("Document No.", pDocNo);
        LsalesLines.SetRange("No.", pItemNo);
        LsalesLines.SetRange("Variant Code", pVariantCode);
        if LsalesLines.FindFirst() then begin
            if LsalesLines."Line No." = pRefLineNo Then begin
                LsalesLines.Validate(Quantity, LsalesLines.Quantity + 1);
                // LsalesLines."Qty. to Ship" += 1;
                LsalesLines."Qty. to Invoice" := 0;
                LsalesLines.Modify(true);
            end;
            VariantLineNo := LsalesLines."Line No.";
        END ELSE begin
            InsertSalesLinewithvariant(pItemNo, pVariantCode, 1);
        end;
    end;

    procedure SetFields(pDocType: enum "Sales Document Type"; pDocumentNo: Code[20];
                                      pLineNo: Integer;
                                      pItemNo: Code[20];
                                      pQuantity: Decimal;
                                      pLocCode: Code[20])
    begin
        TotalQte := pQuantity;
        CurrDocType := pDocType;
        CurrDocNo := pDocumentNo;
        CurrDocLineNo := pLineNo;
        DocQty := pQuantity;
        CurrLocation := pLocCode;
        CurrItemNo := pItemNo;
    end;

    trigger OnOpenPage()
    var
        lCarton: Record Carton;
    begin
        lCarton.ModifyAll("selected", false);
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

}
