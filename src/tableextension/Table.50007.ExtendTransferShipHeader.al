tableextension 50007 Extend_TransferShipHeader_CBR extends "Transfer Shipment Header"
{
    fields
    {
        field(50000; "Reference"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference';
        }
    }
}