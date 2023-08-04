page 50021 "Carton to Post"
{

    Caption = 'Cartons à expédier';
    PageType = List;
    SourceTable = Carton;
    SourceTableView = sorting("No.") where(Status = filter(Release));
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
                field("Serial No."; Rec."Serial No.")
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
                CaptionML = FRA = 'Valider traçabilté';
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

        lClosedCartonPage: page 50016;
        lCarton: Record Carton;
        lCarton2: Record Carton;
        lCartonTrackinLines: Record "Carton Tracking Lines";

        RecToDelelete: Record 337;
    begin

        lCarton.Reset();
        lCarton.SetRange(Selected, true);
        if lCarton.FindFirst() then
            repeat
                lCarton2.Get(lCarton."No.");
                lCarton2."Item No. Filter" := CurrItemNo;
                lCarton2.SetFilter("Item No. Filter", CurrItemNo);
                lCarton2.CalcFields("Qty Item");

                lCartonTrackinLines.Reset();
                lCartonTrackinLines.SetRange("Carton No.", lCarton."No.");
                lCartonTrackinLines.SetRange("Item No.", CurrItemNo);
                if lCartonTrackinLines.FindFirst() then
                    repeat
                        //If lCartonTrackinLines."order No." = '' then Begin
                        if getQtyDocLines(CurrDocType, CurrDocNo, CurrDocLineNo) >= QteToShip Then begin
                            InsertItemSpecification(lCartonTrackinLines."Item No.", CurrLocation, lCartonTrackinLines."Serial No.", lCartonTrackinLines."Lot No.");

                            lCartonTrackinLines."Order No." := CurrDocNo;
                            lCartonTrackinLines.Modify();
                            QteToShip += 1;
                        end;
                    //End
                    until lCartonTrackinLines.Next() = 0;
            until lCarton.Next() = 0;
        if QteToShip <> 0 then
            Update_Qty_SalesLines(CurrDocNo, CurrDocLineNo, QteToShip);
    END;

    procedure InsertItemSpecification(pItem: code[20]; pLocationCode: code[20]; pSerialNo: Code[50]; pLotNo: Code[50])
    var
        lReservationEntry: Record 337;
        lItem: Record Item;

    begin
        lItem.Get(pItem);
        if (lItem."Item Tracking Code" = 'PF') THEN BEGIN
            Clear(lReservationEntry);
            lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo + 1;
            lReservationEntry.Positive := false;
            lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot and Serial No.";
            lReservationEntry.validate("Item No.", lItem."No.");
            lReservationEntry."Location Code" := pLocationCode;
            lReservationEntry.Validate("Quantity (Base)", -1);
            lReservationEntry.Validate("Qty. per Unit of Measure", 1);
            lReservationEntry.Validate(Quantity, -1);
            lReservationEntry.validate("Qty. to Handle (Base)", -1);
            lReservationEntry."Qty. to Invoice (Base)" := -1;
            lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
            lReservationEntry."Creation Date" := WorkDate;
            lReservationEntry."Shipment Date" := WorkDate();
            lReservationEntry."Source Type" := 37;
            lReservationEntry."Source Subtype" := 1;
            lReservationEntry."Source ID" := CurrDocNo;
            lReservationEntry."Source Ref. No." := CurrDocLineNo;
            lReservationEntry."Source Batch Name" := '';
            lReservationEntry."Creation Date" := WorkDate;
            lReservationEntry."Created By" := USERID;
            lReservationEntry."Planning Flexibility" := lReservationEntry."Planning Flexibility"::Unlimited;
            lReservationEntry."Serial No." := pSerialNo;
            lReservationEntry."Lot No." := pLotNo;
            lReservationEntry.INSERT;
            //   IndexReserv := IndexReserv + 1; /////////
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

    procedure Update_Qty_SalesLines(pDocNo: code[20]; pRefLineNo: Integer; pQteToShip: Decimal)
    var
        LsalesLines: Record "Sales Line";
    begin
        if LsalesLines.Get(LsalesLines."Document Type"::Order, pDocNo, pRefLineNo) Then begin
            LsalesLines.Validate("Qty. to Ship", pQteToShip);
            LsalesLines.Modify();
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
        QteToShip: Decimal;
}
