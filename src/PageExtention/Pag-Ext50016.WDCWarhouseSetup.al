pageextension 50016 "WDC Warhouse Setup" extends "Warehouse Setup"
{
    layout
    {
        addafter("Registered Whse. Movement Nos.")
        {
            field("Exit Voucher PDR"; Rec."Exit Voucher PDR Nos.")
            {
                ApplicationArea = all;
            }
            field("Posted Exit Voucher PDR"; Rec."Posted Exit Voucher PDR Nos.")
            {
                ApplicationArea = all;
            }
            field("Carton Nos."; Rec."Carton Nos.")
            {
                ApplicationArea = all;
            }
        }

    }
}
