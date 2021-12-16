pageextension 50023 ExtendIncomingDocument extends "Incoming Document"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(SetToUnprocessed)
        {
            action(Unposted)
            {
                ApplicationArea = All;
                Caption = 'Unposted';
                trigger OnAction()
                var
                begin
                    if Rec.Posted = true then begin
                        Rec.Posted := false;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}