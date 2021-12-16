pageextension 50022 ExtendTransferOrderSubform extends "Transfer Order Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field(Postable; Rec.Postable)
            {
                ApplicationArea = All;
                Caption = 'Postable';
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