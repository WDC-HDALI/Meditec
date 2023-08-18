pageextension 50022 "WDC Sales Order Subform" extends "Sales Order Subform"
{

    actions
    {
        addlast("&Line")
        {
            action("Select Package")
            {
                ApplicationArea = all;
                Image = Compress;
                CaptionML = FRA = 'Sélectionner cartons';
                trigger OnAction()
                var

                    lCartonToPostPage: page "Carton to Post";
                    lCarton: Record Carton;
                begin
                    //rec.TestField("Qty. to Ship");
                    lCarton.RESET;
                    CLEAR(lCartonToPostPage);
                    lCarton.Setrange(Status, lCarton.Status::Release);
                    lCarton.Setrange(Shipped, false);
                    lCarton.Setrange("Customer No.", Rec."Bill-to Customer No.");
                    lCartonToPostPage.SetFields(Rec."Document Type", rec."Document No.", rec."Line No.", rec."No.", rec.Quantity, Rec."Location Code");
                    lCartonToPostPage.SETTABLEVIEW(lCarton);
                    lCartonToPostPage.SETRECORD(lCarton);
                    // lCarton."Item No. Filter" := Rec."No.";
                    // lCarton.SetFilter("Item No. Filter", Rec."No.");
                    // lCarton.CalcFields("Qty Item");
                    // lCarton.SetFilter("Qty Item", '<>%1', 0);
                    lCartonToPostPage.RUNMODAL;
                    // IF lCartonToPostPage.RUNMODAL = ACTION::OK THEN BEGIN
                    //     rec.OpenItemTrackingLines();
                    // end;
                end;
            }
        }

    }

    procedure getQtyInvLines(pInvoiceNo: code[20]; pRefLineNo: integer): Decimal
    var
        LsalesLines: Record "Sales Line";
    begin
        if LsalesLines.Get(LsalesLines."Document Type"::Invoice, pInvoiceNo, pRefLineNo) Then;
        exit(LsalesLines.Quantity);

    end;

}
