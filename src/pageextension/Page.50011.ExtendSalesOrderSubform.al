pageextension 50011 ExtendSalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}