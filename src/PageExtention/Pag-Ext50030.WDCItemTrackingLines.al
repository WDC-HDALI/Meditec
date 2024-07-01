pageextension 50030 "WDC Item Tracking Lines" extends "Item Tracking Lines"
{

    actions
    {
        addafter("Create Customized SN")
        {
            action("Create Customized SN meditec")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Create Customized SN meditec', FRA = 'Créer N° Série Méditec';
                Image = CreateSerialNo;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if InsertIsBlocked then
                        exit;
                    CreateCustomizedSNByPage();
                end;
            }
        }
    }
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        CurrPage.SaveRecord();
    end;

    local procedure CreateCustomizedSNByPage()
    var
        EnterCustomizedSN1: Page "Enter Customized SN";
        EnterCustomizedSN: Page 50024;
        QtyToCreate: Decimal;
        QtyToCreateInt: Integer;
        Increment: Integer;
        CreateLotNo: Boolean; //HD01
        CustomizedSN: Code[50];//HD01
        CreateSNInfo: Boolean;//HD01
    begin
        if ZeroLineExists() then
            Rec.Delete();

        QtyToCreate := UndefinedQtyArray[1] * QtySignFactor();
        if QtyToCreate < 0 then
            QtyToCreate := 0;

        if QtyToCreate mod 1 <> 0 then
            Error(Text008);

        QtyToCreateInt := QtyToCreate;


        Clear(EnterCustomizedSN);
        EnterCustomizedSN.SetFields(Rec."Item No.", Rec."Variant Code", QtyToCreate, false, false);
        if EnterCustomizedSN.RunModal() = ACTION::OK then begin
            //<<HD01
            EnterCustomizedSN.GetFields(QtyToCreateInt, CreateLotNo, CustomizedSN, Increment, CreateSNInfo);
            CreateCustomizedSNBatch(QtyToCreateInt, CreateLotNo, CustomizedSN, Increment, CreateSNInfo);
            //CurrPage.SaveRecord();
            //>>HD01
        end else
            CalculateSums();

        ;
    end;

    local procedure CreateCustomizedSNBatch(QtyToCreate: Decimal; CreateLotNo: Boolean; CustomizedSN: Code[50]; Increment: Integer; CreateSNInfo: Boolean)
    var
        i: Integer;
        Counter: Integer;
        CheckTillEntryNo: Integer;
        ItemTrackingLines: Page 6510;
    begin
        if IncStr(CustomizedSN) = '' then
            Error(UnincrementableStringErr, CustomizedSN);
        NoSeriesMgt.TestManual(Item."Serial Nos.");

        if QtyToCreate <= 0 then
            Error(Text009);
        if QtyToCreate mod 1 <> 0 then
            Error(Text008);

        if CreateLotNo then begin
            Rec.TestField("Lot No.", '');
            AssignNewLotNo();

        end;

        CheckTillEntryNo := LastEntryNo;
        for i := 1 to QtyToCreate do begin
            Rec.Validate("Quantity Handled (Base)", 0);
            Rec.Validate("Quantity Invoiced (Base)", 0);
            AssignNewCustomizedSerialNo(CustomizedSN);
            Rec.Validate("Quantity (Base)", QtySignFactor());
            Rec."Entry No." := NextEntryNo();
            if TestTempSpecificationExists(CheckTillEntryNo) then
                Error('');
            Rec.Insert();

            TempItemTrackLineInsert.TransferFields(Rec);
            TempItemTrackLineInsert.Insert();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);

            if CreateSNInfo then
                ItemTrackingMgt.CreateSerialNoInformation(Rec);

            if i < QtyToCreate then begin
                Counter := Increment;
                repeat
                    CustomizedSN := IncStr(CustomizedSN);
                    Counter := Counter - 1;
                until Counter <= 0;
            end;
        end;
        CalculateSums();
    end;

    local procedure AssignNewLotNo()
    var
        IsHandled: Boolean;
    begin
        if IsHandled then
            exit;

        Item.TestField("Lot Nos.");
        Rec.Validate("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WorkDate(), true));
    end;

    procedure TestTempSpecificationExistsWDC() Exists: Boolean
    begin
        exit(TestTempSpecificationExists(-1));
    end;

    local procedure AssignNewCustomizedSerialNo(CustomizedSN: Code[50])
    var
        IsHandled: Boolean;
    begin
        if IsHandled then
            exit;

        Rec.Validate("Serial No.", CustomizedSN);
    end;

    local procedure TestTempSpecificationExists(CheckTillEntryNo: Integer) Exists: Boolean
    var
        TrackingSpecification: Record "Tracking Specification";
    begin
        if not Rec.TrackingExists() then
            exit(false);

        TrackingSpecification.Copy(Rec);
        Rec.SetTrackingKey();
        Rec.SetRange("Serial No.", Rec."Serial No.");
        if Rec."Serial No." = '' then
            Rec.SetNonSerialTrackingFilterFromSpec(Rec);
        if CheckTillEntryNo = -1 then
            Rec.SetFilter("Entry No.", '<>%1', Rec."Entry No.")
        else
            Rec.SetFilter("Entry No.", '<=%1', CheckTillEntryNo); // Validate only against the existing entries.
        Rec.SetRange("Buffer Status", 0);

        Exists := not Rec.IsEmpty();
        Rec.Copy(TrackingSpecification);
        if Exists and CurrentPageIsOpen then
            if Rec."Serial No." = '' then
                Error(Text011, Rec."Serial No.", Rec."Lot No.", Rec."Package No.")
            else
                Error(Text012, Rec."Serial No.");
    end;

    Local procedure QtySignFactor(): Integer
    begin
        if SourceQuantityArray[1] < 0 then
            exit(-1);

        exit(1)
    end;

    var
        Text008: Label 'The quantity to create must be an integer.';
        TempReservEntry: Record "Reservation Entry" temporary;
        TempTrackingSpecification2: Record "Tracking Specification" temporary;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        UnincrementableStringErr: Label 'The value in the %1 field must have a number so that we can assign the next number in the series.', Comment = '%1 = serial number';

        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ItemTrackingEntryType: Enum "Item Tracking Entry Type";
        CurrentEntryStatus: Enum "Reservation Status";
        QtyRoundingPerBase: Decimal;
        QtyToAddAsBlank: Decimal;
        Text002: Label 'Quantity must be %1.';
        Text003: Label 'negative';
        Text004: Label 'positive';
        SecondSourceID: Integer;
        IsAssembleToOrder: Boolean;
        ExpectedReceiptDate: Date;
        ShipmentDate: Date;
        Text005: Label 'Error when writing to database.';
        Text006: Label 'The corrections cannot be saved as excess quantity has been defined.\Close the form anyway?';
        Text007: Label 'Another user has modified the item tracking data since it was retrieved from the database.\Start again.';
        Text009: Label 'The quantity to create must be positive.';
        Text011: Label 'Tracking specification with Serial No. %1 and Lot No. %2 and Package %3 already exists.', Comment = '%1 - serial no, %2 - lot no, %3 - package no.';
        Text012: Label 'Tracking specification with Serial No. %1 already exists.';
        DeleteIsBlocked: Boolean;
        Text014: Label 'The total item tracking quantity %1 exceeds the %2 quantity %3.\The changes cannot be saved to the database.';
        Text015: Label 'Do you want to synchronize item tracking on the line with item tracking on the related drop shipment %1?';
        BlockCommit: Boolean;
        IsCorrection: Boolean;
        CurrentPageIsOpen: Boolean;
        CalledFromSynchWhseItemTrkg: Boolean;
        CurrentSourceCaption: Text[255];
        CurrentSourceRowID: Text[250];
        SecondSourceRowID: Text[250];
        Text016: Label 'purchase order line';
        Text017: Label 'sales order line';
        Text018: Label 'Saving item tracking line changes';
        AvailabilityWarningsQst: Label 'You do not have enough inventory to meet the demand for items in one or more lines.\This is indicated by No in the Availability fields.\Do you want to continue?';
        Text020: Label 'Placeholder';
        ExcludePostedEntries: Boolean;
        ProdOrderLineHandling: Boolean;
        ItemTrackingManagedByWhse: Boolean;
        ItemTrkgManagedByWhseMsg: Label 'You cannot assign a lot or serial number because item tracking for this document line is done through a warehouse activity.';
        ConfirmWhenExitingMsg: Label 'One or more lines have tracking specified, but Quantity (Base) is zero. If you continue, data on these line will be lost. Do you want to close the page?';
        ScanQtyExceedMaximumMsg: Label 'Item tracking is successfully defined for quantity %1.', Comment = '%1= maximum value of the item tracking lines';
        ItemTrackingSubTypeErr: Label 'The SubType of Item Tracking Specification is incorrect!';
        ItemTrackingTypeErr: Label 'The Type of Item Tracking Specification is incorrect!';
        ContinuousScanningMode: Boolean;
        CameraBarcodeScannerAvailable: Boolean;


        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        TempItemTrackLineInsert: Record "Tracking Specification" temporary;
        TempItemTrackLineModify: Record "Tracking Specification" temporary;
        TempItemTrackLineDelete: Record "Tracking Specification" temporary;
        TempItemTrackLineReserv: Record "Tracking Specification" temporary;
        TotalTrackingSpecification: Record "Tracking Specification";
        SourceTrackingSpecification: Record "Tracking Specification";
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
        CurrentRunMode: Enum "Item Tracking Run Mode";
        CurrentSignFactor: Integer;
        ForBinCode: Code[20];
        Inbound: Boolean;
        InsertIsBlocked: Boolean;
        IsDirectTransfer: Boolean;
        LastEntryNo: Integer;
        QtyPerUOM: Decimal;
        UndefinedQtyArray: array[3] of Decimal;
        SourceQuantityArray: array[5] of Decimal;
        CurrentSourceType: Integer;
        ApplFromItemEntryVisible: Boolean;
        ApplToItemEntryVisible: Boolean;
        ItemNoEditable: Boolean;
        VariantCodeEditable: Boolean;
        LocationCodeEditable: Boolean;
        Handle1Visible: Boolean;
        Handle2Visible: Boolean;
        Handle3Visible: Boolean;
        QtyToHandleBaseVisible: Boolean;
        Invoice1Visible: Boolean;
        Invoice2Visible: Boolean;
        Invoice3Visible: Boolean;
        QtyToInvoiceBaseVisible: Boolean;
        PackageNoVisible: Boolean;
        NewSerialNoVisible: Boolean;
        NewLotNoVisible: Boolean;
        NewPackageNoVisible: Boolean;
        NewExpirationDateVisible: Boolean;
        ButtonLineReclassVisible: Boolean;
        ButtonLineVisible: Boolean;
        FunctionsSupplyVisible: Boolean;
        FunctionsDemandVisible: Boolean;
        InboundIsSet: Boolean;
        QtyToHandleBaseEditable: Boolean;
        QtyToInvoiceBaseEditable: Boolean;
        QuantityBaseEditable: Boolean;
        SerialNoEditable: Boolean;
        LotNoEditable: Boolean;
        PackageNoEditable: Boolean;
        DescriptionEditable: Boolean;
        NewSerialNoEditable: Boolean;
        NewLotNoEditable: Boolean;
        NewPackageNoEditable: Boolean;
        NewExpirationDateEditable: Boolean;
        ExpirationDateEditable: Boolean;
        WarrantyDateEditable: Boolean;
        IsInvtDocumentCorrection: Boolean;
        HasSameQuantityBase: Boolean;




}

