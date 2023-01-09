report 50011 "Etat des Stocks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/EtatdesStocks.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Etat des stocks';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            //WHERE("Gen. Prod. Posting Group"=CONST('PR'));
            RequestFilterFields = "No.", "Inventory Posting Group", "Gen. Prod. Posting Group";
            column(FORMATTODAY04; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(Counter; Counter)
            {
            }

            column(FiltersText; FiltersText)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Date_Stock_Text001; Text0001 + ' ' + FORMAT(DateStock))
            {
            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Baseunitofmesure; "Base Unit of Measure")
            {
                //OptionCaption = 'Unit of Mesure';
            }
            column(QteStock; QteStock)
            {
            }
            column(Blocked; Item.Blocked)
            {
            }
            column(CUTotal; CUTotal)
            {
                DecimalPlaces = 4 : 4;
            }
            column(NewTotStockVal; NewTotStockVal)
            {
            }
            column(RepSystem; Item."Replenishment System")
            {
            }

            trigger OnAfterGetRecord()
            begin

                Item.SETRANGE(Item."Date Filter", 0D, DateStock);
                Item.CALCFIELDS(Item.Inventory);
                IF StockNul AND (Item.Inventory = 0) THEN
                    CurrReport.SKIP;

                //<<MIG001
                IF InvPostGroup.GET("Inventory Posting Group") THEN;
                CU := 0;
                NewTotStockVal := 0;
                ValStock := 0;
                QteStock := 0;
                EcrValeur.RESET;
                EcrValeur.SETCURRENTKEY(EcrValeur."Item No.", EcrValeur."Posting Date", EcrValeur."Item Ledger Entry Type", EcrValeur."Entry Type",
                EcrValeur."Variance Type", EcrValeur."Item Charge No.", EcrValeur."Location Code", EcrValeur."Variant Code");
                EcrValeur.SETRANGE(EcrValeur."Item No.", Item."No.");
                EcrValeur.SETRANGE(EcrValeur."Posting Date", 0D, DateStock);

                IF "Magasin No." <> '' THEN
                    EcrValeur.SETRANGE(EcrValeur."Location Code", "Magasin No.");
                IF EcrValeur.FINDFIRST THEN BEGIN
                    EcrValeur.CALCSUMS(EcrValeur."Cost Amount (Actual)", EcrValeur."Cost Amount (Expected)", EcrValeur."Item Ledger Entry Quantity");
                    QteStock := EcrValeur."Item Ledger Entry Quantity";
                    IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                        CU := Item."Standard Cost"
                    ELSE BEGIN
                        IF QteStock <> 0 THEN BEGIN
                            ValStock := EcrValeur."Cost Amount (Actual)" + EcrValeur."Cost Amount (Expected)";
                            CU := ValStock / QteStock;
                        END ELSE
                            CU := Item."Unit Cost";
                    END;
                END;
                IF StockNul THEN BEGIN
                    IF (QteStock = 0) THEN //1708
                        CurrReport.SKIP;
                END;
                //>>MIG001

                NewTotStockVal := CU * QteStock;

                //<<001
                CUTotal := 0;
                ValStockTotal := 0;
                QteStockTotal := 0;

                EcrValeur.RESET;
                EcrValeur.SETCURRENTKEY(EcrValeur."Item No.", EcrValeur."Posting Date", EcrValeur."Item Ledger Entry Type", EcrValeur."Entry Type",
                EcrValeur."Variance Type", EcrValeur."Item Charge No.", EcrValeur."Location Code", EcrValeur."Variant Code");
                EcrValeur.SETRANGE(EcrValeur."Item No.", Item."No.");
                EcrValeur.SETRANGE(EcrValeur."Posting Date", 0D, DateStock);

                IF "Magasin No." <> '' THEN
                    EcrValeur.SETRANGE(EcrValeur."Location Code", "Magasin No.");
                IF EcrValeur.FINDFIRST THEN BEGIN
                    EcrValeur.CALCSUMS(EcrValeur."Cost Amount (Actual)", EcrValeur."Cost Amount (Expected)", EcrValeur."Item Ledger Entry Quantity");
                    QteStockTotal := EcrValeur."Item Ledger Entry Quantity";
                    IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                        CUTotal := Item."Standard Cost"
                    ELSE BEGIN
                        IF QteStockTotal <> 0 THEN BEGIN
                            ValStockTotal := EcrValeur."Cost Amount (Actual)" + EcrValeur."Cost Amount (Expected)";
                            CUTotal := ValStockTotal / QteStockTotal;
                        END ELSE
                            CUTotal := Item."Unit Cost";
                    END;
                END;
                //>>001
                Counter += 1; //HD
            end;

            trigger OnPreDataItem()
            begin
                FiltersText := Item.GetFilters;
                // CurrReport.CREATETOTALS(NewTotStockVal);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(DateStock; DateStock)
                    {
                        Caption = 'Dernier date du calcul du stock';
                    }
                    field(StockNul; StockNul)
                    {
                        Caption = 'Ignorer Stock 0';
                    }
                }
            }
        }


    }

    labels
    {
        Article = 'Item';
        Qte_stock = 'Qte stock';
        PMP = 'PMP (Euro)';
        StockValue = 'Stock Value (Euro)';
        Compta_Stock = 'Compta. Stock';
        Reapro = 'Réapro';
        Bloc_ked = 'Blocked';
        Total = 'Total';
        InvFamilyLbl = 'Inventory Family';
        RepSystemLbl = 'Replenishment System';
    }

    trigger OnPreReport()
    begin
        IF DateStock = 0D THEN ERROR('La date de calcul de stock est obligatoire');

        TotalValStock := 0;
        Counter := 0;//HD
        CompanyInfo.GET;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        DateStock: Date;
        "Magasin No.": Code[10];
        ValStock: Decimal;
        CompanyInfo: Record 79;
        EcrValeur: Record 5802;
        StockNul: Boolean;
        QteStock: Decimal;
        EcrArticle: Record 32;
        CU: Decimal;
        ExcelBuf: Record 370 temporary;
        PrintToExcel: Boolean;
        Rec330: Record 330;
        CurrFactor: Decimal;
        TotalValStock: Decimal;
        PurchInvLine: Record 123;
        ValueEntry: Record 5802;
        InvPostGroup: Record 94;
        LocalEUR: Decimal;
        PerQty: Decimal;
        LocalQty: Decimal;
        ILE: Record 32;
        NewTotStockVal: Decimal;
        Text001: Label 'Trial Balance';
        Text002: Label 'Company Name';
        Text003: Label 'Report No.';
        Text004: Label 'Report Name';
        Text005: Label 'User ID';
        Text006: Label 'Date';
        Text007: Label 'G/L Filter';
        Text0001: Label 'Stock jusqu''à ';
        QteStockTotal: Decimal;
        ValStockTotal: Decimal;
        CUTotal: Decimal;
        Counter: Integer;
        FiltersText: Text;
}

