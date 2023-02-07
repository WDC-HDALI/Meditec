xmlport 50003 "WDC Import Stock copy"
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
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'ItemJrnLine';

                fieldelement(ItemCode; "Item Journal Line"."Item No.")
                {

                }
                fieldelement(LocationCode; "Item Journal Line"."Location Code")
                {

                }
                fieldelement(Qty; "Item Journal Line".Quantity)
                {

                }
                fieldelement(LotN; "Item Journal Line"."Lot No.")
                {

                }
                fieldelement(SerialN; "Item Journal Line"."Serial No.")
                {

                }
                fieldelement(Cost; "Item Journal Line"."Unit Amount")
                {

                }
                trigger OnBeforeInsertRecord()
                begin
                    IF "Item Journal Line"."Item No." = '' THEN
                        currXMLport.SKIP;

                    CodeArticle := "Item Journal Line"."Item No.";
                    CodeMagasin := "Item Journal Line"."Location Code";
                    //CodeEmplacement := BinCode;
                    //IF NOT EVALUATE(Quantites, Qty) THEN
                    Quantites := "Item Journal Line".Quantity;
                    NumLot := "Item Journal Line"."Lot No.";
                    NumSerie := "Item Journal Line"."Serial No.";
                    //IF NOT EVALUATE(Cout, Cost) THEN
                    Cout := "Item Journal Line"."Unit Amount";


                    DateCompatabilisation := 20221231D;

                    IF Quantites <= 0 THEN
                        //CurrDataport.SKIP;
                        ERROR('Quantite article %1 est negative', CodeArticle);

                    IF Cout = 0 THEN
                        ERROR('Le cout article %1 est nul', CodeArticle);

                    lItem.GET(CodeArticle);
                    IF lItem."Costing Method" = lItem."Costing Method"::Standard THEN BEGIN
                        IF lItem."Standard Cost" <> Cout THEN BEGIN
                            lItem."Standard Cost" := Cout;
                            lItem.MODIFY;
                        END;
                    END;

                    ItemJournalLine.INIT;
                    ItemJournalLine.VALIDATE("Journal Template Name", ModeleFeuille);
                    ItemJournalLine.VALIDATE("Journal Batch Name", NomFeuille);
                    ItemJournalLine."Line No." := Index;
                    ItemJournalLine.VALIDATE("Item No.", CodeArticle);
                    ItemJournalLine."Posting Date" := DateCompatabilisation;
                    ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
                    ItemJournalLine."Document No." := 'INV-2022';
                    ItemJournalLine.VALIDATE("Location Code", CodeMagasin);
                    //ItemJournalLine.VALIDATE("Bin Code",CodeEmplacement);
                    ItemJournalLine.VALIDATE(Quantity, Quantites);
                    ItemJournalLine.VALIDATE("Unit of Measure Code", lItem."Base Unit of Measure");
                    IF lItem."Costing Method" <> lItem."Costing Method"::Standard THEN
                        ItemJournalLine.VALIDATE("Unit Amount", Cout);
                    IF ItemJournalLine.INSERT THEN BEGIN
                        IF (NumLot = '') AND (lItem."Item Tracking Code" <> '') THEN
                            ERROR('article %1 sans lot', CodeArticle)
                        ELSE
                            IF (NumLot <> '') AND (lItem."Item Tracking Code" <> '') And (lItem."Item Tracking Code" <> 'PF') THEN BEGIN
                                lReservationEntry.INIT;
                                lReservationEntry."Entry No." := IndexReserv;
                                lReservationEntry.Positive := TRUE;
                                lReservationEntry."Item No." := CodeArticle;
                                lReservationEntry."Location Code" := CodeMagasin;
                                lReservationEntry."Quantity (Base)" := ItemJournalLine."Quantity (Base)";
                                lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
                                lReservationEntry."Creation Date" := DateCompatabilisation;
                                lReservationEntry."Source Type" := 83;
                                lReservationEntry."Source Subtype" := 2;
                                lReservationEntry."Source ID" := ModeleFeuille;
                                lReservationEntry."Source Batch Name" := NomFeuille;
                                lReservationEntry."Source Ref. No." := Index;
                                lReservationEntry."Expected Receipt Date" := DateCompatabilisation;
                                lReservationEntry."Created By" := USERID;
                                lReservationEntry."Qty. per Unit of Measure" := 1;
                                lReservationEntry.Quantity := ItemJournalLine.Quantity;
                                lReservationEntry."Planning Flexibility" := lReservationEntry."Planning Flexibility"::Unlimited;
                                lReservationEntry."Qty. to Handle (Base)" := ItemJournalLine."Quantity (Base)";
                                lReservationEntry."Qty. to Invoice (Base)" := ItemJournalLine."Quantity (Base)";
                                lReservationEntry."Lot No." := NumLot;
                                lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot No.";
                                IF lReservationEntry.INSERT THEN
                                    IndexReserv := IndexReserv + 1
                                ELSE
                                    ERROR('Echec d''insertion de Lot d''article %1', CodeArticle);
                            END;
                        IF (NumSerie = '') AND (lItem."Item Tracking Code" = 'PF') THEN
                            ERROR('Article %1 sans numéro de serie', CodeArticle);
                        IF (NumLot = '') AND (lItem."Item Tracking Code" = 'PF') THEN
                            ERROR('Article %1 sans numéro de Lot', CodeArticle);
                        IF (NumSerie <> '') AND (lItem."Item Tracking Code" = 'PF') THEN BEGIN
                            lReservationEntry.INIT;
                            lReservationEntry."Entry No." := IndexReserv;
                            lReservationEntry.Positive := TRUE;
                            lReservationEntry."Item No." := CodeArticle;
                            lReservationEntry."Location Code" := CodeMagasin;
                            lReservationEntry."Quantity (Base)" := 1;
                            lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
                            lReservationEntry."Creation Date" := DateCompatabilisation;
                            lReservationEntry."Source Type" := 83;
                            lReservationEntry."Source Subtype" := 2;
                            lReservationEntry."Source ID" := ModeleFeuille;
                            lReservationEntry."Source Batch Name" := NomFeuille;
                            lReservationEntry."Source Ref. No." := Index;
                            lReservationEntry."Expected Receipt Date" := DateCompatabilisation;
                            lReservationEntry."Created By" := USERID;
                            lReservationEntry."Qty. per Unit of Measure" := 1;
                            lReservationEntry.Quantity := 1;
                            lReservationEntry."Planning Flexibility" := lReservationEntry."Planning Flexibility"::Unlimited;
                            lReservationEntry."Qty. to Handle (Base)" := 1;
                            lReservationEntry."Qty. to Invoice (Base)" := 1;
                            lReservationEntry."Lot No." := NumLot;
                            lReservationEntry."Serial No." := NumSerie;
                            lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Serial No.";
                            IF lReservationEntry.INSERT THEN
                                IndexReserv := IndexReserv + 1
                            ELSE
                                ERROR('Echec d''insertion de Serie d''article %1', CodeArticle);
                        END;
                        Index := Index + 1000;
                    END ELSE
                        ERROR('Echec d''insertion d''article %1', CodeArticle);
                end;
            }
        }

    }

    var
        lReservationEntry: Record "Reservation Entry";
        ItemJournalLine: Record "Item Journal Line";
        lItem: Record Item;
        Quantites: Decimal;
        Cout: Decimal;
        DateCompatabilisation: Date;
        ModeleFeuille: Code[20];
        NomFeuille: Code[20];
        NumLot: code[50];
        NumSerie: code[50];
        CodeMagasin: code[20];
        CodeArticle: code[20];
        Index: Integer;
        IndexReserv: Integer;

    trigger OnInitXmlPort()
    begin
        ModeleFeuille := 'ARTICLE';
        NomFeuille := 'DEFAULT';
        ItemJournalLine.Reset();
        ItemJournalLine.SetRange("Journal Template Name", ModeleFeuille);
        ItemJournalLine.SetRange("Journal Batch Name", NomFeuille);
        if ItemJournalLine.FindLast() then
            Index := ItemJournalLine."Line No." + 1000
        else
            Index := 10000;
        IF lReservationEntry.FINDLAST THEN
            IndexReserv := lReservationEntry."Entry No." + 1
        ELSE
            IndexReserv := 1;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Stock importé avec succés');
    end;


}