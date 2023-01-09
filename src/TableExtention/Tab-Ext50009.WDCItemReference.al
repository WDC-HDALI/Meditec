tableextension 50009 "WDC Item Reference" extends "Item Reference"
{
    fields
    {
        modify("Reference Type No.")
        {
            trigger OnAfterValidate()
            begin
                if ("Reference Type No." <> xRec."Reference Type No.") and ("Reference Type No." <> '') then begin
                    lReferTypeNo.Reset();
                    lReferTypeNo.SetRange("Item No.", "Item No.");
                    lreferTypeNo.SetRange("Reference Type", "Reference Type"::Customer);
                    lReferTypeNo.SetFilter("Reference Type No.", '<>%1', '');
                    if lReferTypeNo.FindSet() then
                        Error(lText001);
                end;

            end;
        }
    }
    trigger OnBeforeInsert()
    begin
        lReferTypeNo.Reset();
        lReferTypeNo.SetRange("Item No.", "Item No.");
        lreferTypeNo.SetRange("Reference Type", "Reference Type"::Customer);
        lReferTypeNo.SetFilter("Reference Type No.", '<>%1', '');
        if lReferTypeNo.FindSet() then
            Error(lText001);
    end;

    var
        lReferTypeNo: Record "Item Reference";
        lText001: Label 'Impossible de rajouter une nouvelle réfèrence !';
}