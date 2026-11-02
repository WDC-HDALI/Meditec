pageextension 50017 "WDC Company Information" extends "Company Information"
{
    layout
    {
        addafter("E-Mail")
        {
            field("Home Page 2"; Rec."Home Page 2")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Home Page', FRA = 'Page d''accueil';
            }
        }
    }
}
