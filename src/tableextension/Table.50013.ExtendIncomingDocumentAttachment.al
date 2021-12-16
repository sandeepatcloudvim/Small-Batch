tableextension 50013 ExtendIncomingDocumentAtt extends "Incoming Document Attachment"
{
    fields
    {
        field(50000; "CBR Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            Description = 'CBR_SS 26042018';
        }
    }

    var
        myInt: Integer;

    procedure CBRNewAttachmentFromILE(ItemJournal: Record "Item Journal Line"; DocumentNo: Code[20]; ItemNo: Code[20])
    var
        IncomingDocAttachment: Record "Incoming Document Attachment";
        IncomingDoc: Record "Incoming Document";
    begin

        NewAttachment;
        IF IncomingDoc.GET("Incoming Document Entry No.") THEN BEGIN
            IncomingDoc."Document No." := DocumentNo;
            IncomingDoc."CBR Item No." := ItemNo;
            IncomingDoc.MODIFY;
        END;
        IF IncomingDocAttachment.GET("Incoming Document Entry No.", "Line No.") THEN BEGIN
            IncomingDocAttachment."Document No." := DocumentNo;
            IncomingDocAttachment."CBR Item No." := ItemNo;
            IncomingDocAttachment.MODIFY;
        END;

    end;

    procedure CBRNewAttachmentFromTransfer(TransferOrder: Record "Transfer Header"; DocumentNo: Code[20])
    var
        IncomingDocAttachment: Record "Incoming Document Attachment";
        IncomingDoc: Record "Incoming Document";
    begin

        NewAttachment;
        IF IncomingDoc.GET("Incoming Document Entry No.") THEN BEGIN
            IncomingDoc."Document No." := DocumentNo;
            IncomingDoc.MODIFY;
        END;
        IF IncomingDocAttachment.GET("Incoming Document Entry No.", "Line No.") THEN BEGIN
            IncomingDocAttachment."Document No." := DocumentNo;
            IncomingDocAttachment.MODIFY;
        END;

    end;

    procedure CBRNewAttachmentFromGLE(GeneralJournal: Record "Gen. Journal Line"; DocumentNo: Code[20]; GLNo: Code[20])
    var
        IncomingDocAttachment: Record "Incoming Document Attachment";
        IncomingDoc: Record "Incoming Document";
    begin

        NewAttachment;
        IF IncomingDoc.GET("Incoming Document Entry No.") THEN BEGIN
            IncomingDoc."Document No." := DocumentNo;
            IncomingDoc."CBR Item No." := GLNo;
            IncomingDoc.MODIFY;
        END;
        IF IncomingDocAttachment.GET("Incoming Document Entry No.", "Line No.") THEN BEGIN
            IncomingDocAttachment."Document No." := DocumentNo;
            IncomingDocAttachment."CBR Item No." := GLNo;
            IncomingDocAttachment.MODIFY;
        END;

    end;
}