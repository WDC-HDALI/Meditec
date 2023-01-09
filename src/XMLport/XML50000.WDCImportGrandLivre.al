xmlport 50000 "WDC Import grand livre"
{
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    UseRequestPage = false;
    //Permissions = TableData "G/L Entry" = rimd, tabledata "G/L Account" = rimd;
    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoReplace = false;
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'GenJournalLine';

                fieldelement(TemplateName; "Gen. Journal Line"."Journal Template Name")
                {

                }
                fieldelement(BatchName; "Gen. Journal Line"."Journal Batch Name")
                {

                }
                fieldelement(NLigne; "Gen. Journal Line"."Line No.")
                {

                }
                fieldelement(TypeCompte; "Gen. Journal Line"."Account Type")
                {

                }
                fieldelement(NCompte; "Gen. Journal Line"."Account No.")
                {

                }

                fieldelement(DocumentNo; "Gen. Journal Line"."Document No.")
                {

                }
                fieldelement(DateCompte; "Gen. Journal Line"."Posting Date")
                {

                }
                fieldelement(Description; "Gen. Journal Line".Description)
                {

                }
                fieldelement(CurrencyCode; "Gen. Journal Line"."Currency Code")
                {

                }
                fieldelement(Montant; "Gen. Journal Line".Amount)
                {

                }
                fieldelement(MontantLCY; "Gen. Journal Line"."Amount (LCY)")
                {
                    // trigger OnAfterAssignField()
                    // begin
                    //     "Gen. Journal Line".Validate("Amount (LCY)");
                    // end;

                }

                // fieldelement(CurrencyFactor; "Gen. Journal Line"."Currency Factor")
                // {

                // }
                fieldelement(InitialDate; "Gen. Journal Line"."Initial Date")
                {

                }
                fieldelement(InitDocumentNo; "Gen. Journal Line"."Initial Document No.")
                {

                }
                fieldelement(Lettrage; "Gen. Journal Line".Lettrage)
                {

                }
                // trigger OnAfterGetRecord()
                // begin
                //     "Gen. Journal Line".Validate("Currency Factor");
                //     "Gen. Journal Line".Validate("Amount (LCY)");
                //     "Gen. Journal Line".Validate(Amount);
                // end;
            }

        }

    }

    var
        GLEntryUpdated: Record "G/L Entry";
        GLEntryChanged: Record "G/L Entry";
        GLAccount2: Record "G/L Account";
        Text001: Label 'Import terminé';
        Text002: Label 'Importation en cours';
        windDialog: Dialog;


    trigger OnPreXmlPort()

    begin
        windDialog.Open(Text002);

    end;

    trigger OnPostXmlPort()

    begin
        windDialog.Close();
        Message(Text001);
    end;


}