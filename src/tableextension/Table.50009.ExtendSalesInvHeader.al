tableextension 50009 ExtendSalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        modify("Ship-to County")
        {
            Caption = 'Ship-to City';
        }
        field(50001; "Create DATE"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Create Date';
        }
        field(50002; "Credits Applied"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credits Applied';
        }
    }

    var
        myInt: Integer;
}