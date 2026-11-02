tableextension 50011 "Accounting Period Ext" extends "Accounting Period"
{
    fields
    {
        field(50000; "Fiscally Closed"; Boolean)
        {
            Caption = 'Fiscally Closed';
            Editable = false;
        }
        field(50001; "Fiscal Closing Date"; Date)
        {
            Caption = 'Fiscal Closing Date';
            Editable = false;
        }
        field(50002; "Period Reopened Date"; Date)
        {
            Caption = 'Period Reopened Date';
            Editable = false;
        }

    }

    procedure UpdateGLSetup(PeriodEndDate: Date)
    begin
        //with GLSetup do begin //FIXME:
        GLSetup.Get;
        GLSetup.CalcFields("Posting Allowed From");
        if GLSetup."Allow Posting From" <= PeriodEndDate then begin
            GLSetup."Allow Posting From" := GLSetup."Posting Allowed From";
            GLSetup.Modify;
        end;
        if (GLSetup."Allow Posting To" <= PeriodEndDate) and (GLSetup."Allow Posting To" <> 0D) then begin
            GLSetup."Allow Posting To" := CalcDate('<+1M-1D>', GLSetup."Posting Allowed From");
            GLSetup.Modify;
        end;
        //end;
    end;


    procedure UpdateUserSetup(PeriodEndDate: Date)
    begin
        //with UserSetup do begin //FIXME:
        if FindFirst then
            repeat
                if UserSetup."Allow Posting From" <= PeriodEndDate then begin
                    UserSetup."Allow Posting From" := GLSetup."Posting Allowed From";
                    UserSetup.Modify;
                end;
                if (UserSetup."Allow Posting To" <= PeriodEndDate) and (UserSetup."Allow Posting To" <> 0D) then begin
                    UserSetup."Allow Posting To" := CalcDate('<+1M-1D>', GLSetup."Posting Allowed From");
                    UserSetup.Modify;
                end;
            until Next = 0;
        //end
    end;

    var
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";

}