page 50020 "Carton Tracking List"
{
    Caption = 'Traçabilités Cartons';
    PageType = List;
    SourceTable = "Carton Tracking Lines";
    UsageCategory = Lists;
    Editable = false;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
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
                field("Carton No."; Rec."Carton No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }

                field("Ship to code"; Rec."Ship to code")
                {
                    ApplicationArea = All;

                }
                field("Ship to name"; Rec."Ship to name")
                {
                    ApplicationArea = All;

                }

            }
        }
    }
    //<<WDC.IM
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Entry No. doc");
        Rec."Entry No. Filter" := Rec."Entry No. doc";
        Rec.CalcFields("Shipment No.");
        Rec.CalcFields("Shipment Line No.");
    end;
    //>>WDC.IM
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        ControlSNnumber;
    end;

    Procedure ControlSNnumber()
    var
        CartonTrack: Record "Carton Tracking Lines";
    begin
        CartonTrack.Reset();
        CartonTrack.SetRange("Carton No.", CurrCartonNo);
        CartonTrack.SetRange("Ref Line No.", CurrLineNo);
        CartonTrack.SetRange("Item No.", Rec."Item No.");
        //if CartonTrack.FindFirst() then
        if CartonTrack.Count + 1 > TotalQte then
            Error(Text001, TotalQte);
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
        Text001: Label 'Nombre des SN insérés est supérieur à la quantité %1';
}
