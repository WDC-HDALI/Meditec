report 50012 "Detailed Calculation2"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './DetailedCalculation.rdlc';
    RDLCLayout = './src/Report/RDLC/DetailedCalculation.rdl';
    ApplicationArea = Manufacturing;
    CaptionML = ENU = 'Detailed Calculation', FRA = 'Coût détaillé Meditec';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Low-Level Code");
            RequestFilterFields = "No.";

            column(ExchangeRateAmt; ExchangeRateAmt)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(AsofCalcDate; Text000 + Format(CalculateDate))
            {

            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(ItemTableCaptionFilter; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Description)
            {
                IncludeCaption = true;
            }
            column(ProductionBOMNo_Item; "Production BOM No.")
            {
                IncludeCaption = true;
            }
            column(RoutingNo_Item; "Routing No.")
            {
                IncludeCaption = true;
            }
            column(PBOMVersionCode1; PBOMVersionCode[1])
            {
            }
            column(RtngVersionCode; RtngVersionCode)
            {
            }
            column(LotSize_Item; "Lot Size")
            {
                IncludeCaption = true;
            }
            column(BaseUOM_Item; "Base Unit of Measure")
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {

            }
            column(DetailedCalculationCapt; DetailedCalculationCaptLbl)
            {
            }
            column(ProdTotalCostCapt; ProdTotalCostCaptLbl)
            {
            }
            column(CostTotalCapt; CostTotalCaptLbl)
            {
            }


            dataitem("Routing Line"; "Routing Line")
            {
                DataItemLink = "Routing No." = FIELD("Routing No.");
                DataItemTableView = SORTING("Routing No.", "Version Code", "Operation No.");
                column(InRouting; InRouting)
                {
                }
                column(OperationNo_RtngLine; "Operation No.")
                {
                    IncludeCaption = true;
                }
                column(Type_RtngLine; Type)
                {
                    IncludeCaption = true;
                }
                column(No_RtngLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_RtngLine; Description)
                {
                    IncludeCaption = true;
                }
                column(SetupTime_RtngLine; "Setup Time")
                {
                    IncludeCaption = true;
                }
                column(RunTime_RtngLine; "Run Time")
                {
                    IncludeCaption = true;
                }
                column(CostTime; CostTime)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ProdUnitCost; ProdUnitCost)
                {
                    AutoFormatType = 2;
                }
                column(ProdTotalCost; ProdTotalCost)
                {
                    AutoFormatType = 1;
                }
                column(CostTimeCaption; CostTimeCaptionLbl)
                {

                }
                column(ProdTotalCostCaption; ProdTotalCostCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                var
                    UnitCostCalculation: Option Time,Unit;
                begin
                    ProdUnitCost := "Unit Cost per";

                    CostCalcMgt.RoutingCostPerUnit(
                      Type,
                      "No.",
                      DirectUnitCost,
                      IndirectCostPct,
                      OverheadRate, ProdUnitCost, UnitCostCalculation);
                    CostTime :=
                      CostCalcMgt.CalcCostTime(
                        CostCalcMgt.CalcQtyAdjdForBOMScrap(Item."Lot Size", Item."Scrap %"),
                        "Setup Time", "Setup Time Unit of Meas. Code",
                        "Run Time", "Run Time Unit of Meas. Code", "Lot Size",
                        "Scrap Factor % (Accumulated)", "Fixed Scrap Qty. (Accum.)",
                        "Work Center No.", UnitCostCalculation, MfgSetup."Cost Incl. Setup",
                        "Concurrent Capacities") /
                      Item."Lot Size";

                    ProdTotalCost := CostTime * ProdUnitCost;

                    FooterProdTotalCost += ProdTotalCost;
                end;

                trigger OnPostDataItem()
                begin
                    InRouting := false;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(ProdTotalCost);
                    SetRange("Version Code", RtngVersionCode);

                    InRouting := true;
                end;
            }
            dataitem(BOMLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(InBOM; InBOM)
                {
                }
                column(ProdBOMLineLevelNoCaption; ProdBOMLineLevelNoCaptionLbl)
                {
                }
                column(ProdBOMLineLevelDescCapt; ProdBOMLineLevelDescCaptLbl)
                {
                }
                column(ProdBOMLineLevelQtyCapt; ProdBOMLineLevelQtyCaptLbl)
                {
                }
                column(CostTotalCaption; CostTotalCaptionLbl)
                {
                }
                column(ProdBOMLineLevelTypeCapt; ProdBOMLineLevelTypeCaptLbl)
                {
                }
                column(CompItemBaseUOMCapt; CompItemBaseUOMCaptLbl)
                {
                }
                dataitem(BOMComponentLine; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(ProdBOMLineLevelType; Format(ProdBOMLine[Level].Type))
                    {
                    }
                    column(ProdBOMLineLevelNo; ProdBOMLine[Level]."No.")
                    {
                    }
                    column(ProdBOMLineLevelDesc; ProdBOMLine[Level].Description)
                    {
                    }
                    column(ProdBOMLineLevelQty; ProdBOMLine[Level].Quantity)
                    {
                    }
                    column(UnitCost_CompItem; CompItem."Unit Cost")
                    {
                        AutoFormatType = 2;
                        DecimalPlaces = 2 : 5;
                    }
                    column(LastDirectCost_CompItem; CompItem."Last Direct Cost")
                    {
                        AutoFormatType = 2;
                        DecimalPlaces = 2 : 5;
                    }
                    column(CostTotal; CostTotal)
                    {
                        AutoFormatType = 1;
                    }
                    column(BaseUOM_CompItem; CompItem."Base Unit of Measure")
                    {
                    }
                    column(ShowLine; ProdBOMLine[Level].Type = ProdBOMLine[Level].Type::Item)
                    {
                    }
                    column(LastCost; LastCost)
                    {
                    }
                    column(LastCostTotal; LastCostTotal)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                    UOMFactor: Decimal;
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    ValueEntry: Record "Value Entry";
                    LastExchangeRateAmt: Decimal;

                begin
                    CostTotal := 0;
                    LastCost := 0;
                    LastCostTotal := 0;

                    while ProdBOMLine[Level].Next() = 0 do begin
                        Level := Level - 1;
                        if Level < 1 then
                            CurrReport.Break();
                        ProdBOMLine[Level].SetRange("Production BOM No.", PBOMNoList[Level]);
                        ProdBOMLine[Level].SetRange("Version Code", PBOMVersionCode[Level]);
                    end;

                    NextLevel := Level;
                    Clear(CompItem);

                    if Level = 1 then
                        UOMFactor :=
                          UOMMgt.GetQtyPerUnitOfMeasure(Item, VersionMgt.GetBOMUnitOfMeasure(PBOMNoList[Level], PBOMVersionCode[Level]))
                    else
                        UOMFactor := 1;

                    CompItemQtyBase :=
                      CostCalcMgt.CalcCompItemQtyBase(ProdBOMLine[Level], CalculateDate, Quantity[Level], Item."Routing No.", Level = 1) /
                      UOMFactor;

                    case ProdBOMLine[Level].Type of
                        ProdBOMLine[Level].Type::Item:
                            begin
                                CompItem.Get(ProdBOMLine[Level]."No.");
                                ProdBOMLine[Level].Quantity := CompItemQtyBase / Item."Lot Size";
                                CostTotal := ProdBOMLine[Level].Quantity * CompItem."Unit Cost";
                                FooterCostTotal += CostTotal;

                                //<<WDC.SH
                                ItemLedgerEntry.Reset();
                                ItemLedgerEntry.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                                ItemLedgerEntry.SetRange("Item No.", CompItem."No.");
                                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                if ItemLedgerEntry.FindLast() then begin
                                    ValueEntry.Reset();
                                    ValueEntry.SetCurrentKey("Item Ledger Entry No.", "Entry Type");
                                    ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                                    IF ValueEntry.FindSet() THEN begin
                                        GetLastestExchangeRate('EUR', ValueEntry."Posting Date", LastExchangeRateAmt); //wdc.sh
                                        LastCost := ValueEntry."Cost per Unit" / LastExchangeRateAmt; // SH-17-076-2023
                                        LastCostTotal := ProdBOMLine[Level].Quantity * ValueEntry."Cost per Unit" / LastExchangeRateAmt;  // SH-17-076-2023
                                        TotaLastCost2 += LastCostTotal;
                                    end;

                                end;
                                //>>WDC.SH

                            end;
                        ProdBOMLine[Level].Type::"Production BOM":
                            begin
                                NextLevel := Level + 1;
                                Clear(ProdBOMLine[NextLevel]);
                                PBOMNoList[NextLevel] := ProdBOMLine[Level]."No.";
                                PBOMVersionCode[NextLevel] :=
                                  VersionMgt.GetBOMVersion(ProdBOMLine[Level]."No.", CalculateDate, false);
                                ProdBOMLine[NextLevel].SetRange("Production BOM No.", PBOMNoList[NextLevel]);
                                ProdBOMLine[NextLevel].SetRange("Version Code", PBOMVersionCode[NextLevel]);
                                ProdBOMLine[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                                ProdBOMLine[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                                Quantity[NextLevel] := CompItemQtyBase;
                                Level := NextLevel;
                            end;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    InBOM := false;
                end;

                trigger OnPreDataItem()
                begin
                    if Item."Production BOM No." = '' then
                        CurrReport.Break();

                    Level := 1;

                    ProdBOMHeader.Get(PBOMNoList[Level]);

                    Clear(ProdBOMLine);
                    ProdBOMLine[Level].SetRange("Production BOM No.", PBOMNoList[Level]);
                    ProdBOMLine[Level].SetRange("Version Code", PBOMVersionCode[Level]);
                    ProdBOMLine[Level].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                    ProdBOMLine[Level].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);

                    Quantity[Level] := CostCalcMgt.CalcQtyAdjdForBOMScrap(Item."Lot Size", Item."Scrap %");

                    InBOM := true;
                end;
            }
            dataitem(Footer; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;
            }

            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
                column(UnitCost_Item; Item."Unit Cost")
                {
                    AutoFormatType = 1;
                }
                column(SingleLevelMfgOvhd; SingleLevelMfgOvhd)
                {
                    AutoFormatType = 1;
                }
                column(FooterCostTotal; FooterCostTotal)
                {

                }
                column(SingleLevelMfgOvhdCaption; SingleLevelMfgOvhdCaptionLbl)
                {
                }
                column(FooterProdTotalCost; FooterProdTotalCost)
                {
                }

            }
            dataitem(SalesPrice; "Sales Price")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = where("Sales Type" = filter(Customer), "Unit Price" = filter(<> 0));


                column(InSalesPrice; InSalesPrice)
                {
                }
                column(SalesCode; "Sales Code")
                {
                }
                column(SalesName; SalesName)
                {
                }
                column(StartingDate; Format("Starting Date", 0, 1))
                {
                }
                column(EndingDate; Format("Ending Date", 0, 1))
                {
                }
                column(MinimumQuantity; SalesPrice."Minimum Quantity")
                {
                }
                column(UnitPrice; SalesPrice."Unit Price")
                {
                }
                column(UnitofMeasureCode; SalesPrice."Unit of Measure Code")
                {
                }
                column(MargeBrut; MargeBrut)
                {

                }
                column(MargeNet; MargeNet)
                {

                }
                column(Marge2; Marge2)
                {

                }
                column(Marge3; Marge3)
                {

                }

                trigger OnAfterGetRecord()
                var

                    Customer: Record Customer;

                begin

                    if Customer.get("Sales Code") then;
                    SalesName := Customer.Name;
                    MargeBrut := FooterCostTotal * ExchangeRateAmt;//("Unit Price" - FooterCostTotal) / "Unit Price"; //FooterCostTotal; 
                    MargeNet := (FooterCostTotal + FooterProdTotalCost) * ExchangeRateAmt;//("Unit Price" - FooterCostTotal + FooterProdTotalCost) / "Unit Price"; //FooterCostTotal + FooterProdTotalCost;
                    Marge2 := ("Unit Price" * ExchangeRateAmt - TotaLastCost2) / ("Unit Price" * ExchangeRateAmt);
                    Marge3 := TotaLastCost2 + FooterProdTotalCost * ExchangeRateAmt;
                end;
            }



            trigger OnAfterGetRecord()
            var

            begin
                compTotalCost := 0;
                compProdTotalCost := 0;

                if "Lot Size" = 0 then
                    "Lot Size" := 1;

                if ("Production BOM No." = '') and
                   ("Routing No." = '')
                then
                    CurrReport.Skip();

                CostTotal := 0;

                PBOMNoList[1] := "Production BOM No.";

                if "Production BOM No." <> '' then
                    PBOMVersionCode[1] :=
                      VersionMgt.GetBOMVersion("Production BOM No.", CalculateDate, false);

                if "Routing No." <> '' then
                    RtngVersionCode := VersionMgt.GetRtngVersion("Routing No.", CalculateDate, false);

                SingleLevelMfgOvhd := "Single-Level Mfg. Ovhd Cost";

                FooterProdTotalCost := 0;
                FooterCostTotal := 0;
                TotaLastCost2 := 0;
                ExchangeRateDate := CalculateDate;
                GetLastestExchangeRate('EUR', ExchangeRateDate, ExchangeRateAmt); //wdc.sh
            end;

            trigger OnPreDataItem()
            begin
                ItemFilter := GetFilters();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CalculationDate; CalculateDate)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Calculation Date';
                        ToolTip = 'Specifies the specific date for which to get the cost list. The standard entry in this field is the working date.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            CalculateDate := WorkDate();
        end;
    }

    labels
    {
        ProdUnitCostCaption = 'Coût unitaire';
    }

    trigger OnInitReport()
    begin
        MfgSetup.Get();

    end;

    var
        Marge3: Decimal;
        Marge2: Decimal;
        compTotalCost: Decimal;
        compProdTotalCost: Decimal;
        SalesName: text;
        LastCost: Decimal;
        LastCostTotal: Decimal;
        TotaLastCost2: Decimal;
        ExchangeRateDate: date;
        ExchangeRateAmt: Decimal;
        MfgSetup: Record "Manufacturing Setup";
        CompItem: Record Item;
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: array[99] of Record "Production BOM Line";
        UOMMgt: Codeunit "Unit of Measure Management";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        VersionMgt: Codeunit VersionManagement;
        RtngVersionCode: Code[20];
        ItemFilter: Text;
        PBOMNoList: array[99] of Code[20];
        PBOMVersionCode: array[99] of Code[20];
        CompItemQtyBase: Decimal;
        Quantity: array[99] of Decimal;
        CalculateDate: Date;
        CostTotal: Decimal;
        ProdUnitCost: Decimal;
        ProdTotalCost: Decimal;
        CostTime: Decimal;
        InBOM: Boolean;
        InSalesPrice: Boolean;
        InRouting: Boolean;
        Level: Integer;
        NextLevel: Integer;
        SingleLevelMfgOvhd: Decimal;
        DirectUnitCost: Decimal;
        IndirectCostPct: Decimal;
        OverheadRate: Decimal;
        FooterProdTotalCost: Decimal;
        FooterCostTotal: Decimal;
        MargeNet: Decimal;
        MargeBrut: Decimal;

        /* Text000: Label 'As of ';
         CurrReportPageNoCaptLbl: Label 'Page';
         DetailedCalculationCaptLbl: Label 'Detailed Calculation';
         CostTimeCaptionLbl: Label 'Cost Time';
         ProdTotalCostCaptionLbl: Label 'Total Cost';
         ProdBOMLineLevelNoCaptionLbl: Label 'No.';
         ProdBOMLineLevelDescCaptLbl: Label 'Description';
         ProdBOMLineLevelQtyCaptLbl: Label 'Quantity (Base)';
         CostTotalCaptionLbl: Label 'Total Cost';
         ProdBOMLineLevelTypeCaptLbl: Label 'Type';
         CompItemBaseUOMCaptLbl: Label 'Base Unit of Measure Code';
         ProdTotalCostCaptLbl: Label 'Cost of Production';
         CostTotalCaptLbl: Label 'Cost of Components';
         SingleLevelMfgOvhdCaptionLbl: Label 'Single-Level Mfg. Overhead Cost';*/
        Text000: Label 'Dès ';
        CurrReportPageNoCaptLbl: Label 'Page';
        DetailedCalculationCaptLbl: Label 'Coût détaillé';
        CostTimeCaptionLbl: Label 'Temps unitaire';
        ProdTotalCostCaptionLbl: Label 'Coût total';
        ProdBOMLineLevelNoCaptionLbl: Label 'N°';
        ProdBOMLineLevelDescCaptLbl: Label 'Description';
        ProdBOMLineLevelQtyCaptLbl: Label 'Quantité (base)';
        CostTotalCaptionLbl: Label 'Coût total';
        ProdBOMLineLevelTypeCaptLbl: Label 'Type';
        CompItemBaseUOMCaptLbl: Label 'Code unité de base';
        ProdTotalCostCaptLbl: Label 'Coût de production';
        CostTotalCaptLbl: Label 'Coût des composants';
        SingleLevelMfgOvhdCaptionLbl: Label 'Frais gén. matière mono-niv.';


    procedure GetLastestExchangeRate(CurrencyCode: Code[10]; Date: Date; var Amt: Decimal)
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        //Date := 0D;
        Amt := 0;
        CurrencyExchangeRate.Reset();
        CurrencyExchangeRate.SetRange("Currency Code", CurrencyCode);
        CurrencyExchangeRate.SetFilter("Starting Date", '<=%1', Date);
        CurrencyExchangeRate.SetFilter("Exchange Rate Amount", '<>%1', 0);
        if CurrencyExchangeRate.FindLast() then begin
            //if CurrencyExchangeRate."Exchange Rate Amount" <> 0 then
            Amt := CurrencyExchangeRate."Relational Exch. Rate Amount" / CurrencyExchangeRate."Exchange Rate Amount";
        end;
    end;
}

