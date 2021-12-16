tableextension 50010 ExtendPurchaseHeader extends "Purchase Header"
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