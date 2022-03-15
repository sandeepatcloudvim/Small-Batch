pageextension 50001 ExtendAssemblyOrders_CBR extends "Assembly Orders"
{
    layout
    {

        addbefore("Item No.")
        {
            field(Reference; Rec.Reference)
            {
                ApplicationArea = All;
                Caption = 'Reference';
            }
        }
        addbefore(Quantity)
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
            }
        }
        addafter(Quantity)
        {
            field("Wet Pound Weight"; Rec."Wet Pound Weight")
            {
                ApplicationArea = All;
                Caption = 'Wet Pound Weight';
            }
        }
    }

    actions
    {
        addafter(Dimensions)
        {
            action("Update Assembly Postable")
            {
                ApplicationArea = All;
                Caption = 'Update Assembly Postable';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Update Assembly Postable";
            }
        }
    }

    var
        myInt: Integer;



}