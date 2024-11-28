page 50006 "Exit Voucher PDR"
{
    /****************************************************Documentation*******************************
    WDC01       02.09.2024      WDC.IM      Add "Variant code"
    *************************************************************************************************/
    Caption = 'Bon sortie ';
    PageType = Card;
    SourceTable = "Exit Voucher Header";

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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }

                field("Name Concerned Person"; Rec."Name Concerned Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nom Personne concerné field.';
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Statut field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commentaire field.';
                    ColumnSpan = 2;
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }

                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }

            }
            part(ExitVoucherLines; "Exit Voucher Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }

        }


    }

    actions
    {
        area(Processing)
        {
            action("Post")
            {
                Image = Post;
                ApplicationArea = all;
                CaptionML = FRA = 'Valider';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ltext001: Label 'Voulez-vous vraiment valider ce document?';
                begin
                    Rec.TestField("Name Concerned Person");
                    If Confirm(ltext001) then
                        PostExitVoucher(Rec."No.", Rec."Posting Date");
                end;
            }
        }
    }
    procedure PostExitVoucher(pDocumentNo: Code[20]; pPostingDate: Date)
    Var
        lExitVoucherHeader: Record "Exit Voucher Header";
        lPostedExitVoucherHeader: Record "Posted Exit Voucher Header";
        lPosExtVchrLines: record "Posted Exit Voucher Lines";
        lItemJnlLine: Record 83;
        ModeleFeuille: text;
        NomFeuille: Text;
        lExitVoucherLines: Record "Exit Voucher Lines";
        lItem: Record item;
        ltext001: Label 'Votre Bon sortie est validé et enregistré sous le N°: %1 , \ souhaitez-vous ouvrir le bon sortie enreg.';
        lPagePostedExitVoucher: page "Posted Exit Voucher PDR";
        lPostDocNo: Code[20];
        WhseSetup: Record "Warehouse Setup";
        NoSeriesManagement: Codeunit 396;
        lReservationEntry: Record 337;
    begin
        WhseSetup.get;
        ModeleFeuille := 'ARTICLE';
        NomFeuille := 'PDR';
        Init_ItemJNLLine;
        InitIndex;
        lExitVoucherHeader.Reset(); //WDC.IM
        lPostedExitVoucherHeader.Reset(); //WDC.IM
        lPostedExitVoucherHeader.Init(); //WDC.IM
        lExitVoucherHeader.Get(pDocumentNo);
        lPostedExitVoucherHeader.TransferFields(lExitVoucherHeader);
        lPostDocNo := NoSeriesManagement.GetNextNo(WhseSetup."Posted Exit Voucher PDR Nos.", 0D, TRUE);
        lPostedExitVoucherHeader."No." := lPostDocNo;
        lPostedExitVoucherHeader."Pre-Assigned No." := pDocumentNo;
        lPostedExitVoucherHeader.Insert;
        lExitVoucherLines.Reset();
        lExitVoucherLines.SetRange("Document No.", pDocumentNo);
        if lExitVoucherLines.FindFirst() then
            repeat
                lItem.Reset(); //WDC.IM
                lItem.Get(lExitVoucherLines."No.");
                lExitVoucherLines.TestField("Location Code");
                lExitVoucherLines.TestField(Quantity);
                lExitVoucherLines.TestField("Work Center No.");
                lItemJnlLine.INIT;
                lItemJnlLine.VALIDATE("Journal Template Name", ModeleFeuille);
                lItemJnlLine.VALIDATE("Journal Batch Name", NomFeuille);
                lItemJnlLine."Line No." := lExitVoucherLines."Line No.";
                lItemJnlLine."Posting Date" := pPostingDate;
                lItemJnlLine."Entry Type" := lItemJnlLine."Entry Type"::"Negative Adjmt.";
                lItemJnlLine."Document No." := lPostDocNo;
                lItemJnlLine.VALIDATE("Item No.", lExitVoucherLines."No.");
                lItemJnlLine.VALIDATE(Quantity, lExitVoucherLines.Quantity);
                lItemJnlLine.VALIDATE("Unit of Measure Code", lItem."Base Unit of Measure");
                lItemJnlLine.VALIDATE("Location Code", lExitVoucherLines."Location Code");
                lItemJnlLine.Validate("Variant Code", lExitVoucherLines."Variant Code");//WDC01
                lItemJnlLine.Insert(true);
                IF (lExitVoucherLines."Lot No." = '') AND (lItem."Item Tracking Code" <> '') THEN
                    ERROR('article %1 sans lot', lItem."No.")
                ELSE Begin
                    IF (lExitVoucherLines."Lot No." <> '') AND (lItem."Item Tracking Code" <> '') then begin
                        if (lItem."Item Tracking Code" <> 'PF') THEN BEGIN
                            Clear(lReservationEntry);
                            lReservationEntry.Init();
                            lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo + 1;
                            lReservationEntry.Positive := false;
                            lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot No.";
                            lReservationEntry."Item No." := lItemJnlLine."Item No.";
                            lReservationEntry."Location Code" := lItemJnlLine."Location Code";
                            lReservationEntry.Validate("Quantity (Base)", lItemJnlLine."Quantity (Base)" * (-1));
                            lReservationEntry.Validate("Qty. per Unit of Measure", lItemJnlLine."Qty. per Unit of Measure");
                            lReservationEntry.Validate(Quantity, lExitVoucherLines.Quantity * (-1));
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
                            lReservationEntry."Lot No." := lExitVoucherLines."Lot No.";
                            lReservationEntry.INSERT(true);
                            IndexReserv := IndexReserv + 1; /////////
                        end;
                    end;
                End;
                lPosExtVchrLines.Init();
                lPosExtVchrLines.TransferFields(lExitVoucherLines);
                lPosExtVchrLines."Document No." := lPostDocNo;
                lPosExtVchrLines.Insert;
                //ItemJnlPostBatch.Run(lItemJnlLine); //CMT by WDC.IM
                Index := Index + 1000;

            until lExitVoucherLines.Next() = 0;
        ItemJnlPostBatch.Run(lItemJnlLine);//WDC.IM
        lExitVoucherLines.DeleteAll();
        lExitVoucherHeader.Delete();

        If lPostedExitVoucherHeader.Get(lPostDocNo) then
            if Confirm(ltext001, true, lPostedExitVoucherHeader."No.") then begin
                CurrPage.Close();
                Clear(lPagePostedExitVoucher);
                lPagePostedExitVoucher.SetTableView(lPostedExitVoucherHeader);
                lPagePostedExitVoucher.SetRecord(lPostedExitVoucherHeader);
                lPagePostedExitVoucher.Run();
            end;

    End;

    procedure InitIndex()
    var
        ModeleFeuille: text;
        NomFeuille: Text;
        lItemJournalLine: Record 83;
        lResvEntries: Record 337;
    begin
        ModeleFeuille := 'ARTICLE';
        NomFeuille := 'PDR';
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
        lItemJnlLine.SetFilter("Journal Batch Name", 'PDR');
        lItemJnlLine.SetRange("Journal Template Name", 'ARTICLE');
        lItemJnlLine.DeleteAll();
    end;

    var
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        IndexReserv: Integer;
        Index: Integer;
}