pageextension 50010 Extends_PurchaseOrder extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        moveafter(General; "Shipping and Payment")


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}