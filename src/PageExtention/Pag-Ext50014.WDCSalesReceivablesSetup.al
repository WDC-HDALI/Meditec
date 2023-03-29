pageextension 50014 "WDC Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter(Archiving)
        {
            group("Invoice Details")
            {
                CaptionML = ENU = 'Invoice Details', FRA = 'Détails de la facture';
                field(Signature; SignatureText)
                {

                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Importance = Additional;
                    trigger OnValidate()
                    begin
                        Rec.SetSignature(SignatureText);
                    end;

                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SignatureText := Rec.GetSignature();
    end;

    var
        SignatureText: Text;
}
