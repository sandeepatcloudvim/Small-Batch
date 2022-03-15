codeunit 50000 EventSubcriber_SmallBatch
{
    Permissions = tabledata 17 = rimd, tabledata 5802 = rimd;


    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure UpdateIncomingDocumentForSale(var Rec: Record "Sales Header")
    var
        IncomingDoc: Record "Incoming Document";
        IncommingAttch: Record "Incoming Document Attachment";
        PostedSalesOrder: Record "Sales Invoice Header";
    begin
        PostedSalesOrder.Reset();
        PostedSalesOrder.SetRange("Order No.", Rec."No.");
        if PostedSalesOrder.FindFirst() then begin
            IncommingAttch.Reset();
            IncommingAttch.SetRange("Document No.", PostedSalesOrder."No.");
            if IncommingAttch.FindFirst() then begin
                IncomingDoc.Reset();
                IncomingDoc.SetRange("Entry No.", IncommingAttch."Incoming Document Entry No.");
                if IncomingDoc.FindFirst() then begin
                    IncomingDoc."Document No." := IncommingAttch."Document No.";
                    IncomingDoc.Posted := true;
                    IncomingDoc.Modify();
                end;
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure UpdateIncomingDocumentForPurch(var Rec: Record "Purchase Header")
    var
        IncomingDoc: Record "Incoming Document";
        IncommingAttch: Record "Incoming Document Attachment";
        PostedPurchOrder: Record "Purch. Inv. Header";
    begin
        PostedPurchOrder.Reset();
        PostedPurchOrder.SetRange("Order No.", Rec."No.");
        if PostedPurchOrder.FindFirst() then begin
            IncommingAttch.Reset();
            IncommingAttch.SetRange("Document No.", PostedPurchOrder."No.");
            if IncommingAttch.FindFirst() then begin
                IncomingDoc.Reset();
                IncomingDoc.SetRange("Entry No.", IncommingAttch."Incoming Document Entry No.");
                if IncomingDoc.FindFirst() then begin
                    IncomingDoc."Document No." := IncommingAttch."Document No.";
                    IncomingDoc.Posted := true;
                    IncomingDoc.Modify();
                end;
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeManualReleaseSalesDoc', '', false, false)]
    local procedure ManualReleaseSalesDoc(VAR SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader.TestField("Requested Ship Date");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDoc(VAR SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader.TestField("Requested Ship Date");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    local procedure UpdateOrderDate(VAR SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Create DATE" := Today;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', true, true)]
    local procedure UpdateOrderDate1(VAR PurchHeader: Record "Purchase Header")
    begin
        PurchHeader."Create DATE" := Today;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromCustLedgEntry', '', true, true)]
    local procedure CopyCustLedgEntry1(CustLedgerEntry: Record "Cust. Ledger Entry"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Source Name" := CustLedgerEntry."Customer Name";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure CopyFromPurchHeader1(PurchaseHeader: Record "Purchase Header"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Source Name" := PurchaseHeader."Pay-to Name";
        GenJournalLine."Create DATE" := PurchaseHeader."Create DATE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure CopyFromSalesHeader1(SalesHeader: Record "Sales Header"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Source Name" := SalesHeader."Bill-to Name";
        GenJournalLine."Create DATE" := SalesHeader."Create DATE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeaderPrepmt', '', true, true)]
    local procedure CopyFromPurchHeaderPrompt(PurchaseHeader: Record "Purchase Header"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Source Name" := PurchaseHeader."Pay-to Name";
        GenJournalLine."Create DATE" := PurchaseHeader."Create DATE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeaderPrepmtPost', '', true, true)]
    local procedure CopyFromPurchHeaderPrepmtPost(PurchaseHeader: Record "Purchase Header"; VAR GenJournalLine: Record "Gen. Journal Line"; UsePmtDisc: Boolean)
    begin
        GenJournalLine."Source Name" := PurchaseHeader."Pay-to Name";
        GenJournalLine."Create DATE" := PurchaseHeader."Create DATE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeaderPrepmt', '', true, true)]
    local procedure CopyFromSalesHeaderPrepmt(SalesHeader: Record "Sales Header"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Source Name" := SalesHeader."Bill-to Name";
        GenJournalLine."Create DATE" := SalesHeader."Create DATE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeaderPrepmtPost', '', true, true)]
    local procedure CopyFromSalesHeaderPrepmtPost(SalesHeader: Record "Sales Header"; VAR GenJournalLine: Record "Gen. Journal Line"; UsePmtDisc: Boolean)
    begin
        GenJournalLine."Source Name" := SalesHeader."Bill-to Name";
        GenJournalLine."Create DATE" := SalesHeader."Create DATE";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromServHeader', '', true, true)]
    local procedure CopyFromServiceHeader(ServiceHeader: Record "Service Header"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Source Name" := ServiceHeader."Bill-to Name";
    end;


    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure CopyFromGenJnlLine1(VAR GLEntry: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line")
    var
    begin
        GLEntry."Source Name" := GenJournalLine."Source Name";
        GLEntry."Create DATE" := GenJournalLine."Create DATE";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    local procedure UpdateSourceDetails(VAR SalesHeader: Record "Sales Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean)
    var
        GLEntry: Record "G/L Entry";
        recCustomer: Record Customer;
        recVendor: Record Vendor;

    begin
        GLEntry.SETRANGE("Document No.", SalesInvHdrNo);
        IF GLEntry.FINDFIRST THEN
            REPEAT
                if recCustomer.get(GLEntry."Source No.") then
                    GLEntry."Source Name" := recCustomer.Name
                ELSE
                    if recVendor.get(GLEntry."Source No.") then
                        GLEntry."Source Name" := recVendor.Name;
                GLEntry.MODIFY;
            UNTIL GLEntry.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', true, true)]
    local procedure UpdateSourceDetails1(VAR PurchaseHeader: Record "Purchase Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        GLEntry: Record "G/L Entry";
        recCustomer: Record Customer;
        recVendor: Record Vendor;

    begin
        GLEntry.SETRANGE("Document No.", PurchInvHdrNo);
        IF GLEntry.FINDFIRST THEN
            REPEAT
                if recCustomer.get(GLEntry."Source No.") then
                    GLEntry."Source Name" := recCustomer.Name
                ELSE
                    if recVendor.get(GLEntry."Source No.") then
                        GLEntry."Source Name" := recVendor.Name;
                GLEntry.MODIFY;
            UNTIL GLEntry.NEXT = 0;
    end;

    procedure GetExternalDocNo(DocNo: Code[20]): Text[50]
    var
        recAssembly: Record "Assembly Header";
    begin
        recAssembly.Reset();
        recAssembly.SetRange("No.", DocNo);
        if recAssembly.FindFirst() then
            exit(recAssembly."External Document No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptHeader', '', true, true)]
    local procedure UpdateShipmentReference(VAR TransferHeader: Record "Transfer Header"; VAR TransferShipmentHeader: Record "Transfer Shipment Header")
    var
    begin
        TransferShipmentHeader.Reference := TransferHeader.Reference;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', true, true)]
    local procedure UpdateShipmentReference1(VAR TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    var
    begin
        TransShptHeader.Reference := TransHeader.Reference;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterTransferOrderPostShipment', '', true, true)]
    local procedure UpdateShipmentReference2(VAR TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; VAR TransferShipmentHeader: Record "Transfer Shipment Header")
    var
    begin
        TransferShipmentHeader.Reference := TransferHeader.Reference;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnRunOnBeforeCommit', '', true, true)]
    local procedure UpdateShipmentReference3(VAR TransferHeader: Record "Transfer Header"; TransferShipmentHeader: Record "Transfer Shipment Header")
    var
    begin
        TransferShipmentHeader.Reference := TransferHeader.Reference;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptHeader', '', true, true)]
    local procedure UpdateReceiptReference(VAR TransRcptHeader: Record "Transfer Receipt Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; VAR Handled: Boolean)
    var
    begin
        TransRcptHeader.Reference := TransHeader.Reference;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransRcptHeaderInsert', '', true, true)]
    local procedure UpdateReceiptReference1(VAR TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    var
    begin
        TransferReceiptHeader.Reference := TransferHeader.Reference;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnBeforePostItemConsumption', '', true, true)]
    local procedure UpdateExternalDocNoToItemCons(VAR AssemblyHeader: Record "Assembly Header"; VAR AssemblyLine: Record "Assembly Line"; VAR ItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine."External Document No." := AssemblyHeader."External Document No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterCreateItemJnlLineFromAssemblyHeader', '', true, true)]
    local procedure UpdateExternalDocNoToItemJnlLine(VAR ItemJournalLine: Record "Item Journal Line"; AssemblyHeader: Record "Assembly Header")
    begin
        ItemJournalLine."External Document No." := AssemblyHeader."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterCreateItemJnlLineFromAssemblyLine', '', true, true)]
    local procedure UpdateExternalDocNoToItemJnlLine1(VAR ItemJournalLine: Record "Item Journal Line"; AssemblyLine: Record "Assembly Line")
    var

    begin
        ItemJournalLine."External Document No." := GetExternalDocNo(AssemblyLine."Document No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterCreateResJnlLineFromItemJnlLine', '', true, true)]
    local procedure UpdateExternalDocNoToResJournalLine(VAR ResJournalLine: Record "Res. Journal Line"; ItemJournalLine: Record "Item Journal Line"; AssemblyLine: Record "Assembly Line")
    begin
        ResJournalLine."External Document No." := ItemJournalLine."External Document No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterCreateWhseJnlLineFromItemJnlLine', '', true, true)]
    local procedure UpdateExternalDocNoToWhseJnlLine(VAR WarehouseJournalLine: Record "Warehouse Journal Line"; ItemJournalLine: Record "Item Journal Line")
    begin
        WarehouseJournalLine."External Document No." := ItemJournalLine."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnBeforePostItemConsumption', '', true, true)]
    local procedure UpdateExternalDocNo(VAR AssemblyHeader: Record "Assembly Header"; VAR AssemblyLine: Record "Assembly Line"; VAR ItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine."External Document No." := AssemblyHeader."External Document No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterCreateItemJnlLineFromAssemblyHeader', '', true, true)]
    local procedure UpdateExternalDoc(VAR ItemJournalLine: Record "Item Journal Line"; AssemblyHeader: Record "Assembly Header")
    begin
        ItemJournalLine."External Document No." := AssemblyHeader."External Document No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure UpdateExternalDocNoToILE(VAR NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."External Document No." := ItemJournalLine."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', true, true)]
    local procedure UpdateExternalDocNoToILE1(VAR ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgEntryNo: Integer; VAR ValueEntryNo: Integer; VAR ItemApplnEntryNo: Integer)
    begin
        ItemLedgerEntry."External Document No." := ItemJournalLine."External Document No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertCapValueEntry', '', true, true)]
    local procedure UpdateExternalDocNoToVE(VAR ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ValueEntry."External Document No." := ItemJnlLine."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', true, true)]
    local procedure UpdateExternalDocNoToVE1(VAR ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ValueEntryNo: Integer)
    begin
        ValueEntry."External Document No." := ItemJournalLine."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterPostItemJnlLine', '', true, true)]
    local procedure UpdateExternalDocNoToILE2(VAR ItemJournalLine: Record "Item Journal Line"; ItemLedgerEntry: Record "Item Ledger Entry"; VAR ValueEntryNo: Integer; VAR InventoryPostingToGL: Codeunit "Inventory Posting To G/L")
    begin
        ItemLedgerEntry."External Document No." := ItemJournalLine."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterFinishPosting', '', true, true)]
    local procedure UpdateExternalDocNoToGL(var GlobalGLEntry: Record "G/L Entry"; var GLRegister: Record "G/L Register"; var IsTransactionConsistent: Boolean; var GenJournalLine: Record "Gen. Journal Line")
    var
        GLentry: Record "G/L Entry";
        recGLentry: Record "G/L Entry";
        ExternalDoc: Text[50];
    begin

        recGLentry.Reset();
        recGLentry.SetRange("Document No.", GlobalGLEntry."Document No.");
        recGLentry.SetFilter("External Document No.", '<>%1', '');
        if recGLentry.FindFirst() then;

        GLentry.Reset();
        GLentry.SetRange("Document No.", GlobalGLEntry."Document No.");
        GLentry.SetFilter("External Document No.", '=%1', '');
        if GLentry.FindSet() then
            repeat
                GLentry."External Document No." := recGLentry."External Document No.";
                GLentry.Modify();
            until GLentry.Next() = 0;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly Line Management", 'OnAfterTransferBOMComponent', '', true, true)]
    local procedure UpdateTollingSubstitutions(var AssemblyLine: Record "Assembly Line"; BOMComponent: Record "BOM Component"; AssemblyHeader: Record "Assembly Header")
    var
        TollingSubstit: Record "CBR Tolling Substitutions";
        recResource: Record Resource;
    begin
        TollingSubstit.Reset();
        TollingSubstit.SetRange("Original Item No.", AssemblyLine."No.");
        TollingSubstit.SetRange("Location Code", AssemblyHeader."Location Code");
        if TollingSubstit.FindFirst() then begin
            recResource.Get(TollingSubstit."Substitute Item No.");
            AssemblyLine.Validate("No.", TollingSubstit."Substitute Item No.");
            AssemblyLine.Validate("Unit Cost", recResource."Unit Cost");
        end;

    end;

}