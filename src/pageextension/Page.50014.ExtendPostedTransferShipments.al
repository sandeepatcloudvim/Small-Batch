pageextension 50014 Extend_PostTransferShipts_CBR extends "Posted Transfer Shipments"
{
    layout
    {
        addafter("No.")
        {
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
                Caption = 'Transfer Order No.';
            }
            field(Reference; Rec.Reference)
            {
                ApplicationArea = All;
                Caption = 'Reference';
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