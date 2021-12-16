pageextension 50019 ExtendItemJournal extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Get Standard Journals")
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
                        IncomingDocument.CBRShowCard_ILE(Rec."No.", Rec."Item No.");      //CBR_SS_29052018
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
                        IncomingDocumentAttachment.CBRNewAttachmentFromILE(Rec, Rec."Document No.", Rec."Item No.");//CBR_SS
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