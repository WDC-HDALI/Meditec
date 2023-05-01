page 50009 "Posted Exit Voucher PDR"
{
    Caption = 'Bon sortie PDR enreg.';
    PageType = Card;
    SourceTable = "Posted Exit Voucher Header";
    Editable = false;

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
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commentaire field.';
                    ColumnSpan = 4;
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = All;

                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
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
            part(ExitVoucherLines; "Posted Exit Voucher Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }

        }


    }

    actions
    {

        area(Reporting)
        {
            action("Print")
            {
                Image = Print;
                ApplicationArea = all;
                CaptionML = FRA = 'Imprimer';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lPostedExitvoucher: Record "Posted Exit Voucher Header";
                    lRepPostedExitvoucher: Report "WDC Exit Voucher PDR";
                begin
                    lPostedExitvoucher.Reset();
                    ;
                    lPostedExitvoucher.SetRange("No.", Rec."No.");
                    if lPostedExitvoucher.FindFirst() then begin
                        lRepPostedExitvoucher.SetTableView(lPostedExitvoucher);
                        lRepPostedExitvoucher.Run();
                    end;
                end;
            }

        }
    }


    var

}
