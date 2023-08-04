page 50014 "Carton Tracking Lines"
{
    Caption = 'Lignes traçabilités Cartons';
    PageType = ListPart;
    SourceTable = "Carton Tracking Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;

                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Carton No."; Rec."Carton No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        ControlSNnumber;
    end;

    Procedure ControlSNnumber()
    var
        CartonTrack: Record "Carton Tracking Lines";
    begin
        // CartonTrack.Reset();
        // CartonTrack.SetRange("Carton No.", CurrCartonNo);
        // CartonTrack.SetRange("Ref Line No.", CurrLineNo);
        // CartonTrack.SetRange("Item No.", Rec."Item No.");
        // //if CartonTrack.FindFirst() then
        // if CartonTrack.Count + 1 > TotalQte then
        //     Error(Text001, TotalQte);
    end;

    procedure SetFields(pCarton: Code[20]; pLineNo: Integer; pQuantity: Decimal)
    begin
        TotalQte := pQuantity;
        CurrCartonNo := pCarton;
        CurrLineNo := pLineNo;
    end;

    var
        TotalQte: Decimal;
        incrQte: Decimal;
        CurrCartonNo: code[20];
        CurrLineNo: Integer;
        Text001: Label 'Nombre des SN insérés est supérieur à la quantité %1';
}
