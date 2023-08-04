pageextension 50020 "WDC Sales Lines" extends "Sales Lines"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field(cusomerName; CustomerName)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Nom donneur d''ordre';

            }
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = all;

            }
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = all;

            }

        }
        addafter(Quantity)
        {
            field(Inventory; Item.Inventory)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Stock';

            }
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = all;

            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = all;

            }
            field(MargeNet; Rec."Marge Net")
            {
                ApplicationArea = all;
                Caption = 'Marge net';

            }
            field(MargeBrut; Rec."Marge Brut")
            {
                ApplicationArea = all;
                Caption = 'Marge brut';

            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lcustomer: Record 18;

    begin
        Inventory := 0;
        MargeNet := 0;
        MargeBrut := 0;
        CustomerName := '';
        If lcustomer.get(Rec."Sell-to Customer No.") Then
            CustomerName := lcustomer.Name;
        if Item.Get(Rec."No.") then begin
            Item.Setfilter("Date Filter", '%1', Rec."Posting Date");
            Item.CalcFields(Inventory);
            Inventory := Item.Inventory;
        end;
        if (Rec.Type = Rec.type::Item) and (Rec."No." <> '') and (rec."Unit Price" <> 0) then begin

            Rec."Marge net" := ((rec."Unit Price" - Calc_Compenent_Cost(Rec."No.")) / Rec."Unit Price") * 100;
            Rec."Marge brut" := ((rec."Unit Price" - (Calc_Routing_Cost(Rec."No.") + Calc_Compenent_Cost(Rec."No."))) / Rec."Unit Price") * 100;
            Rec.Modify();
        end;
    end;

    procedure Calc_Compenent_Cost(pItem: Code[20]): Decimal
    var
        lItem: Record item;
        lCompItem: Record Item;
        /*lcompenentHeader: Record 99000763;
        lcompenentLine: Record 99000771;
        lworkcenter: Record "Work Center";*/
        ProdBOMLine: Record "Production BOM Line";
        CompenentCostTotal: Decimal;
    begin
        if lItem.get(pItem) then begin
            ProdBOMLine.Reset();
            ProdBOMLine.SetRange("Production BOM No.", lItem."Production BOM No.");
            if ProdBOMLine.FindSet() then
                repeat
                    if lCompItem.Get(ProdBOMLine."No.") then;
                    CompenentCostTotal += ProdBOMLine.Quantity * lCompItem."Unit Cost";
                until ProdBOMLine.Next() = 0;
        end;
        exit(CompenentCostTotal);

    end;

    procedure Calc_Routing_Cost(pItem: Code[20]): Decimal
    var
        lItem: Record item;
        lRoutingLine: Record "Routing Line";
        ProdTotalCost: Decimal;
    begin
        Clear(ProdTotalCost);
        if lItem.get(pItem) then begin
            lRoutingLine.Reset();
            lRoutingLine.SetRange("Routing No.", lItem."Routing No.");
            if lRoutingLine.Findset() then
                repeat
                    ProdTotalCost += lRoutingLine."Run Time" * lRoutingLine."Unit Cost per";
                until lRoutingLine.Next() = 0;
        end;
        exit(ProdTotalCost)

    end;

    var
        Customer: Record 18;
        CustomerName: Text[100];
        Item: Record 27;
        Inventory: Decimal;
        MargeBrut: Decimal;
        MargeNet: Decimal;


}
