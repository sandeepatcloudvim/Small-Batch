pageextension 50004 Extend_Transferrder_CBR extends "Transfer Order"
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
        addafter("F&unctions")
        {
            group(CBRIncomingDocument)
            {
                Caption = 'Item Documents';
                Image = Attachments;

                action("CBR IncomingDocCard")
                {
                    ApplicationArea = All;
                    Caption = 'View File';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.CBRShowCard_Transfer(Rec."No.");
                    end;

                }
                action("CBR IncomingDocAttachFile")
                {
                    ApplicationArea = All;
                    Caption = 'Attach File';
                    Enabled = NOT HasIncomingDocument;
                    Ellipsis = true;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.CBRNewAttachmentFromTransfer(Rec, Rec."No.");
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
        HasIncomingDocument: Boolean;
        IncDoc: Record "Incoming Document";

    trigger OnAfterGetCurrRecord()
    begin
        CBRForIncomingDoc();
    end;

    local procedure CBRForIncomingDoc()
    begin
        IncDoc.RESET;
        IncDoc.SETRANGE("Document No.", Rec."No.");
        IF IncDoc.FINDFIRST THEN
            HasIncomingDocument := TRUE;
    end;


}