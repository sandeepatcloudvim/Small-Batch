pageextension 50005 Extend_Transferrders_CBR extends "Transfer Orders"
{
    layout
    {
        addafter("No.")
        {
            field(Reference; Rec.Reference)
            {
                ApplicationArea = All;
                Caption = 'Reference';
            }
        }
    }

    actions
    {
        addafter(Dimensions)
        {
            action("Update Transfer Postable")
            {
                ApplicationArea = All;
                Caption = 'Update Transfer Postable';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Update Transfer Postable";
            }
        }
    }

    var
        myInt: Integer;
}