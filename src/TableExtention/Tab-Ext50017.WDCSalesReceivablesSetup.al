tableextension 50017 "WDC Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; Signature; Blob)
        {
            CaptionML = FRA = 'Signature douanière';
            DataClassification = ToBeClassified;


        }
    }
    procedure SetSignature(NewSignature: Text)
    var
        lOutStream: OutStream;
    begin
        Clear(Rec.Signature);
        Rec.Signature.CreateOutStream(lOutStream, TEXTENCODING::UTF8);
        lOutStream.WriteText(NewSignature);
        Modify();
    end;

    procedure GetSignature() rSignature: Text
    var
        TypeHelper: Codeunit "Type Helper";
        lInStream: InStream;
    begin
        Rec.CalcFields(Rec.Signature);
        Rec.Signature.CreateInStream(lInStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(lInStream, TypeHelper.LFSeparator(), FieldName(Rec.Signature)));
    end;
}
