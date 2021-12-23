pageextension 50027 ExtendVendorList extends "Vendor List"
{
    layout
    {
        addafter("Payments (LCY)")
        {
            field("Payment Terms"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Payment Terms';
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