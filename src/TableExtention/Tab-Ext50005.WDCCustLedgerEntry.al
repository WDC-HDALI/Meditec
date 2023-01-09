tableextension 50005 "WDC Cust. Ledger Entry" extends "Cust. Ledger Entry"
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



}