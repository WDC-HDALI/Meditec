tableextension 50023 "Wdc Tracking Specification" extends "Tracking Specification"
{
    trigger OnDelete()
    begin
        SetDocumentNoFields
    end;

    trigger OnRename()
    begin
        SetDocumentNoFields;
    end;

    Procedure SetDocumentNoFields()
    var
        lCartonTracking: Record "Carton Tracking Lines";
        lsalesLines: Record "Sales Line";
    begin
        lCartonTracking.Reset();
        lCartonTracking.SetRange("Serial No.", Rec."Serial No.");
        if lCartonTracking.FindFirst() then begin
            lCartonTracking."Order No." := '';
            lCartonTracking."Shipment No." := '';
            lCartonTracking.Modify();
        end;
    end;

}
