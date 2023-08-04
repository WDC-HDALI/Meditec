tableextension 50021 "Wdc Reservation Entry" extends "Reservation Entry"
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
