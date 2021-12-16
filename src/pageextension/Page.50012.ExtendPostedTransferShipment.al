pageextension 50012 Extend_PostedTransferShip_CBR extends "Posted Transfer Shipment"
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
        addafter("&Navigate")
        {
            group(CBRIncomingDocument)
            {
                Caption = 'Item Documents';
                Image = Attachments;

                action("CBR IncomingDocCard")
                {
                    ApplicationArea = All;
                    Caption = 'View File';
                    Image = ViewOrder;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.CBRShowCard_Transfer(Rec."Transfer Order No.");
                    end;

                }

            }
        }
    }

    var
        myInt: Integer;
}