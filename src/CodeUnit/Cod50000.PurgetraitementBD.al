// // codeunit 50000 "Purge traitement BD"
// {

//     trigger OnRun()
//     begin

//         IF NOT CONFIRM('Voulez vous purger la base') THEN
//             ERROR('Pas de purge');

//         IF NOT CONFIRM('Etes-vous sure de bien vouloir purger la base') THEN
//             ERROR('Pas de purge');

//         ClearTablePurgeTotal;

//         SalesHeaderArchive.RESET;
//         SalesHeaderArchive.DELETEALL;

//         SalesLineArchive.RESET;
//         SalesLineArchive.DELETEALL;

//         PurchaseHeadeArchive.RESET;
//         PurchaseHeadeArchive.DELETEALL;

//         PurchaseLineArchive.RESET;
//         PurchaseLineArchive.DELETEALL;



//         EcrCpte.RESET;
//         EcrCpte.DELETEALL;

//         EcrCli.RESET;
//         EcrCli.DELETEALL;

//         EcrFrn.RESET;
//         EcrFrn.DELETEALL;

//         EcrArt.RESET;
//         EcrArt.DELETEALL;

//         RecLiensEcritureVal.RESET;
//         RecLiensEcritureVal.DELETEALL;

//         LigVente.RESET;
//         LigVente.DELETEALL;

//         EnteteVente.RESET;
//         EnteteVente.DELETEALL;

//         LigAchat.RESET;
//         LigAchat.DELETEALL;

//         EnteteAchat.RESET;
//         EnteteAchat.DELETEALL;

//         HistoriqueCpte.RESET;
//         HistoriqueCpte.DELETEALL;

//         HistoriqueArticle.RESET;
//         HistoriqueArticle.DELETEALL;

//         CommentaireAchat.RESET;
//         CommentaireAchat.DELETEALL;

//         CommentaireVente.RESET;
//         CommentaireVente.DELETEALL;

//         LigFCpte.RESET;
//         LigFCpte.DELETEALL;

//         LigFArt.RESET;
//         LigFArt.DELETEALL;

//         EcrBudget.RESET;
//         EcrBudget.DELETEALL;

//         Commentaire.RESET;
//         Commentaire.DELETEALL;

//         LigExp.RESET;
//         LigExp.DELETEALL;

//         EnteteExp.RESET;
//         EnteteExp.DELETEALL;

//         LigFactVente.RESET;
//         LigFactVente.DELETEALL;

//         EnteteFactVente.RESET;
//         EnteteFactVente.DELETEALL;

//         LigAvoirVente.RESET;
//         LigAvoirVente.DELETEALL;

//         EnteteAvoirVente.RESET;
//         EnteteAvoirVente.DELETEALL;

//         LigRec.RESET;
//         LigRec.DELETEALL;

//         EnteteRec.RESET;
//         EnteteRec.DELETEALL;

//         LigFactAchat.RESET;
//         LigFactAchat.DELETEALL;

//         EnteteFactAchat.RESET;
//         EnteteFactAchat.DELETEALL;

//         LigAvoirAchat.RESET;
//         LigAvoirAchat.DELETEALL;

//         EnteteAvoirAchat.RESET;
//         EnteteAvoirAchat.DELETEALL;

//         LigDemandeAchat.RESET;
//         LigDemandeAchat.DELETEALL;

//         EcrTVA.RESET;
//         EcrTVA.DELETEALL;

//         Banque.RESET;
//         IF Banque.FIND('-') THEN BEGIN
//             Banque."Last Statement No." := ' ';
//             Banque."Balance Last Statement" := 0;
//         END;

//         EcrBanque.RESET;
//         EcrBanque.DELETEALL;

//         LigRappBanque.RESET;
//         LigRappBanque.DELETEALL;

//         RappBanque.RESET;
//         RappBanque.DELETEALL;

//         LigReleve.RESET;
//         LigReleve.DELETEALL;

//         Releve.RESET;
//         Releve.DELETEALL;

//         LigInventaire.RESET;
//         LigInventaire.DELETEALL;

//         EcrReservation.RESET;
//         EcrReservation.DELETEALL;

//         EcrDocReservation.RESET;
//         EcrDocReservation.DELETEALL;

//         EcrLettrageArt.RESET;
//         EcrLettrageArt.DELETEALL;

//         EcrCliDetail.RESET;
//         EcrCliDetail.DELETEALL;

//         EcrFrnDetail.RESET;
//         EcrFrnDetail.DELETEALL;

//         LigArchiveVente.RESET;
//         LigArchiveVente.DELETEALL;

//         EnteteArchiveVente.RESET;
//         EnteteArchiveVente.DELETEALL;

//         LigArchiveAchat.RESET;
//         LigArchiveAchat.DELETEALL;

//         EnteteArchiveAchat.RESET;
//         EnteteArchiveAchat.DELETEALL;

//         LigTransfert.RESET;
//         LigTransfert.DELETEALL;

//         EnteteTransfert.RESET;
//         EnteteTransfert.DELETEALL;

//         //Echeminement.RESET;
//         //Echeminement.DELETEALL;

//         LigExpTransf.RESET;
//         LigExpTransf.DELETEALL;

//         EnteteExpTransf.RESET;
//         EnteteExpTransf.DELETEALL;

//         LigRecTransf.RESET;
//         LigRecTransf.DELETEALL;

//         EnteteRecTransf.RESET;
//         EnteteRecTransf.DELETEALL;

//         LigCommentTransf.RESET;
//         LigCommentTransf.DELETEALL;

//         DemMagasin.RESET;
//         DemMagasin.DELETEALL;

//         LigAct.RESET;
//         LigAct.DELETEALL;

//         EnteteAct.RESET;
//         EnteteAct.DELETEALL;

//         Transbordement.RESET;
//         Transbordement.DELETEALL;

//         LigActEnreg.RESET;
//         LigActEnreg.DELETEALL;

//         EnteteActEnreg.RESET;
//         EnteteActEnreg.DELETEALL;

//         EcrValeur.RESET;
//         EcrValeur.DELETEALL;

//         FraisAchat.RESET;
//         FraisAchat.DELETEALL;

//         FraisVente.RESET;
//         FraisVente.DELETEALL;


//         DétailSN.RESET;
//         DétailSN.DELETEALL;

//         DétailLot.RESET;
//         DétailLot.DELETEALL;

//         CommentTraç.RESET;
//         CommentTraç.DELETEALL;


//         LigRetExp.RESET;
//         LigRetExp.DELETEALL;

//         EnteteRetExp.RESET;
//         EnteteRetExp.DELETEALL;

//         LigRetRec.RESET;
//         LigRetRec.DELETEALL;

//         EntetRetRec.RESET;
//         EntetRetRec.DELETEALL;



//         LigPrelevEnreg.RESET;
//         LigPrelevEnreg.DELETEALL;

//         PrevelEnreg.RESET;
//         PrevelEnreg.DELETEALL;

//         LigPrelev.RESET;
//         LigPrelev.DELETEALL;

//         Prelev.RESET;
//         Prelev.DELETEALL;

//         RecRequPrelev.RESET;
//         RecRequPrelev.DELETEALL;

//         LigExpedMagEnreg.RESET;
//         LigExpedMagEnreg.DELETEALL;

//         ExpedMagEnreg.RESET;
//         ExpedMagEnreg.DELETEALL;

//         LigExpedMag.RESET;
//         LigExpedMag.DELETEALL;

//         ExpedMag.RESET;
//         ExpedMag.DELETEALL;

//         LignTracabilite.RESET;
//         LignTracabilite.DELETEALL;

//         EcritureTracabilite.RESET;
//         EcritureTracabilite.DELETEALL;

//         DisponibiliteTracabili.RESET;
//         DisponibiliteTracabili.DELETEALL;

//         EcritureLienArt.RESET;
//         EcritureLienArt.DELETEALL;






//         Souche.RESET;
//         Souche.FIND('-');
//         REPEAT
//             Souche."Last No. Used" := '';
//             Souche."Last Date Used" := 0D;
//             Souche.MODIFY;
//         UNTIL Souche.NEXT = 0;
//         // ************************************************* Ajout  **************************************
//         // ***************************************************** 29/04/2006 *****************************************
//         // -*********************************************** Purge dernier coût et coût unitaire article*************

//         Article.RESET;
//         Article.FIND('-');
//         REPEAT
//             Article."Unit Cost" := 0;
//             Article."Last Direct Cost" := 0;
//             Article.MODIFY;
//         UNTIL Article.NEXT = 0;

//         // ********************************************** Purge Analyse par vue ***************************************
//         AnalysisView.RESET;
//         IF AnalysisView.FIND('-') THEN
//             REPEAT
//                 AnalysisView."Last Entry No." := 0;
//                 AnalysisView."Last Budget Entry No." := 0;
//                 AnalysisView."Last Date Updated" := TODAY;
//                 AnalysisView.MODIFY;
//             UNTIL AnalysisView.NEXT = 0;

//         AnalysisViewEntry.RESET;
//         AnalysisViewEntry.DELETEALL;

//         // ********************************************** Purge point de stock ****************************************
//         Pointstk.RESET;
//         IF Pointstk.FIND('-') THEN
//             REPEAT
//                 Pointstk."Unit Cost" := 0;
//                 Pointstk."Last Direct Cost" := 0;
//                 Pointstk.MODIFY;
//             UNTIL Pointstk.NEXT = 0;


//         ParamMag.GET;
//         ParamMag."Last Whse. Posting Ref. No." := 0;
//         ParamMag.MODIFY;

//         job.RESET;
//         job.DELETEALL;
//         //SDK ToDo.DELETEALL;
//         RecCost.DELETEALL;

//         Rec454.DELETEALL;
//         Rec455.DELETEALL;
//         Rec456.DELETEALL;
//         Rec457.DELETEALL;
//         Rec5823.DELETEALL;
//         Rec5811.DELETEALL;
//         RelationEcritureArticle.DELETEALL;
//         RecWarehouseReceiptLine.DELETEALL;
//         RecWarehouseReceiptHeader.DELETEALL;

//         Rec7318.DELETEALL;
//         Rec7319.DELETEALL;
//         Rec6509.DELETEALL;

//         RecG7312.DELETEALL;
//         RecGJobPlanningTask.DELETEALL;


//         //<<Ecriture Lien TVA
//         RecEcritureLienTVA.RESET;
//         RecEcritureLienTVA.DELETEALL;
//         //>>Ecriture Lien TVA
//         Rec10866.RESET;
//         Rec10866.DELETEALL;

//         Rec10865.RESET;
//         Rec10865.DELETEALL;
//         //<<Assemblage
//         RecAssemblageEntete.RESET;
//         RecAssemblageEntete.DELETEALL;
//         RecAssemblageLigne.RESET;
//         RecAssemblageLigne.DELETEALL;
//         RecAssembletoOrderLink.RESET;
//         RecAssembletoOrderLink.DELETEALL;
//         RecPostedAssemblyHeader.RESET;
//         RecPostedAssemblyHeader.DELETEALL;
//         RecPostedAssemblyLine.RESET;
//         RecPostedAssemblyLine.DELETEALL;
//         RecPostedAssembletoOrderLink.RESET;
//         RecPostedAssembletoOrderLink.DELETEALL;
//         RecInventoryAdjmtEntry.RESET;
//         RecInventoryAdjmtEntry.DELETEALL;
//         Rec5405.RESET;
//         Rec5405.DELETEALL;
//         Rec5406.RESET;
//         Rec5406.DELETEALL;
//         Rec5407.RESET;
//         Rec5407.DELETEALL;
//         Rec5409.RESET;
//         Rec5409.DELETEALL;
//         Rec5410.RESET;
//         Rec5410.DELETEALL;
//         Rec99000757.RESET;
//         Rec99000757.DELETEALL;


//         Rec5601.RESET;
//         Rec5601.DELETEALL;

//         Rec5832.RESET;
//         Rec5832.DELETEALL;

//         Rec405.RESET;
//         Rec405.DELETEALL;

//         Rec480.RESET;
//         Rec480.DELETEALL;

//         Rec481.RESET;
//         Rec481.DELETEALL;



//         MESSAGE('Traitement terminé');

//     end;

//     procedure ClearTablePurgeTotal()
//     Var
//         Vendor: Record 23;
//         GrpCompFou: Record 93;
//         Customer: Record 18;
//         GrpCompClient: Record 92;
//         GrpRemiseClient: Record 340;
//         Item: Record 27;
//         magasin: Record 14;
//         GrpCompStock: Record 94;
//         GrpCompPrdTVA: Record 324;
//         Banque: Record 270;
//         //>>
//         SalesPerson: Record 13;
//         ShippingAgent: Record 291;
//         Contact: Record 5050;
//         stockKeepingUnit: Record 5700;
//         opportunity: Record 5092;
//         opportunityLine: Record 5093;
//         WorkCenter: Record 99000754;
//         MachineCenter: Record 99000758;
//         ProductioBomHeader: Record 99000771;
//         ProductioBomLines: Record 99000772;
//         RoutingHeader: Record 99000763;
//         RoutingLines: Record 99000764;
//         //<<
//         Immo: Record 5600;
//         Assurance: Record 5628;

//         NonStockItem: Record 5718;

//         SrvHeader: Record 5900;
//         SrvItemLine: Record 5901;
//         SrvLine: Record 5902;
//         SrvorderType: Record 5903;
//         SrvItemGrp: Record 5904;
//         SrvCost: Record 5905;
//         SrvCommentLine: Record 5906;
//         SrvLedgerEntry: Record 5907;
//         SrvWarrantyLedgEntry: Record 5908;
//         SrvBuff: Record 5909;

//         SrvShelf: Record 5929;

//         SrvItem: Record 5940;
//         SrvItemComp: Record 5941;
//         SrvItemlog: Record 5942;

//         RessServiceZone: Record 5958;


//         ContratServLine: Record 5964;
//         ContratServ: Record 5965;
//         GrpContrat: Record 5966;
//         ContratChgLog: Record 5967;
//         ServicePriceGrp: Record 6080;
//     begin
//         ShippingAgent.reset;
//         ShippingAgent.DeleteAll;
//         Vendor.reset;
//         Vendor.DeleteAll;
//         GrpCompFou.Reset;
//         GrpCompFou.DeleteAll;
//         Customer.reset;
//         Customer.DeleteAll();
//         GrpCompClient.Reset;
//         GrpCompClient.DeleteAll();
//         GrpRemiseClient.Reset();
//         GrpRemiseClient.DeleteAll();
//         Item.Reset;
//         Item.DeleteAll();
//         magasin.Reset;
//         magasin.DeleteAll();
//         GrpCompStock.Reset;
//         GrpCompStock.DeleteAll();
//         GrpCompPrdTVA.Reset;
//         GrpCompPrdTVA.DeleteAll();
//         Banque.Reset;
//         Banque.DeleteAll();
//         Immo.Reset;
//         Immo.DeleteAll();
//         Assurance.Reset;
//         Assurance.DeleteAll();
//         NonStockItem.Reset;
//         NonStockItem.DeleteAll();
//         SrvHeader.Reset;
//         SrvHeader.DeleteAll();
//         SrvItemLine.Reset;
//         SrvItemLine.DeleteAll();
//         SrvLine.Reset;
//         SrvLine.DeleteAll();
//         SrvorderType.Reset;
//         SrvorderType.DeleteAll();
//         SrvItemGrp.Reset;
//         SrvItemGrp.DeleteAll();
//         SrvCost.Reset;
//         SrvCost.DeleteAll();
//         SrvCommentLine.Reset;
//         SrvCommentLine.DeleteAll();
//         SrvLedgerEntry.Reset;
//         SrvLedgerEntry.DeleteAll();
//         SrvWarrantyLedgEntry.Reset;
//         SrvWarrantyLedgEntry.DeleteAll();
//         SrvBuff.Reset;
//         SrvBuff.DeleteAll();

//         SrvShelf.Reset;
//         SrvShelf.DeleteAll();
//         SrvItem.Reset;
//         SrvItem.DeleteAll();
//         SrvItemComp.Reset;
//         SrvItemComp.DeleteAll();
//         SrvItemlog.Reset;
//         SrvItemlog.DeleteAll();
//         RessServiceZone.Reset;
//         RessServiceZone.DeleteAll();
//         ContratServLine.Reset;
//         ContratServLine.DeleteAll();
//         ContratServ.Reset;
//         ContratServ.DeleteAll();
//         GrpContrat.Reset;
//         GrpContrat.DeleteAll();
//         ContratChgLog.Reset;
//         ContratChgLog.DeleteAll();
//         ServicePriceGrp.Reset;
//         ServicePriceGrp.DeleteAll();
//         GrpCompClient.Reset;
//         GrpCompClient.DELETEALL;
//         GrpCompFou.Reset;
//         GrpCompFou.DELETEALL;
//         GrpRemiseClient.Reset;
//         GrpRemiseClient.DELETEALL;

//         SalesPerson.Reset;
//         SalesPerson.DELETEALL;
//         Contact.Reset;
//         Contact.DELETEALL;
//         stockKeepingUnit.Reset;
//         stockKeepingUnit.DELETEALL;
//         opportunity.Reset;
//         opportunity.DELETEALL;
//         opportunityLine.Reset;
//         opportunityLine.DELETEALL;
//         WorkCenter.Reset;
//         WorkCenter.DELETEALL;
//         MachineCenter.Reset;
//         MachineCenter.DELETEALL;
//         ProductioBomHeader.Reset;
//         ProductioBomHeader.DELETEALL;
//         ProductioBomLines.Reset;
//         ProductioBomLines.DELETEALL;
//         RoutingHeader.Reset;
//         RoutingHeader.DELETEALL;
//         RoutingLines.Reset;
//         RoutingLines.DELETEALL;
//     end;

//     var
//         Rec10866: record 10866;
//         Rec10865: record 10865;
//         EcrCpte: Record 17;
//         EcrCli: Record 21;
//         EcrFrn: Record 25;
//         EcrArt: Record 32;
//         LigVente: Record 37;
//         EnteteVente: Record 36;
//         LigAchat: Record 39;
//         EnteteAchat: Record 38;
//         HistoriqueCpte: Record 45;
//         HistoriqueArticle: Record 46;
//         CommentaireAchat: Record 43;
//         CommentaireVente: Record 44;
//         LigFCpte: Record 81;
//         RelationEcritureArticle: Record 5823;
//         LigFArt: Record 83;
//         EcrBudget: Record 96;
//         Commentaire: Record 97;
//         LigExp: Record 111;
//         EnteteExp: Record 110;
//         LigFactVente: Record 113;
//         EnteteFactVente: Record 112;
//         LigAvoirVente: Record 115;
//         EnteteAvoirVente: Record 114;
//         LigRec: Record 121;
//         EnteteRec: Record 120;
//         LigFactAchat: Record 123;
//         EnteteFactAchat: Record 122;
//         LigAvoirAchat: Record 125;
//         EnteteAvoirAchat: Record 124;
//         LigDemandeAchat: Record 246;
//         EcrTVA: Record 254;
//         EcrBanque: Record 271;
//         RappBanque: Record 273;
//         LigRappBanque: Record 274;
//         Releve: Record 275;
//         LigReleve: Record 276;
//         LigInventaire: Record 281;
//         EcrReservation: Record 337;
//         EcrDocReservation: Record 338;
//         EcrLettrageArt: Record 339;
//         EcrCliDetail: Record 379;
//         EcrFrnDetail: Record 380;
//         EnteteArchiveVente: Record 5107;
//         LigArchiveVente: Record 5108;
//         EnteteArchiveAchat: Record 5109;
//         LigArchiveAchat: Record 5110;
//         EnteteTransfert: Record 5740;
//         LigTransfert: Record 5741;
//         Echeminement: Record 5742;
//         EnteteExpTransf: Record 5744;
//         LigExpTransf: Record 5745;
//         EnteteRecTransf: Record 5746;
//         LigRecTransf: Record 5747;
//         LigCommentTransf: Record 5748;
//         DemMagasin: Record 5765;
//         EnteteAct: Record 5766;
//         LigAct: Record 5767;
//         Transbordement: Record 5768;
//         EnteteActEnreg: Record 5772;
//         LigActEnreg: Record 5773;
//         EcrValeur: Record 5802;
//         FraisAchat: Record 5805;
//         FraisVente: Record 5809;
//         DétailSN: Record 6504;
//         DétailLot: Record 6505;
//         CommentTraç: Record 6506;
//         EnteteRetExp: Record 6650;
//         LigRetExp: Record 6651;
//         EntetRetRec: Record 6660;
//         LigRetRec: Record 6661;
//         Souche: Record 309;
//         PrevelEnreg: Record 5772;
//         LigPrelevEnreg: Record 5773;
//         Prelev: Record 5766;
//         LigPrelev: Record 5767;
//         ExpedMagEnreg: Record 7322;
//         LigExpedMagEnreg: Record 7323;
//         ExpedMag: Record 7320;
//         LigExpedMag: Record 7321;
//         LignTracabilite: Record 336;
//         EcritureTracabilite: Record 32;
//         DisponibiliteTracabili: Record 338;
//         EcritureLienArt: Record 6507;
//         ParamMag: Record 5769;
//         RecRequPrelev: Record 7325;
//         RecLiensEcritureVal: Record 6508;
//         Article: Record 27;
//         AnalysisViewEntry: Record 365;
//         Pointstk: Record 5700;
//         AnalysisView: Record 363;
//         SalesHeaderArchive: Record 5107;
//         SalesLineArchive: Record 5108;
//         PurchaseHeadeArchive: Record 5109;
//         PurchaseLineArchive: Record 5110;
//         Banque: Record 270;
//         RecCost: Record 5804;
//         job: Record 167;
//         Rec454: Record 454;
//         Rec455: Record 455;
//         Rec456: Record 456;
//         Rec457: Record 457;
//         Rec5823: Record 5823;
//         Rec5811: Record 5811;
//         RecWarehouseReceiptHeader: Record 7316;
//         RecWarehouseReceiptLine: Record 7317;
//         Rec7318: Record 7318;
//         Rec7319: Record 7319;
//         Rec6509: Record 6509;
//         RecG7312: Record 7312;
//         RecGJobPlanningTask: Record 1003;
//         RecEcritureLienTVA: Record 253;
//         RecAssemblageEntete: Record 900;
//         RecAssemblageLigne: Record 901;
//         RecAssembletoOrderLink: Record 904;
//         RecPostedAssemblyHeader: Record 910;
//         RecPostedAssemblyLine: Record 911;
//         RecPostedAssembletoOrderLink: Record 914;
//         RecInventoryAdjmtEntry: Record 5896;
//         Rec5405: Record 5405;
//         Rec5406: Record 5406;
//         Rec5407: Record 5407;
//         Rec5409: Record 5409;
//         Rec5410: Record 5410;
//         Rec99000757: Record 99000757;
//         Rec5601: Record 5601;
//         Rec5600: Record 5600;
//         Rec5832: Record 5832;
//         Rec405: Record 405;
//         Rec480: Record 480;
//         Rec481: Record 481;
//         ItemUnitofMeasure: Record 5404;
//         ItemVariant: Record 5401;
//         itemledgerentry: Record 32;
//         SalesPrice: Record 7002;
//         RECENR: Record 122;
//         RECENRL: Record 123;
//         RETOUR: Record 6650;
//         RETOURL: Record 6651;
//         GLENTRY: Record 17;
//         VENDORLENTRY: Record 25;
//         SALESH: Record 36;
//         SALESL: Record 37;
//         PURCHH: Record 36;
//         PURCHL: Record 37;
//         GLREG: Record 45;
//         ITEMREG: Record 46;
//         GNJOURLINE: Record 81;
//         ITEMJOURLINE: Record 83;
//         AVGCOST: Record 5804;
//         PRRECEIPT: Record 120;
//         PRRECEIPTL: Record 121;

//         VENTRY: Record 5802;
//         CREDITMH: Record 124;
//         CREDITML: Record 125;

//         GLENVAT: Record 253;
//         POSTVENTRY: Record 5811;
//         GLITEMR: Record 5823;

//         //PurgeTable: Record 56002;
//         TableId: RecordRef;


// }

