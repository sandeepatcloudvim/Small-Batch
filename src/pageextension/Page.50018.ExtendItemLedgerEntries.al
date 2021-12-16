pageextension 50018 ExtendItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Order Number"; Rec."Order No.")
            {
                ApplicationArea = All;
                Caption = 'Order No.';
            }
        }
        addafter("Entry No.")
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
                        IncomingDocument.CBRShowCard_ILE(Rec."Document No.", Rec."Item No.");
                    end;

                }

            }
        }
    }

    var
        myInt: Integer;
        HasIncomingDocument: Boolean;
        IncDoc: Record "Incoming Document";


}