table 50000 "CBR Item Sales History"
{
    DrillDownPageID = "Item Sales History";
    LookupPageID = "Item Sales History";

    fields
    {
        field(1; "Invoice No"; Code[20])
        {
        }
        field(2; "Original Sales Order No"; Code[20])
        {
        }
        field(3; "External Document No."; Code[35])
        {
        }
        field(4; "Customer No"; Code[20])
        {
        }
        field(5; "Salesperson Code"; Code[20])
        {
        }
        field(6; "Customer Name"; Text[100])
        {
        }
        field(7; "Bill-to Address"; Text[100])
        {
        }
        field(8; "Bill-to Address2"; Text[100])
        {
        }
        field(9; "Line No."; Integer)
        {
        }
        field(10; "Bill-to City"; Text[30])
        {
        }
        field(11; "Bill-to State"; Code[20])
        {
        }
        field(12; "Bill-to Zip"; Code[20])
        {
        }
        field(13; "Ship-to Address"; Text[100])
        {
        }
        field(19; "Document Date"; Date)
        {
        }
        field(20; "Posting Date"; Date)
        {
        }
        field(21; "Due date"; Date)
        {
        }
        field(22; "Payment Terms Code"; Code[10])
        {
        }
        field(25; "Shipping Agent Code"; Code[10])
        {
            Description = 'Carrier Code';
        }
        field(26; "Shipping Method Code"; Code[10])
        {
            Description = 'Shipping Carrier Method';
        }
        field(28; "Package Tracking No."; Text[30])
        {
        }
        field(31; "Item No."; Code[20])
        {
        }
        field(32; "Cross Reference No"; Code[20])
        {
        }
        field(33; "Item Description"; Text[200])
        {
        }
        field(34; "Unit of Measure Code"; Code[20])
        {
        }
        field(35; "Qty Invoiced"; Decimal)
        {
        }
        field(36; "Unit Price"; Decimal)
        {
        }
        field(37; "Extended Price"; Decimal)
        {
        }
        field(38; "Unit Cost (Invoice)"; Decimal)
        {
        }
        field(39; "Unit Cost (Item)"; Decimal)
        {
        }
        field(40; "Extended Cost"; Decimal)
        {
            Description = 'Extended Cost from Item Master timesd Qty';
        }
        field(41; "Location Code"; Code[20])
        {
        }
        field(42; "Manufacturer Code"; Code[20])
        {
        }
        field(43; "Vendor No"; Code[20])
        {
        }
        field(44; "Vendor Item No"; Code[20])
        {
        }
        field(45; "Item Category"; Code[20])
        {
        }
        field(46; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(47; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(48; "Error Description"; Text[75])
        {
        }
        field(49; "Customer Price Group"; Code[10])
        {
        }
        field(50; "Customer Disc. Group"; Code[20])
        {
        }
        field(51; "Margin Amount"; Decimal)
        {
        }
        field(52; "Ship-to Address2"; Text[100])
        {
        }
        field(53; "Ship-to City"; Text[30])
        {
        }
        field(54; "Ship-to State"; Code[20])
        {
        }
        field(55; "Ship-to Zip"; Code[20])
        {
        }
        field(56; "Total Weight"; Decimal)
        {

        }
        field(57; "Margin Percentage"; Decimal)
        {

        }
        field(58; "Trx Type"; Text[20])
        {

        }
        field(59; "Rev Acct No"; Code[20])
        {

        }
        field(60; "Create Date"; Date)
        {

        }
        field(61; "Qty Ordered"; Decimal)
        {

        }
        field(62; "Qty Variance %"; Decimal)
        {

        }
        field(63; "Ordered Amount"; Decimal)
        {

        }
        field(64; "COGS Acct No"; Code[20])
        {

        }

    }

    keys
    {
        key(Key1; "Invoice No", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }



    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        SinvLine: Record "Sales Invoice Line";
    begin
        SinvLine.Reset;
        SinvLine.SetRange("Document No.", "Invoice No");
        SinvLine.SetRange("Line No.", "Line No.");
        if SinvLine.FindFirst then;
    end;


    procedure UpdateItemHistory()
    var
        SalesInvHead: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCreditHeader: Record "Sales Cr.Memo Header";
        SalesCreditLine: Record "Sales Cr.Memo Line";
        ItemSalesHistory: Record "CBR Item Sales History";
    begin
        if not Confirm('Do you want to refresh data into Item Sales History Table, this action will delete all of the existing sales history lines and re-populate the data from posted Sales Invoice', false) then
            exit;
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

        Message('Completed Successfully');
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
            "Cross Reference No" := SInvLine."Item Reference No.";
            "Unit of Measure Code" := SInvLine."Unit of Measure Code";
            "Qty. per Unit of Measure" := SInvLine."Qty. per Unit of Measure";
            "Qty Ordered" := GetOriginalOrderedQty(SInvLine."Order No.", SInvLine."Order Line No.", SInvLine."No.");
            "Ordered Amount" := GetOriginalOrderedQty(SInvLine."Order No.", SInvLine."Order Line No.", SInvLine."No.") * (SInvLine."Unit Price");
            "Qty Invoiced" := SInvLine.Quantity;
            "Unit Price" := SInvLine."Unit Price";
            "Extended Price" := SInvLine.Quantity * "Unit Price";
            "Unit Cost (Item)" := Item."Unit Cost";
            "Unit Cost (Invoice)" := SInvLine."Unit Cost";
            // if Item."Unit Cost" > 0 then begin
            //     "Unit Cost (Item)" := Item."Unit Cost";
            //     "Extended Cost" := ((SInvLine.Quantity * SInvLine."Qty. per Unit of Measure") * Item."Unit Cost");
            // end else begin
            //"Unit Cost (Item)" := SInvLine."Unit Cost";
            if SInvLine."Unit Cost" > 0 then
                "Extended Cost" := ((SInvLine.Quantity * SInvLine."Qty. per Unit of Measure") * SInvLine."Unit Cost");
            // end;

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
            "Cross Reference No" := SCreditLine."Item Reference No.";
            "Unit of Measure Code" := SCreditLine."Unit of Measure Code";
            "Qty. per Unit of Measure" := SCreditLine."Qty. per Unit of Measure";
            "Qty Invoiced" := -(SCreditLine.Quantity);
            "Unit Price" := (SCreditLine."Unit Price");
            "Extended Price" := ("Qty Invoiced" * "Unit Price");
            "Unit Cost (Item)" := Item."Unit Cost";
            "Unit Cost (Invoice)" := SCreditLine."Unit Cost";
            // if Item."Unit Cost" > 0 then begin
            //     "Unit Cost (Item)" := Item."Unit Cost";
            //     "Extended Cost" := -((SCreditLine.Quantity * SCreditLine."Qty. per Unit of Measure") * Item."Unit Cost");
            // end else begin
            //     "Unit Cost (Item)" := SCreditLine."Unit Cost";
            if SCreditLine."Unit Cost" > 0 then
                "Extended Cost" := -((SCreditLine.Quantity * SCreditLine."Qty. per Unit of Measure") * SCreditLine."Unit Cost");
            //end;

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


    procedure AutoUpdateItemSalesLines(SalesInvLine: Record "Sales Invoice Line")
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        with SalesInvLine do begin
            SalesInvHeader.Get(SalesInvLine."Document No.");
            CreateLines(SalesInvHeader, SalesInvLine);
        end;
    end;

    procedure UpdateTotalWeight(ItemNo: Code[20]; UOM: Code[10]): Decimal
    var
        myInt: Integer;
        ItemUOM: Record "Item Unit of Measure";
    begin
        if ItemUOM.Get(ItemNo, UOM) then
            exit(ItemUOM.Weight);
    end;

    procedure GetOriginalOrderedQty(OrderNo: Code[20]; LineNo: Integer; ItemNo: Code[20]): Decimal
    var
        recSalesLine: Record "Sales Line";
        recSalesLineArchieve: Record "Sales Line Archive";
    begin
        recSalesLine.Reset();
        recSalesLine.SetRange("Document No.", OrderNo);
        recSalesLine.SetRange("Line No.", LineNo);
        if recSalesLine.FindFirst() then begin
            exit(recSalesLine.Quantity);
        end else begin
            recSalesLineArchieve.Reset();
            recSalesLineArchieve.SetRange("Document No.", OrderNo);
            recSalesLineArchieve.SetRange("Line No.", LineNo);
            if recSalesLineArchieve.FindFirst() then begin
                exit(recSalesLineArchieve.Quantity);
            end;
        end;
    end;

    procedure GetCOGSAccountNo(DocNo: Code[20]; Line: Integer): Code[20]
    var
        recValueEntry: Record "Value Entry";
        GLValueEntryLink: Record "G/L - Item Ledger Relation";
        GLEntry: Record "G/L Entry";
        xEntryNo: Integer;
    begin
        recValueEntry.RESET;
        recValueEntry.SETRANGE("Document No.", DocNo);
        recValueEntry.SETRANGE("Document Line No.", Line);
        IF recValueEntry.FINDSET THEN
            REPEAT
                GLValueEntryLink.Reset();
                GLValueEntryLink.SetRange("Value Entry No.", recValueEntry."Entry No.");
                if GLValueEntryLink.FindLast() then begin
                    if GLEntry.Get(GLValueEntryLink."G/L Entry No.") then
                        exit(GLEntry."G/L Account No.")
                    else
                        exit('');
                end;
            UNTIL recValueEntry.NEXT = 0;
    end;
}

