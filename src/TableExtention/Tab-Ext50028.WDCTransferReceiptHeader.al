tableextension 50028 WDCTransferReceiptHeader extends "Transfer Receipt Header"
{
    trigger OnDelete()
    begin
        Error('Vous ne pouvez pas supprimer une réception de transfert enregistrée.');
    end;
}
