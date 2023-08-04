tableextension 50010 "WDC Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if (Type = type::Item) and ("No." <> '') then begin
                    lItemReference.Reset();
                    lItemReference.SetRange("Item No.", "No.");
                    lItemReference.SetRange("Reference Type", "Item Reference Type"::Customer);
                    lItemReference.SetFilter("Reference Type No.", '<>%1', "Sell-to Customer No.");
                    if lItemReference.Count <> 0 then
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
            if LcartonTrackLines.FindFirst() then
                LcartonTrackLines.ModifyAll("Order No.", '');

        end;
    end;



    var
        lItemReference: Record "Item Reference";
        lText001: Label 'l''article N° %1 n''est pas lié au client N° %2.';
}