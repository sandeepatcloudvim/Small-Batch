pageextension 50020 ExtendRecurringGeneralJour extends "Recurring General Journal"
{
    layout
    {
        // Add changes to page layout here
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
                        IncomingDocument.CBRShowCard_GLE(Rec."Document No.", Rec."Account No.");      //CBR_SS_29052018
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
                        IncomingDocumentAttachment.CBRNewAttachmentFromGLE(Rec, Rec."Document No.", Rec."Account No.");  //CBR_SS
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
        IncDoc.SETRANGE("Document No.", Rec."Document No.");
        IF IncDoc.FINDFIRST THEN
            HasIncomingDocument := TRUE;
    end;
}