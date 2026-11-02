tableextension 50027 WDCTransferShipmentHeader extends "Transfer Shipment Header"
{
    trigger OnDelete()
    begin
        Error('Vous ne pouvez pas supprimer une expédition de transfert enregistrée.');
    end;
}
