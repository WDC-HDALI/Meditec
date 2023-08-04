tableextension 50020 "WDC Serial No. Information" extends "Serial No. Information"
{
    fields
    {
        field(50000; Assembled; Boolean)
        {
            CaptionML = ENU = 'Assembled', FRA = 'Assemblé';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist("Item Ledger Entry" WHERE("Serial No." = FIELD("Serial No."),
                                                                  "Entry Type" = const("Assembly Consumption")));


        }
        field(50001; shipped; Boolean)
        {
            CaptionML = ENU = 'Shipped', FRA = 'Expidié';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist("Item Ledger Entry" WHERE("Serial No." = FIELD("Serial No."),
                                                                  "Entry Type" = const(Sale)));
        }
        field(50002; "Assembled in Carton"; Code[20])
        {
            CaptionML = ENU = 'Assem. in Carton', FRA = 'Assem. Carton';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Carton Tracking Lines"."Carton No." WHERE("Serial No." = FIELD("Serial No.")));
        }

    }

}
