report 50010 "WDC Grand Livre sur Excel"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/GrandLivresurExcel.rdlc';

    Caption = 'G/L Detail Trial Balance';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Date Filter", "GLEntry Type Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Adr; Company.Address)
            {
            }
            column(Phone; Company."Phone No.")
            {
            }
            column(Fax; Company."Fax No.")
            {
            }
            column(VAT; Company."VAT Registration No.")
            {
            }
            column(Trade; '')//Company."Trade Register") WDC01
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column("Filter"; Filter)
            {
            }
            column(FiscalYearStatusText; FiscalYearStatusText)
            {
            }
            column(Text009; Text009Lbl)
            {
            }
            column(GLAccountTypeFilter; GLAccountTypeFilter)
            {
            }
            column(G_L_Account__No__; "No.")
            {
            }
            column(G_L_Account_Name; Name)
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount_; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount_; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount_; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
            {
            }
            column(GLAccount2__Debit_Amount_; GLAccount2."Debit Amount")
            {
            }
            column(GLAccount2__Credit_Amount_; GLAccount2."Credit Amount")
            {
            }
            column(GLAccount2__Debit_Amount____GLAccount2__Credit_Amount_; GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount__Control1120054; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount__Control1120056; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount__Control1120058; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(ShowBodyGLAccount; ShowBodyGLAccount)
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount__Control1120062; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount__Control1120064; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount__Control1120066; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Entry___Debit_Amount__Control1120070; "G/L Entry"."Debit Amount")
            {
            }
            column(G_L_Entry___Credit_Amount__Control1120072; "G/L Entry"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount____GLAccount2__Debit_Amount____GLAccount2__Credit_Amount_; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount" + GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(G_L_Account_G_L_Entry_Type_Filter; "GLEntry Type Filter")
            {
            }
            column(G_L_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(G_L_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(G_L_Detail_Trial_BalanceCaption; G_L_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(To_be_continuedCaption; To_be_continuedCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(G_L_Account__TABLECAPTION__________Filter; "G/L Account".TABLECAPTION + ': ')
            {
            }
            column(FiltreCompte; FiltreCompte)
            {
            }
            column(filtreDate; Text013 + FORMAT(StartDate) + '     au     ' + FORMAT(EndDate))
            {
            }
            column(FiltreTypeEcriture; FiltreTypeEcriture)
            {
            }
            column(FiltreTypeOrigine; FiltreTypeOrigine)
            {
            }
            column(FiltreNumOrigine; FiltreNumOrigine)
            {
            }
            column(FiltreCodeJournal; FiltreCodeJournal)
            {
            }
            column(FiltreLettre; FiltreLettre)
            {
            }
            dataitem(TableDate; 2000000007)
            {
                DataItemTableView = SORTING("Period Type", "Period Start");
                PrintOnlyIfDetail = true;
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
                {
                }
                column(G_L_Entry___Debit_Amount__Control1120080; "G/L Entry"."Debit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount____GLAccount2__Debit_Amount_; "G/L Entry"."Debit Amount" + GLAccount2."Debit Amount")
                {
                }
                column(G_L_Entry___Credit_Amount__Control1120084; "G/L Entry"."Credit Amount")
                {
                }
                column(G_L_Entry___Credit_Amount____GLAccount2__Credit_Amount_; "G/L Entry"."Credit Amount" + GLAccount2."Credit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount_____G_L_Entry___Credit_Amount__Control1120088; "G/L Entry"."Debit Amount" - "G/L Entry"."Credit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount____GLAccount2__Debit_Amount_______G_L_Entry___Credit_Amount____GLAccount2__Credit_Amount__; ("G/L Entry"."Debit Amount" + GLAccount2."Debit Amount") - ("G/L Entry"."Credit Amount" + GLAccount2."Credit Amount"))
                {
                }
                column(Date__Period_Name_; TableDate."Period Name")
                {
                }
                column(Date__Period_No__; TableDate."Period No.")
                {
                }
                column(Year; DATE2DMY("G/L Entry"."Posting Date", 3))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Date_Period_Start; "Period Start")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("G/L Entry"; 17)
                {
                    DataItemLink = "G/L Account No." = FIELD("No."),
                                   //"Entry Type" = FIELD("GLEntry Type Filter"),
                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = SORTING("G/L Account No.");
                    RequestFilterFields = "Source Type", "Source No.", "Source Code", "Posting Date", "Global Dimension 1 Code";
                    column(G_L_Entry__Debit_Amount_; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount_; "Credit Amount")
                    {
                    }
                    column(Debit_Amount_____Credit_Amount_; "Debit Amount" - "Credit Amount")
                    {
                    }
                    column(G_L_Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(G_L_Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(G_L_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(G_L_Entry__External_Document_No__; "External Document No.")
                    {
                    }
                    column(G_L_Entry_Description; Description)
                    {
                    }
                    column(Commentaire; '') //Commentaire) //WDC01
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120116; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120119; "Credit Amount")
                    {
                    }
                    column(Solde; Solde)
                    {
                    }
                    column(G_L_Entry___Entry_No__; "G/L Entry"."Entry No.")
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120126; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120128; "Credit Amount")
                    {
                    }
                    column(Debit_Amount_____Credit_Amount__Control1120130; "Debit Amount" - "Credit Amount")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(TableDate."Period Type") + ' ' + TableDate."Period Name")
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120136; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120139; "Credit Amount")
                    {
                    }
                    column(Solde_Control1120142; Solde)
                    {
                    }
                    column(TotalByInt; TotalByInt)
                    {
                    }
                    column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
                    {
                    }
                    column(G_L_Entry_Entry_Type; "G/L Entry".EntryType)
                    {
                    }
                    column(G_L_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(G_L_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }
                    column(Source; "G/L Entry"."Source No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF ("Debit Amount" = 0) AND
                           ("Credit Amount" = 0)
                        THEN
                            CurrReport.SKIP;
                        Solde := Solde + "Debit Amount" - "Credit Amount";
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF DocNumSort THEN
                            SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date");
                        SETRANGE("Posting Date", TableDate."Period Start", TableDate."Period End");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    CurrReport.CREATETOTALS("G/L Entry"."Debit Amount", "G/L Entry"."Credit Amount");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GLAccount2.COPY("G/L Account");
                WITH GLAccount2 DO BEGIN
                    IF "Income/Balance" = 0 THEN
                        SETRANGE("Date Filter", PreviousStartDate, PreviousEndDate)
                    ELSE
                        SETRANGE("Date Filter", 0D, PreviousEndDate);
                    CALCFIELDS("Debit Amount", "Credit Amount");
                    Solde := "Debit Amount" - "Credit Amount";
                END;
                IF "Income/Balance" = 0 THEN
                    SETRANGE("Date Filter", StartDate, EndDate)
                ELSE
                    SETRANGE("Date Filter", 0D, EndDate);
                CALCFIELDS("Debit Amount", "Credit Amount");
                IF ("Debit Amount" = 0) AND ("Credit Amount" = 0) THEN
                    CurrReport.SKIP;


                ShowBodyGLAccount :=
                  ((GLAccount2."Debit Amount" = "Debit Amount") AND (GLAccount2."Credit Amount" = "Credit Amount")) OR ("Account Type" <> 0);
            end;

            trigger OnPreDataItem()
            begin
                Company.GET;

                IF GETFILTER("Date Filter") = '' THEN
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                IF COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' THEN
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                Period.SETRANGE("Period Start", StartDate);
                CASE TotalBy OF
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);

                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                END;
                IF NOT Period.FINDFIRST THEN
                    ERROR(Text010, StartDate, Period.GETFILTER("Period Type"));
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
                    EndDate := 0D
                ELSE
                    EndDate := GETRANGEMAX("Date Filter");
                CLEAR(Period);
                Period.SETRANGE("Period End", CLOSINGDATE(EndDate));
                CASE TotalBy OF
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                END;
                IF NOT Period.FINDFIRST THEN
                    ERROR(Text011, EndDate, Period.GETFILTER("Period Type"));

                CurrReport.CREATETOTALS(GLAccount2."Debit Amount", GLAccount2."Credit Amount",
                  "Debit Amount", "Credit Amount",
                  "G/L Entry"."Debit Amount", "G/L Entry"."Credit Amount");
                // FR0003.begin
                FiscalYearStatusText := STRSUBSTNO(Text012, FYFiscalClose.CheckFiscalYearStatus(GETFILTER("Date Filter")));
                // FR0003.end

                // FR0005.BEGIN
                TotalByInt := TotalBy;
                // FR0005.END


                //afef 05-09-2013 >>

                IF "G/L Account".GETFILTER("G/L Account"."No.") <> '' THEN
                    FiltreCompte := "G/L Account".GETFILTER("G/L Account"."No.")
                ELSE
                    FiltreCompte := 'Tous';
                //test
                FiltreDate := GETFILTER("Date Filter");

                //afef 05-09-2013 <<
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(TotalBy; TotalBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Centralized by';
                        OptionCaption = ' ,Week,Month,Quarter,Year';
                    }
                    field(DocNumSort; DocNumSort)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sorted by Document No.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        TotalBy := TotalBy::Month
    end;

    trigger OnPreReport()
    begin
        Filter := "G/L Account".GETFILTERS;
        // FR0005.BEGIN
        GLAccountTypeFilter := "G/L Account".GETFILTER("GLEntry Type Filter");
        // FR0005.END

        //afef 05-09-2013 >>

        IF "G/L Account".GETFILTER("G/L Account"."GLEntry Type Filter") <> '' THEN
            FiltreTypeEcriture := 'Type Ecriture : ' + "G/L Account".GETFILTER("G/L Account"."GLEntry Type Filter")
        ELSE
            FiltreTypeEcriture := '';

        IF "G/L Entry".GETFILTER("G/L Entry"."Source Type") <> '' THEN
            FiltreTypeOrigine := 'Type Origine: ' + "G/L Entry".GETFILTER("G/L Entry"."Source Type")
        ELSE
            FiltreTypeOrigine := '';

        IF "G/L Entry".GETFILTER("G/L Entry"."Source No.") <> '' THEN
            FiltreNumOrigine := 'N° Origine: ' + "G/L Entry".GETFILTER("G/L Entry"."Source No.")
        ELSE
            FiltreNumOrigine := '';

        IF "G/L Entry".GETFILTER("G/L Entry"."Source Code") <> '' THEN
            FiltreCodeJournal := 'Code Journal: ' + "G/L Entry".GETFILTER("G/L Entry"."Source Code")
        ELSE
            FiltreCodeJournal := '';

        IF "G/L Entry".GETFILTER("G/L Entry".Lettrage) <> '' THEN
            FiltreLettre := 'Lettre: ' + "G/L Entry".GETFILTER("G/L Entry".Lettrage)
        ELSE
            FiltreLettre := '';
        //afef 05-09-2013 <<
    end;

    var
        Text001: Label 'You must fill in the %1 field.';
        Text002: Label 'You must specify a Starting Date.';
        Text003: Label 'Printed by %1';
        Text004: Label 'Fiscal Year Start Date : %1';
        Text005: Label 'Page %1';
        Text006: Label 'Balance at %1 ';
        Text007: Label 'Balance at %1';
        Text008: Label 'Total';
        GLAccount2: Record 15;
        Period: Record 2000000007;
        FYFiscalClose: Codeunit "Fiscal Year-FiscalClose";
        FiltreDateCalc: Codeunit "DateFilter-Calc WDC";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text;
        Solde: Decimal;
        TotalBy: Option " ",Week,Month,Quarter,Year;
        DocNumSort: Boolean;
        ShowBodyGLAccount: Boolean;
        "Filter": Text;
        GLAccountTypeFilter: Text;
        Text010: Label 'The selected starting date %1 is not the start of a %2.';
        Text011: Label 'The selected ending date %1 is not the end of a %2.';
        FiscalYearStatusText: Text;
        Text012: Label 'Fiscal-Year Status: %1';
        TotalByInt: Integer;
        Text009Lbl: Label 'This report includes simulation entries.';
        G_L_Detail_Trial_BalanceCaptionLbl: Label 'G/L Detail Trial Balance';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Source_CodeCaptionLbl: Label 'Source Code';
        Document_No_CaptionLbl: Label 'Document No.';
        External_Document_No_CaptionLbl: Label 'External Document No.';
        DescriptionCaptionLbl: Label 'Description';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        BalanceCaptionLbl: Label 'Balance';
        ContinuedCaptionLbl: Label 'Continued';
        To_be_continuedCaptionLbl: Label 'To be continued';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        Total_Date_RangeCaptionLbl: Label 'Total Date Range';
        Previous_pageCaptionLbl: Label 'Previous page';
        Current_pageCaptionLbl: Label 'Current page';
        Company: Record 79;
        Text013: Label 'Période du: ';
        FiltreDate: Text[250];
        FiltreTypeEcriture: Text[100];
        FiltreTypeOrigine: Text[250];
        FiltreNumOrigine: Text[50];
        FiltreCodeJournal: Text[250];
        FiltreLettre: Text[100];
        FiltreAffichLettrage: Option " ","Non Lettré","Lettré";
        FiltreCompte: Text[250];
        GPurchaseInvoiceHeader: Record 122;
        DateSort: Boolean;
}

