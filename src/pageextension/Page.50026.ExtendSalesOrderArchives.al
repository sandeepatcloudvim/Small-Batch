pageextension 50026 ExtendSalesOrderArchives extends "Sales Order Archives"
{
    layout
    {
        addafter("External Document No.")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
                Caption = 'Order Total';
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