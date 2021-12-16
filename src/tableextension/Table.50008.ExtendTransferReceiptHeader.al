tableextension 50008 Extend_TransferRecptHeader_CBR extends "Transfer Receipt Header"
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