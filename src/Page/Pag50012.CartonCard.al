page 50012 "Carton Card"
{
    Caption = 'Carton';
    PageType = Card;
    SourceTable = Carton;

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

                }

                field("Ship to code"; Rec."Ship to code")
                {
                    ApplicationArea = All;

                }
                field("Ship to name"; Rec."Ship to name")
                {
                    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the No. Serie field.';
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
            part(CartonLines; "Carton Tracking Lines")
            {

                ApplicationArea = Basic, Suite;
                SubPageLink = "Carton No." = FIELD("No."),
                               "Customer No." = FIELD("Customer No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(CloseAndPrint)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Lancer & imprimer';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = PostPrint;
                trigger OnAction()
                var
                    lCarton: record carton;
                    ltext001: Label 'Voulez-vous Lancer et imprimer le carton?';
                begin
                    if Confirm(ltext001) Then begin
                        CheckCarton(Rec."No.");
                        Rec.Status := rec.Status::Release;
                        Rec.Modify();
                        AdjustInventoryCaton(Rec."No.", WorkDate());

                        lCarton.Reset();
                        lCarton.SetRange("No.", Rec."No.");
                        if lCarton.FindFirst() then
                            Report.Run(50020, true, false, lCarton);
                    end;
                end;
            }


            action(Close)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Lancer';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ltext001: Label 'Voulez-vous Lancer le carton?';
                begin
                    if Confirm(ltext001) Then begin
                        CheckCarton(Rec."No.");
                        Rec.Status := rec.Status::Release;
                        Rec.Modify();
                        AdjustInventoryCaton(Rec."No.", WorkDate());
                    end;
                End;
            }
            action(Ticket)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Imprimer';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = PrintCover;
                trigger OnAction()
                var
                    lCarton: record carton;
                begin
                    lCarton.Reset();
                    lCarton.SetRange("No.", Rec."No.");
                    if lCarton.FindFirst() then
                        Report.Run(50020, true, false, lCarton);

                end;
            }

        }
    }
    procedure CheckCarton(pCartonNo: Code[20]): Boolean
    var

        lcartTrackLines: Record "Carton Tracking Lines";
        lText001: Label 'vous devez saisir la traçabilité des articles assemblés';

    begin
        Rec.TestField("Customer No.");
        Rec.TestField("Item Carton No.");
        Rec.TestField("Assembly Date");
        Rec.TestField("Lot No.");

        lcartTrackLines.Reset();
        lcartTrackLines.SetRange("Carton No.", pCartonNo);
        if not lcartTrackLines.FindFirst() then
            Error(lText001)

    end;


    procedure AdjustInventoryCaton(pDocumentNo: Code[20]; pPostingDate: Date)
    Var
        lItemJnlLine: Record 83;
        ModeleFeuille: text;
        NomFeuille: Text;
        lItem: Record item;
        lPostDocNo: Code[20];
        WhseSetup: Record "Warehouse Setup";
        lReservationEntry: Record 337;
    begin
        WhseSetup.get;
        ModeleFeuille := 'ARTICLE';
        NomFeuille := 'CARTON';
        Init_ItemJNLLine;

        lPostDocNo := Rec."No."; //WDC.SH

        lItem.Get(Rec."Item Carton No.");

        lItemJnlLine.INIT;
        lItemJnlLine.VALIDATE("Journal Template Name", ModeleFeuille);
        lItemJnlLine.VALIDATE("Journal Batch Name", NomFeuille);
        lItemJnlLine."Line No." := 1000;
        lItemJnlLine."Posting Date" := pPostingDate;
        lItemJnlLine."Entry Type" := lItemJnlLine."Entry Type"::"Negative Adjmt.";
        lItemJnlLine."Document No." := lPostDocNo;
        lItemJnlLine.VALIDATE("Item No.", Rec."Item Carton No.");
        lItemJnlLine.VALIDATE(Quantity, 1);
        lItemJnlLine.VALIDATE("Unit of Measure Code", lItem."Base Unit of Measure");
        lItemJnlLine.VALIDATE("Location Code", 'MAG-MC');
        lItemJnlLine.VALIDATE("Lot No.", Rec."Lot No.");  //WDC.SH
        lItemJnlLine.Insert(true);
        IF (Rec."Lot No." = '') AND (lItem."Item Tracking Code" <> '') THEN
            ERROR('article %1 sans lot', lItem."No.")
        ELSE Begin
            IF (Rec."Lot No." <> '') AND (lItem."Item Tracking Code" <> '') then begin
                if (lItem."Item Tracking Code" <> 'PF') THEN BEGIN
                    Clear(lReservationEntry);
                    lReservationEntry.Init();  //WDC.SH
                    lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo + 1;
                    lReservationEntry.Positive := false;
                    lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot No.";
                    lReservationEntry."Item No." := lItemJnlLine."Item No.";
                    lReservationEntry."Location Code" := lItemJnlLine."Location Code";
                    lReservationEntry.Validate("Quantity (Base)", lItemJnlLine."Quantity (Base)" * (-1));
                    lReservationEntry.Validate("Qty. per Unit of Measure", lItemJnlLine."Qty. per Unit of Measure");
                    lReservationEntry.Validate(Quantity, -1);
                    lReservationEntry.validate("Qty. to Handle (Base)", lItemJnlLine."Quantity (Base)" * (-1));
                    lReservationEntry."Qty. to Invoice (Base)" := lItemJnlLine."Quantity (Base)" * (-1);
                    lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
                    lReservationEntry."Creation Date" := lItemJnlLine."Posting Date";
                    lReservationEntry."Source Type" := 83;
                    lReservationEntry."Source Subtype" := 3;
                    lReservationEntry."Source ID" := ModeleFeuille;
                    lReservationEntry."Source Batch Name" := NomFeuille;
                    lReservationEntry."Source Ref. No." := lItemJnlLine."Line No.";
                    lReservationEntry."Creation Date" := lItemJnlLine."Posting Date";
                    lReservationEntry."Created By" := USERID;
                    lReservationEntry."Planning Flexibility" := lReservationEntry."Planning Flexibility"::Unlimited;
                    lReservationEntry."Lot No." := Rec."Lot No.";
                    lReservationEntry.INSERT(true);
                end;
            end;
        End;
        ItemJnlPostBatch.Run(lItemJnlLine);
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
    begin
        lItemJnlLine.Reset();
        lItemJnlLine.SetFilter("Journal Batch Name", 'CARTON');
        lItemJnlLine.SetRange("Journal Template Name", 'ARTICLE');
        lItemJnlLine.DeleteAll();
    end;

    var
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        IndexReserv: Integer;
        Index: Integer;
}