permissionset 50000 "GeneratedPermission"
{
    Permissions = tabledata "WDC Item Stage" = RIMD,
        tabledata "WDC SubCategory" = RIMD,
        table "WDC Item Stage" = X,
        table "WDC SubCategory" = X,
        report "WDC Bank Acc Trial Balance" = X,
        report "WDC Customer Det Trial Balance" = X,
        report "WDC Customer Trial Balance" = X,
        report "WDC G/L Detail Trial Balance" = X,
        report "WDC G/L Trial Balance" = X,
        report "WDC Grand Livre sur Excel" = X,
        report "WDC Posted Sales Invoice" = X,
        report "WDC Vendor Det Trial Bal FR" = X,
        report "WDC Vendor Trial Balance FR" = X,
        codeunit "DateFilter-Calc WDC" = X,
        codeunit "Fiscal Year-FiscalClose" = X,
        codeunit MontantTouteLettre = X,
        codeunit "Subscriber Wedata" = X,
        xmlport "WDC Import grand livre" = X,
        xmlport "WDC Import Stock" = X,
        page "WDC Item Stage" = X,
        page "WDC Page" = X,
        page "WDC SubCategory" = X,
        tabledata "WDC Item Mussel" = RIMD,
        table "WDC Item Mussel" = X,
        page "WDC Item Mussel" = X,
        tabledata "Border Code" = RIMD,
        tabledata "Exit Voucher Header" = RIMD,
        tabledata "Exit Voucher Lines" = RIMD,
        table "Border Code" = X,
        table "Exit Voucher Header" = X,
        table "Exit Voucher Lines" = X,
        xmlport "WDC Import Cout Standard" = X,
        page "Exit Voucher Lines" = X,
        page "Exit Voucher List PDR" = X,
        page "Exit Voucher PDR" = X,
        table "Posted Exit Voucher Header" = X,
        table "Posted Exit Voucher Lines" = X,
        page "Posted Exit Voucher Lines" = X,
        page "Posted Exit Voucher List PDR" = X,
        page "Posted Exit Voucher PDR" = X,
        page "WDC Border Code List" = X,
        tabledata Carton = RIMD,
        tabledata "Carton Tracking Lines" = RIMD,
        tabledata "Posted Exit Voucher Header" = RIMD,
        tabledata "Posted Exit Voucher Lines" = RIMD,
        table Carton = X,
        table "Carton Tracking Lines" = X,
        report "Detailed Calculation2" = X,
        report "WDC Exit Voucher PDR" = X,
        page "Carton Card" = X,
        page "Carton List" = X,
        page "Carton Tracking Lines" = X,
        page "Closed Carton Card" = X,
        page "Closed Carton List" = X,
        page "Closed Carton Track. Lines" = X,
        report "Update Item Ledger Entry" = X,
        report "WDC Prod. Order - Mat. Requis." = X,
        report WDCTransferOrderByProd = X,
        page "Carton to Post" = X,
        page "Carton Tracking List" = X,
        report "WDC Carton Ticket" = X,
        report "WDC Item Barcode" = X,
        report "WDC Lot Information" = X,
        report "WDC PF Ticket" = X,
        report "WDC Sales Invoice Proforma" = X,
        page "Update Destination Carton" = X,
        tabledata "Item Model" = RIMD,
        table "Item Model" = X,
        page "Model List" = X,
        report "WDC Packing List" = X,
        report "WDC Posted Sales Shipment" = X,
        report WDCDeleteLines = X,
        page "WDC Delete Package Line" = X,
        page "WDC Enter Customized SN" = X,
        page "WDC Production Declaration" = X,
        page WDCSerialNoInformationList = X;
}