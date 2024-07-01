tableextension 50010 "WDC Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                lItem: Record Item;
            begin
                if (Type = type::Item) and ("No." <> '') then begin
                    if lItem.Get(rec."No.") then
                        if (lItem."Customer Code" <> Rec."Sell-to Customer No.") and (lItem."Gen. Prod. Posting Group" = 'PF') then
                            Error(lText001, "No.", "Sell-to Customer No.");
                end;
            end;
        }

        field(50000; "Marge brut"; Decimal)
        {
            CaptionML = ENU = 'Gross margin', FRA = 'Marge brut';
            DataClassification = ToBeClassified;
        }
        field(50001; "Marge net"; Decimal)
        {
            CaptionML = ENU = 'Net margin', FRA = 'Marge net';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterDelete()
    var
        LcartonTrackLines: Record "Carton Tracking Lines";
        lItem: Record Item;
    begin

        IF lItem.Get(Rec."No.") THEN begin
            LcartonTrackLines.Reset();
            LcartonTrackLines.SetRange("Order No.", Rec."Document No.");
            LcartonTrackLines.Setrange("Item No.", Rec."No.");
            //if LcartonTrackLines.FindFirst() then begin
            LcartonTrackLines.ModifyAll("Order Line No.", 0);
            LcartonTrackLines.ModifyAll("Order No.", '');

        end;
    end;



    var
        lItemReference: Record "Item Reference";
        lText001: Label 'l''article N° %1 n''est pas lié au client N° %2.';
}