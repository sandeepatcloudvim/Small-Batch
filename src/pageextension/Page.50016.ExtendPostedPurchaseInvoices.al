pageextension 50016 ExtendPostedPurchaseInv extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("No. Printed")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                Caption = 'User';
            }
            field("Create DATE"; Rec."Create DATE")
            {
                ApplicationArea = All;
                Caption = 'Create Date';
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