page 50024 "WDC Enter Customized SN"
{
    Caption = 'Enter Customized SN Meditec';
    PageType = StandardDialog;
    SaveValues = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item No.';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Item."No." := ItemNo;
                        PAGE.RunModal(0, Item);
                    end;
                }
                field(VariantCode; VariantCode)
                {
                    ApplicationArea = Planning;
                    Caption = 'Variant Code';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ItemVariant.Reset();
                        ItemVariant.SetRange("Item No.", ItemNo);
                        ItemVariant."Item No." := ItemNo;
                        ItemVariant.Code := ItemNo;
                        PAGE.RunModal(0, ItemVariant);
                    end;
                }
                field(CustomizedSN; CustomizedSN)
                {
                    ApplicationArea = all;
                    Caption = 'Customized SN';
                }
                field(Increment; Increment)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Increment';
                }
                field(QtyToCreate; QtyToCreate)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Quantity to Create';
                }

            }
        }
    }

    actions
    {
    }


    trigger OnOpenPage()
    begin
        ItemNo := InitItemNo;
        VariantCode := InitVariantCode;
        QtyToCreate := InitQtyToCreate;
        ProductionOrder.Reset();
        ProductionOrder.SetRange("Source No.", ItemNo);
        if ProductionOrder.FindSet() then BEGIN
            Item.Reset();
            Item.SetRange("No.", ItemNo);
            if Item.FindLast() then begin
                Customer.Reset();
                Customer.SetRange("No.", Item."Customer Code");
                if customer.FindSet() then begin
                    Customer.TestField("Customer Abreviation");
                    ProductionOrder.TestField(Model);
                    customizedSN := Customer."Customer Abreviation" + '-' + ProductionOrder.Model + '-';
                end;

            END;
        end;
    end;


    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        ItemNo: Code[20];

        VariantCode: Code[10];
        QtyToCreate: Integer;
        CreateNewLotNo: Boolean;
        CreateSNInfo: Boolean;
        InitItemNo: Code[20];
        InitVariantCode: Code[10];
        InitQtyToCreate: Integer;

        CustomizedSN: Code[50];
        InitCustomizedSN: Code[50];
        Increment: Integer;
        ProductionOrder: Record "Production Order";
        customer: Record customer;
        customizedSN2: Code[50];
        p1: Page 6515;

    [Obsolete('Replaced by SetFields procedure with additional parameter.', '18.0')]
    procedure SetFields(SetItemNo: Code[20]; SetVariantCode: Code[10]; SetQtyToCreate: Integer; SetCustomerSN: code[50])//ch
    begin
        InitItemNo := SetItemNo;
        InitVariantCode := SetVariantCode;
        InitQtyToCreate := SetQtyToCreate;

        // InitCreateNewLotNo := SetCreateNewLotNo;
    end;

    [Obsolete('Replaced by GetFields procedure with additional parameter.', '18.0')]
    procedure GetFields(var GetQtyToCreate: Integer; var GetCreateNewLotNo: Boolean; var GetCustomizedSN: Code[50]; var GetIncrement: Integer)
    begin
        GetQtyToCreate := QtyToCreate;
        GetCreateNewLotNo := CreateNewLotNo;
        GetCustomizedSN := CustomizedSN;
        GetIncrement := Increment;
    end;

    procedure SetFields(SetItemNo: Code[20]; SetVariantCode: Code[10]; SetQtyToCreate: Integer; SetCreateNewLotNo: Boolean; SetCreateSNInfo: Boolean)
    begin
        InitItemNo := SetItemNo;
        InitVariantCode := SetVariantCode;
        InitQtyToCreate := SetQtyToCreate;
        //InitCreateNewLotNo := SetCreateNewLotNo;
        //InitCreateSNInfo := SetCreateSNInfo;
    end;

    procedure GetFields(var GetQtyToCreate: Integer; var GetCreateNewLotNo: Boolean; var GetCustomizedSN: Code[50]; var GetIncrement: Integer; var GetCreateSNInfo: Boolean)
    begin
        GetQtyToCreate := QtyToCreate;
        GetCreateNewLotNo := CreateNewLotNo;
        GetCustomizedSN := CustomizedSN;
        GetIncrement := Increment;
        GetCreateSNInfo := CreateSNInfo;
    end;
}