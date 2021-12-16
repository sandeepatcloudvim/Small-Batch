pageextension 50007 ExtendPostedSalesInvoices extends "Posted Sales Invoices"
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
            field("Create DATE"; DT2DATE(Rec.SystemCreatedAt))
            {
                ApplicationArea = All;
                Caption = 'Create Date';
            }
        }
    }

    actions
    {
        addafter("&Invoice")
        {
            action("Item Sales History")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Sales History';
                RunObject = page "Item Sales History";
                Promoted = true;
                PromotedIsBig = true;
                Image = ViewPostedOrder;
                PromotedCategory = Process;
            }
        }
    }

    var
        myInt: Integer;
}