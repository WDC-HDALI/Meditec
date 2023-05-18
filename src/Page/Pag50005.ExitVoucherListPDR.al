page 50005 "Exit Voucher List PDR"
{
    ApplicationArea = All;
    Caption = 'Liste bon sortie';
    PageType = List;
    SourceTable = "Exit Voucher Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = 50006;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(CreatedBy; Rec."Created by")
                {
                    ApplicationArea = All;

                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }


            }
        }
    }
}
