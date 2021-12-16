tableextension 50012 ExtendIncomingDocument extends "Incoming Document"
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

    procedure CBRShowCard(DocumentNo: Code[20])
    begin
        RESET;
        SETRANGE("Document No.", DocumentNo);
        IF NOT FINDFIRST THEN
            EXIT;
        SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Document", Rec);
    end;

    procedure CBRShowCard_ILE(InvoiceNo: Code[20]; ItemNo: Code[20])
    begin
        RESET;
        SETRANGE("Document No.", InvoiceNo);
        SetRange("CBR Item No.", ItemNo);
        IF NOT FINDFIRST THEN
            EXIT;
        SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Document", Rec);
    end;

    procedure CBRShowCard_Transfer(DocumentNo: Code[20])
    begin
        RESET;
        SETRANGE("Document No.", DocumentNo);
        IF NOT FINDFIRST THEN
            EXIT;
        SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Document", Rec);
    end;

    procedure CBRShowCard_GLE(InvoiceNo: Code[20]; GLNo: Code[20])
    begin
        RESET;
        SETRANGE("Document No.", InvoiceNo);
        SetRange("CBR Item No.", GLNo);
        IF NOT FINDFIRST THEN
            EXIT;
        SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Document", Rec);
    end;


}