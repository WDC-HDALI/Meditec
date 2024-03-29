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
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }

                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //ControlSNnumber;
        //ControlItemRefCustomer
    end;

    trigger OnModifyRecord(): Boolean
    begin

        //ControlSNnumber;
        // ControlItemRefCustomer
    end;

    procedure ControlItemRefCustomer()
    var
        lItemRef: record "Item Reference";
        ltext001: Label 'Cet article n''est pas à ce client.\ Veuillez vérifier!!';
    begin
        lItemRef.Reset();
        lItemRef.SetRange("Item No.", Rec."Item No.");
        lItemRef.SetRange("Reference Type", lItemRef."Reference Type"::Customer);
        lItemRef.SetRange("Reference No.", Rec."Customer No.");
        if not lItemRef.FindFirst() then
            Error(ltext001);

    end;

    Procedure ControlSNnumber()
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
        CurrCartonNo: code[20];
        CurrLineNo: Integer;
}
