tableextension 50003 "WDC JLEntry" extends "G/L Entry"
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
        field(50003; EntryType; Enum "WDC Entry Type")
        {
            DataClassification = ToBeClassified;
        }
    }

}