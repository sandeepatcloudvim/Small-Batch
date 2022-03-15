codeunit 50001 "Item Sales History Data"
{

    trigger OnRun()
    begin
        UpdateItemHistory;
    end;

    procedure UpdateItemHistory()
    var
        SalesInvHead: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCreditHeader: Record "Sales Cr.Memo Header";
        SalesCreditLine: Record "Sales Cr.Memo Line";
        ItemSalesHistory: Record "CBR Item Sales History";
    begin
        ItemSalesHistory.DeleteAll;

        SalesInvHead.Reset;
        if SalesInvHead.Find('-') then
            repeat
                if not IFItemSalesLinesExit(SalesInvHead) then begin
                    SalesInvLine.Reset;
                    SalesInvLine.SetRange("Document No.", SalesInvHead."No.");
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    if SalesInvLine.FindSet then
                        repeat
                            CreateLines(SalesInvHead, SalesInvLine);
                        until SalesInvLine.Next = 0;
                end;
            until SalesInvHead.Next = 0;

        SalesCreditHeader.Reset;
        if SalesCreditHeader.Find('-') then
            repeat
                if not IFItemSalesLinesExit1(SalesCreditHeader) then begin
                    SalesCreditLine.Reset;
                    SalesCreditLine.SetRange("Document No.", SalesCreditHeader."No.");
                    SalesCreditLine.SetRange(Type, SalesCreditLine.Type::Item);
                    if SalesCreditLine.FindSet then
                        repeat
                            CreateCreditLines(SalesCreditHeader, SalesCreditLine);
                        until SalesCreditLine.Next = 0;
                end;
            until SalesCreditHeader.Next = 0;

    end;

    procedure CreateLines(SInvHead: Record "Sales Invoice Header"; SInvLine: Record "Sales Invoice Line")
    var
        ItemSalesHistory: Record "CBR Item Sales History";
        Item: Record Item;
    begin

        with ItemSalesHistory do begin
            Init;
            "Invoice No" := SInvHead."No.";
            "Line No." := SInvLine."Line No.";
            "Trx Type" := 'Invoice';
            if not Item.Get(SInvLine."No.") then
                "Error Description" := 'Item No. :' + SInvLine."No." + ' ' + 'does not exist in the item table';
            "Original Sales Order No" := SInvHead."Order No.";
            "External Document No." := SInvHead."External Document No.";
            "Customer No" := SInvHead."Sell-to Customer No.";
            "Salesperson Code" := SInvHead."Salesperson Code";
            "Customer Name" := SInvHead."Sell-to Customer Name";
            "Bill-to Address" := SInvHead."Bill-to Address";
            "Bill-to Address2" := SInvHead."Bill-to Address 2";
            "Bill-to City" := SInvHead."Bill-to City";
            "Bill-to State" := SInvHead."Bill-to County";
            "Bill-to Zip" := SInvHead."Bill-to Post Code";

            "Ship-to Address" := SInvHead."Ship-to Address";
            "Ship-to Address2" := SInvHead."Ship-to Address 2";
            "Ship-to City" := SInvHead."Ship-to City";
            "Ship-to State" := SInvHead."Ship-to County";
            "Ship-to Zip" := SInvHead."Ship-to Post Code";
            "Create Date" := DT2DATE(SInvHead.SystemCreatedAt);

            "Document Date" := SInvHead."Document Date";
            "Posting Date" := SInvHead."Posting Date";
            "Due date" := SInvHead."Due Date";
            "Payment Terms Code" := SInvHead."Payment Terms Code";
            "Shipping Agent Code" := SInvHead."Shipping Agent Code";
            "Shipping Method Code" := SInvHead."Shipment Method Code";
            "Package Tracking No." := SInvHead."Package Tracking No.";
            "Customer Disc. Group" := SInvHead."Customer Disc. Group";
            "Customer Price Group" := SInvHead."Customer Price Group";
            "Item No." := SInvLine."No.";
            "Item Description" := SInvLine.Description;
            "Cross Reference No" := SInvLine."Cross-Reference No.";
            "Unit of Measure Code" := SInvLine."Unit of Measure Code";
            "Qty. per Unit of Measure" := SInvLine."Qty. per Unit of Measure";
            "Qty Ordered" := GetOriginalOrderedQty(SInvLine."Order No.", SInvLine."Order Line No.", SInvLine."No.");
            "Ordered Amount" := GetOriginalOrderedQty(SInvLine."Order No.", SInvLine."Order Line No.", SInvLine."No.") * (SInvLine."Unit Price");
            "Qty Invoiced" := SInvLine.Quantity;
            "Unit Price" := SInvLine."Unit Price";
            "Extended Price" := SInvLine.Quantity * "Unit Price";
            "Unit Cost (Invoice)" := SInvLine."Unit Cost";
            if Item."Unit Cost" > 0 then begin
                "Unit Cost (Item)" := Item."Unit Cost";
                "Extended Cost" := ((SInvLine.Quantity * SInvLine."Qty. per Unit of Measure") * Item."Unit Cost");
            end else begin
                "Unit Cost (Item)" := SInvLine."Unit Cost";
                "Extended Cost" := ((SInvLine.Quantity * SInvLine."Qty. per Unit of Measure") * SInvLine."Unit Cost");
            end;

            if UpdateTotalWeight(Item."No.", Item."Base Unit of Measure") <> 0 then
                "Total Weight" := (SInvLine.Quantity * UpdateTotalWeight(Item."No.", Item."Base Unit of Measure"));

            "Margin Amount" := "Extended Price" - "Extended Cost";

            if "Extended Price" <> 0 then
                "Margin Percentage" := "Margin Amount" / "Extended Price";
            "Location Code" := SInvHead."Location Code";
            "Item Category" := SInvLine."Item Category Code";
            "Manufacturer Code" := Item."Manufacturer Code";
            "Vendor No" := Item."Vendor No.";
            "Vendor Item No" := Item."Vendor Item No.";
            "COGS Acct No" := GetCOGSAccountNo(SInvLine."Document No.", SInvLine."Line No.");

            Insert;
        end
    end;

    procedure CreateCreditLines(SCreditHead: Record "Sales Cr.Memo Header"; SCreditLine: Record "Sales Cr.Memo Line")
    var
        ItemSalesHistory: Record "CBR Item Sales History";
        Item: Record Item;
    begin

        with ItemSalesHistory do begin
            Init;
            "Invoice No" := SCreditHead."No.";
            "Line No." := SCreditLine."Line No.";
            "Trx Type" := 'Credit Memo';
            if not Item.Get(SCreditLine."No.") then
                "Error Description" := 'Item No. :' + SCreditLine."No." + ' ' + 'does not exist in the item table';
            "External Document No." := SCreditHead."External Document No.";
            "Customer No" := SCreditHead."Sell-to Customer No.";
            "Salesperson Code" := SCreditHead."Salesperson Code";
            "Customer Name" := SCreditHead."Sell-to Customer Name";
            "Bill-to Address" := SCreditHead."Bill-to Address";
            "Bill-to Address2" := SCreditHead."Bill-to Address 2";
            "Bill-to City" := SCreditHead."Bill-to City";
            "Bill-to State" := SCreditHead."Bill-to County";
            "Bill-to Zip" := SCreditHead."Bill-to Post Code";

            "Ship-to Address" := SCreditHead."Ship-to Address";
            "Ship-to Address2" := SCreditHead."Ship-to Address 2";
            "Ship-to City" := SCreditHead."Ship-to City";
            "Ship-to State" := SCreditHead."Ship-to County";
            "Ship-to Zip" := SCreditHead."Ship-to Post Code";

            "Create Date" := DT2DATE(SCreditHead.SystemCreatedAt);
            "Document Date" := SCreditHead."Document Date";
            "Posting Date" := SCreditHead."Posting Date";
            "Due date" := SCreditHead."Due Date";
            "Payment Terms Code" := SCreditHead."Payment Terms Code";
            "Shipping Agent Code" := SCreditHead."Shipping Agent Code";
            "Shipping Method Code" := SCreditHead."Shipment Method Code";
            "Package Tracking No." := SCreditHead."Package Tracking No.";
            "Customer Disc. Group" := SCreditHead."Customer Disc. Group";
            "Customer Price Group" := SCreditHead."Customer Price Group";
            "Item No." := SCreditLine."No.";
            "Item Description" := SCreditLine.Description;
            "Cross Reference No" := SCreditLine."Cross-Reference No.";
            "Unit of Measure Code" := SCreditLine."Unit of Measure Code";
            "Qty. per Unit of Measure" := SCreditLine."Qty. per Unit of Measure";
            "Qty Invoiced" := -(SCreditLine.Quantity);
            "Unit Price" := (SCreditLine."Unit Price");
            "Extended Price" := ("Qty Invoiced" * "Unit Price");
            "Unit Cost (Invoice)" := SCreditLine."Unit Cost";
            if Item."Unit Cost" > 0 then begin
                "Unit Cost (Item)" := Item."Unit Cost";
                "Extended Cost" := -((SCreditLine.Quantity * SCreditLine."Qty. per Unit of Measure") * Item."Unit Cost");
            end else begin
                "Unit Cost (Item)" := SCreditLine."Unit Cost";
                "Extended Cost" := -((SCreditLine.Quantity * SCreditLine."Qty. per Unit of Measure") * SCreditLine."Unit Cost");
            end;

            if UpdateTotalWeight(Item."No.", Item."Base Unit of Measure") <> 0 then
                "Total Weight" := (SCreditLine.Quantity * UpdateTotalWeight(Item."No.", Item."Base Unit of Measure"));

            "Margin Amount" := "Extended Price" - "Extended Cost";

            if "Extended Price" <> 0 then
                "Margin Percentage" := "Margin Amount" / "Extended Price";
            "Location Code" := SCreditHead."Location Code";
            "Item Category" := SCreditLine."Item Category Code";
            "Manufacturer Code" := Item."Manufacturer Code";
            "Vendor No" := Item."Vendor No.";
            "Vendor Item No" := Item."Vendor Item No.";
            "COGS Acct No" := GetCOGSAccountNo(SCreditLine."Document No.", SCreditLine."Line No.");
            Insert;
        end
    end;

    procedure IFItemSalesLinesExit(SalesInvHead: Record "Sales Invoice Header"): Boolean
    var
        ItemSalesHistory: Record "CBR Item Sales History";
    begin
        ItemSalesHistory.Reset;
        ItemSalesHistory.SetRange("Invoice No", SalesInvHead."No.");
        if ItemSalesHistory.Count > 0 then
            exit(true)
        else
            exit(false)
    end;

    procedure IFItemSalesLinesExit1(SalesCreditHeader: Record "Sales Cr.Memo Header"): Boolean
    var
        ItemSalesHistory: Record "CBR Item Sales History";
    begin
        ItemSalesHistory.Reset;
        ItemSalesHistory.SetRange("Invoice No", SalesCreditHeader."No.");
        if ItemSalesHistory.Count > 0 then
            exit(true)
        else
            exit(false)
    end;

}