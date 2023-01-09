pageextension 50011 "WDC Finance Role Center" extends 8901
{

    actions
    {
        // Add changes to page actions here
        addafter("Balance Sheet")
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
            }
        }
    }

}


