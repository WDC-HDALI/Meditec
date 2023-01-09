pageextension 50009 "WDC Accounting Role Center" extends 9027
{

    actions
    {
        // Add changes to page actions here
        addafter(Journals)
        {
            group("Balance")
            {
                Caption = 'Balance';

                action("G/L Trial Balance ")
                {
                    Caption = 'Balance Comptes Généreaux';
                    ApplicationArea = All;

                    RunObject = report 50003;
                }
                action("Customer Trial Balance")
                {
                    Caption = 'Balance auxiliaire client';
                    ApplicationArea = All;

                    RunObject = Report 50005;
                }
                action("Vendor Trial Balance")
                {
                    Caption = 'Balance auxiliaire fournisseur';
                    ApplicationArea = All;

                    RunObject = Report 50007;
                }

                action("Bank Account Trial Balance")
                {
                    Caption = 'Balance Compte bancaire';
                    ApplicationArea = All;

                    RunObject = Report 50009;
                }
            }
            group("Grand Livre")
            {
                Caption = 'Grand livre';
                action("General Ledger Accounts")
                {
                    Caption = 'Grand Livre Comptes Généreaux';
                    ApplicationArea = All;

                    RunObject = report 50004;
                }
                action("Grand livre excel")
                {
                    Caption = 'Grand livre excel';
                    ApplicationArea = All;

                    RunObject = report 50010;
                }
                action("Customer Ledger")
                {
                    Caption = 'Grand Livre Client';
                    ApplicationArea = All;

                    RunObject = Report 50006;
                }
                action("Vendor Ledger")
                {
                    Caption = 'Grand livre fournisseur';
                    ApplicationArea = All;

                    RunObject = Report 50008;
                }


                // action("General Ledger Bank Account")
                // {
                //     Caption = 'Grand Livre Compte bancaire';
                //     ApplicationArea = All;

                //     RunObject = Report 10810;
                // }

                // action("Customer Journal")
                // {
                //     Caption = 'Journal Compte Client';
                //     ApplicationArea = All;

                //     RunObject = Report 10813;
                // }

                // action("Vendor Journal")
                // {
                //     Caption = 'Journal Compte Fournisseur';
                //     ApplicationArea = All;

                //     RunObject = Report 10814;
                // }

                // action("Journal Bank account")
                // {
                //     Caption = 'Journal Compte Bancaire';
                //     ApplicationArea = All;

                //     RunObject = Report 10815;
                // }

                // action("GL Cust/Leadger Reconciliation")
                // {
                //     Caption = 'Rapprochement Cpta Gén/.Client';
                //     ApplicationArea = All;

                //     RunObject = Report 10861;
                // }

                // action("GL Vend/Leadger Reconciliation")
                // {
                //     Caption = 'Rapprochement Cpta Gén/.Fourn';
                //     ApplicationArea = All;

                //     RunObject = Report 10863;
                // }

                // action("General Account Statement")
                // {
                //     Caption = 'Relevé Compte Général';
                //     ApplicationArea = All;

                //     RunObject = Report 10842;
                // }
            }
        }
    }

    var
        myInt: Integer;
}


