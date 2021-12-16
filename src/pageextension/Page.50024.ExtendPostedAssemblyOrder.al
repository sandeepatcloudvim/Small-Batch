pageextension 50024 Extend_PostedAssembly_CBR extends "Posted Assembly Order"
{
    layout
    {
        addafter("Assemble to Order")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
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