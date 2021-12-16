tableextension 50009 ExtendSalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50001; "Create DATE"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Create Date';
        }
    }

    var
        myInt: Integer;
}