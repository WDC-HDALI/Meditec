page 50006 "Exit Voucher PDR"
{
    Caption = 'Bon sortie PDR';
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
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
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
        lPostedExitVoucherLines: record "Posted Exit Voucher Lines";
        ItemJournalLine: Record 83;
        ModeleFeuille: text;
        NomFeuille: Text;
        lExitVoucherLines: Record "Exit Voucher Lines";
        lItem: Record item;
        ltext001: Label 'Votre Bon sortie est validé et enregistré sous le N°: %1 , \ souhaitez-vous ouvrir le bon sortie enreg.';
        lPagePostedExitVoucher: page "Posted Exit Voucher PDR";
        lPostDocNo: Code[20];
        WhseSetup: Record "Warehouse Setup";
        NoSeriesManagement: Codeunit 396;
    begin
        WhseSetup.get;
        ModeleFeuille := 'ARTICLE';
        NomFeuille := 'PDR';
        Init_ItemJNLLine;

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
                lItem.Get(lExitVoucherLines."No.");
                lExitVoucherLines.TestField(Quantity);
                lExitVoucherLines.TestField("Location Code");
                ItemJournalLine.INIT;
                ItemJournalLine.VALIDATE("Journal Template Name", ModeleFeuille);
                ItemJournalLine.VALIDATE("Journal Batch Name", NomFeuille);
                ItemJournalLine."Line No." := lExitVoucherLines."Line No.";
                ItemJournalLine."Posting Date" := pPostingDate;
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                ItemJournalLine."Document No." := lPostDocNo;
                ItemJournalLine.VALIDATE("Item No.", lExitVoucherLines."No.");
                ItemJournalLine.VALIDATE(Quantity, lExitVoucherLines.Quantity);
                ItemJournalLine.VALIDATE("Unit of Measure Code", lItem."Base Unit of Measure");
                ItemJournalLine.VALIDATE("Location Code", lExitVoucherLines."Location Code");
                IF ItemJournalLine.INSERT(true) then begin
                    lPostedExitVoucherLines.Init();
                    lPostedExitVoucherLines.TransferFields(lExitVoucherLines);
                    lPostedExitVoucherLines."Document No." := lPostDocNo;
                    lPostedExitVoucherLines.Insert;
                    ItemJnlPostBatch.Run(ItemJournalLine);
                end;
            until lExitVoucherLines.Next() = 0;
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





    local procedure Init_ItemJNLLine()
    var

        lItemJnlLine: Record 83;
    begin
        lItemJnlLine.Reset();
        lItemJnlLine.SetFilter("Journal Batch Name", 'PDR');
        lItemJnlLine.SetRange("Journal Template Name", 'ARTICLE');
        lItemJnlLine.DeleteAll();
    end;


    var

        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        JournalErrorsMgt: Codeunit "Journal Errors Mgt.";
        TempJnlBatchName: Code[10];

        Text000: Label 'cannot be filtered when posting recurring journals';
        Text001: Label 'Do you want to post the journal lines?';
        Text003: Label 'The journal lines were successfully posted.';
        Text004: Label 'The journal lines were successfully posted. ';
        Text005: Label 'You are now in the %1 journal.';
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
}
