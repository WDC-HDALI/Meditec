tableextension 50004 "WDC GenJournalLine" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Initial Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Initial Document No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Lettrage; Code[10])
        {
            DataClassification = ToBeClassified;
        }

    }
    trigger OnBeforeInsert()
    var
        myInt: Integer;
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        GenJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        "Account Type" := GenJnlBatch."Account Type";
        "Account No." := GenJnlBatch."Account No.";
    end;


}