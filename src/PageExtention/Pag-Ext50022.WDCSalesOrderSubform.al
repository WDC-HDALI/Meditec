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
                    lsalesHeader: record "Sales Header";
                begin
                    if lsalesHeader.GET(Rec."Document Type", Rec."Document No.") Then BEGIn
                        lCarton.RESET;
                        CLEAR(lCartonToPostPage);
                        lCarton.SetCurrentKey("No.");
                        lCarton.Setrange(Status, lCarton.Status::Release);
                        lCarton.Setrange(Shipped, false);
                        lCarton.Setrange("Customer No.", Rec."Bill-to Customer No.");
                        lCarton.SetRange("Ship to code", lsalesHeader."Ship-to Code");
                        lCartonToPostPage.SetFields(Rec."Document Type", rec."Document No.", rec."Line No.", rec."No.", rec.Quantity, Rec."Location Code");
                        lCartonToPostPage.SETTABLEVIEW(lCarton);
                        lCartonToPostPage.SETRECORD(lCarton);
                        lCartonToPostPage.RUNMODAL;
                    end;
                End;
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
