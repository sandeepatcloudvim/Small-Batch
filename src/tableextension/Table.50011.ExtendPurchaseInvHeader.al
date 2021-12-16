tableextension 50011 ExtendPurchInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Create DATE"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Create Date';
        }
    }

    var
        myInt: Integer;
}