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
    }
    var
        lItemReference: Record "Item Reference";
        lText001: Label 'l''article N° %1 n''est pas lié au client N° %2.';
}