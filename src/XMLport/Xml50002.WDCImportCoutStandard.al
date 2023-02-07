xmlport 50002 "WDC Import Cout Standard"
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
            tableelement(Item; Item)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Item';

                fieldelement(CodeArticle; Item."No.")
                {

                }
                fieldelement(Cout; Item."Unit Cost")
                {

                }

                trigger OnBeforeInsertRecord()
                begin
                    Compteur += 1;
                    IF Not lItem.GET(CodeArticle) THEN
                        Message('%1 ***%2', Compteur, CodeArticle);

                    IF lItem."Costing Method" = lItem."Costing Method"::Standard THEN BEGIN
                        IF lItem."Standard Cost" <> Cout THEN BEGIN
                            lItem."Standard Cost" := Cout;
                            lItem.MODIFY;
                        END;
                    END;
                ENd;

            }
        }

    }

    var
        lItem: Record Item;
        Cout: Decimal;
        CodeArticle: code[20];
        Compteur: Integer;


    trigger OnPostXmlPort()
    begin
        MESSAGE('Stock importé avec succés');
    end;


}