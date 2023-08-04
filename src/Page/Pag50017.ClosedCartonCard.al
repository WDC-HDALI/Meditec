page 50017 "Closed Carton Card"
{
    Caption = 'Carton Card';
    PageType = Card;
    SourceTable = Carton;
    Editable = false;
    DeleteAllowed = false;
    CardPageId = 50017;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';


                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }


                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Assembly Date"; Rec."Assembly Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date assemblage field.';
                }
                field("Item Carton No."; Rec."Item Carton No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. article Carton field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description article field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Serie field.';
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }

            }
            part(ClosedCartonLines; "Closed Carton Track. Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Carton No." = FIELD("No."),
                "Customer No." = field("Customer No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Open)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Réouvrir';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = ReOpen;
                trigger OnAction()
                var
                    ltext001: Label 'Voulez-vous réouvrir le carton?';
                begin
                    CheckCarton(Rec."No.");
                    if Confirm(ltext001) Then begin
                        Rec.Status := rec.Status::Open;
                        Rec.Modify();
                        PostCaton(Rec."No.", WorkDate());   //WDC.SH
                    end;

                end;
            }

        }
    }
    procedure CheckCarton(pCartonNo: Code[20])
    var
        lCartonstrack: Record "Carton Tracking Lines";
        ltext001: Label 'L''ouverture du Carton expediée est interdie';
    begin
        lCartonstrack.Reset();
        lCartonstrack.SetRange("Carton No.", pCartonNo);
        if lCartonstrack.FindFirst() then
            repeat
                lCartonstrack.CalcFields("Shipment No.");
                if lCartonstrack."Shipment No." <> '' Then
                    Error(ltext001);
            until lCartonstrack.Next() = 0;
    end;

    procedure PostCaton(pDocumentNo: Code[20]; pPostingDate: Date)
    Var
        lItemJnlLine: Record 83;
        ModeleFeuille: text;
        NomFeuille: Text;
        lItem: Record item;
        lPostDocNo: Code[20];
        WhseSetup: Record "Warehouse Setup";
        NoSeriesManagement: Codeunit 396;
        lReservationEntry: Record 337;
    begin
        WhseSetup.get;
        ModeleFeuille := 'ARTICLE';
        NomFeuille := 'CARTON';
        Init_ItemJNLLine;
        //InitIndex;
        lPostDocNo := Rec."No."; //WDC.SH

        lItem.Get(Rec."Item Carton No.");

        lItemJnlLine.INIT;
        lItemJnlLine.VALIDATE("Journal Template Name", ModeleFeuille);
        lItemJnlLine.VALIDATE("Journal Batch Name", NomFeuille);
        lItemJnlLine."Line No." := 1000;
        lItemJnlLine."Posting Date" := pPostingDate;
        lItemJnlLine."Entry Type" := lItemJnlLine."Entry Type"::"Positive Adjmt.";
        lItemJnlLine."Document No." := lPostDocNo;
        lItemJnlLine.VALIDATE("Item No.", Rec."Item Carton No.");
        lItemJnlLine.VALIDATE(Quantity, 1);
        lItemJnlLine.VALIDATE("Unit of Measure Code", lItem."Base Unit of Measure");
        lItemJnlLine.VALIDATE("Location Code", 'MAG-MC');
        lItemJnlLine.VALIDATE("Lot No.", Rec."Lot No.");    //WDC.SH
        lItemJnlLine.Insert(true);
        IF (Rec."Lot No." = '') AND (lItem."Item Tracking Code" <> '') THEN
            ERROR('article %1 sans lot', lItem."No.")
        ELSE Begin
            IF (Rec."Lot No." <> '') AND (lItem."Item Tracking Code" <> '') then begin
                if (lItem."Item Tracking Code" <> 'PF') THEN BEGIN
                    Clear(lReservationEntry);
                    lReservationEntry.Init();  //WDC.SH
                    lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo + 1;
                    lReservationEntry.Positive := True;
                    lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot No.";
                    lReservationEntry."Item No." := lItemJnlLine."Item No.";
                    lReservationEntry."Location Code" := lItemJnlLine."Location Code";
                    lReservationEntry.Validate("Quantity (Base)", lItemJnlLine."Quantity (Base)" * (1));
                    lReservationEntry.Validate("Qty. per Unit of Measure", lItemJnlLine."Qty. per Unit of Measure");
                    lReservationEntry.Validate(Quantity, 1);
                    lReservationEntry.validate("Qty. to Handle (Base)", 1);
                    lReservationEntry."Qty. to Invoice (Base)" := 1;
                    lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
                    lReservationEntry."Creation Date" := lItemJnlLine."Posting Date";
                    lReservationEntry."Source Type" := 83;
                    lReservationEntry."Source Subtype" := 2;
                    lReservationEntry."Source ID" := ModeleFeuille;
                    lReservationEntry."Source Batch Name" := NomFeuille;
                    lReservationEntry."Source Ref. No." := 1000;
                    lReservationEntry."Creation Date" := lItemJnlLine."Posting Date";
                    lReservationEntry."Created By" := USERID;
                    lReservationEntry."Planning Flexibility" := lReservationEntry."Planning Flexibility"::Unlimited;
                    lReservationEntry."Lot No." := Rec."Lot No.";
                    lReservationEntry.INSERT(true);
                    //IndexReserv := IndexReserv + 1; /////////
                end;
            end;
        End;
        ItemJnlPostBatch.Run(lItemJnlLine);
        //Index := Index + 1000;


    End;

    procedure InitIndex()
    var
        ModeleFeuille: text;
        NomFeuille: Text;
        lItemJournalLine: Record 83;
        lResvEntries: Record 337;
    begin
        ModeleFeuille := 'ARTICLE';
        NomFeuille := 'CARTON';
        lItemJournalLine.Reset();
        lItemJournalLine.SetRange("Journal Template Name", ModeleFeuille);
        lItemJournalLine.SetRange("Journal Batch Name", NomFeuille);
        if lItemJournalLine.FindLast() then
            Index := lItemJournalLine."Line No." + 10000
        else
            Index := 10000;

        lResvEntries.Reset();
        IF lResvEntries.FINDLAST THEN
            IndexReserv := lResvEntries."Entry No." + 1
        ELSE
            IndexReserv := 1;
    end;


    procedure Init_ItemJNLLine()
    var

        lItemJnlLine: Record 83;
        lResvEntries: Record 337;
    begin
        lItemJnlLine.Reset();
        lItemJnlLine.SetFilter("Journal Batch Name", 'CARTON');
        lItemJnlLine.SetRange("Journal Template Name", 'ARTICLE');
        lItemJnlLine.DeleteAll();
    end;

    var
        IndexReserv: Integer;
        Index: Integer;
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";

}