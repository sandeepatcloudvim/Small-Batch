pageextension 50028 CBR_ExtendPostedAssemblyOrders extends "Posted Assembly Orders"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action("Assembly Variance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Assembly Variance';
                Promoted = true;
                PromotedIsBig = true;
                Image = AssemblyOrder;
                PromotedCategory = Process;
                RunObject = page "Assembly Variance";
            }
            action("Assembly Resource Variance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Assembly Resource Variance';
                Promoted = true;
                PromotedIsBig = true;
                Image = AssemblyOrder;
                PromotedCategory = Process;
                RunObject = page "Assembly Resource Variance";
            }
        }
    }

    var
        myInt: Integer;
}