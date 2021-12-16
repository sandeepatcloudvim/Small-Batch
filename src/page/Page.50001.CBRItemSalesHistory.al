page 50001 "Item Sales History"
{

    Caption = 'Item Sales History';
    Editable = false;
    PageType = List;
    Permissions = TableData "Item Ledger Entry" = rimd,
                  TableData "Value Entry" = rimd;
    SourceTable = "CBR Item Sales History";
    SourceTableView = SORTING("Invoice No", "Line No.") ORDER(Ascending);


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                }
                field("Trx Type"; Rec."Trx Type")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Original Sales Order No"; Rec."Original Sales Order No")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to State"; Rec."Bill-to State")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Zip"; Rec."Bill-to Zip")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address2"; Rec."Ship-to Address2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to State"; Rec."Ship-to State")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Zip"; Rec."Ship-to Zip")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Due date"; Rec."Due date")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Method Code"; Rec."Shipping Method Code")
                {
                    ApplicationArea = All;
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("COGS Acct No"; Rec."COGS Acct No")
                {
                    ApplicationArea = All;
                    Caption = 'COGS Acct No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty Invoiced"; Rec."Qty Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Qty Ordered"; Rec."Qty Ordered")
                {
                    ApplicationArea = All;
                }
                field("Ordered Amount"; Rec."Ordered Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (Item)"; Rec."Unit Cost (Item)")
                {
                    ApplicationArea = All;
                }
                field("Extended Price"; Rec."Extended Price")
                {
                    ApplicationArea = All;
                }
                field("Extended Cost"; Rec."Extended Cost")
                {
                    ApplicationArea = All;
                }
                field("Margin Amount"; Rec."Margin Amount")
                {
                    ApplicationArea = All;
                }
                field("Margin Percentage"; Rec."Margin Percentage")
                {
                    ApplicationArea = All;
                    Caption = 'Margin %';
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Manufacturer Code"; Rec."Manufacturer Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No"; Rec."Vendor Item No")
                {
                    ApplicationArea = All;
                }
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                }
                field("Cross Reference No"; Rec."Cross Reference No")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }


            }
        }
        area(factboxes)
        {
            part(Control1000000005; "Lot Detail Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("Invoice No"),
                              "Item No." = FIELD("Item No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShoInvoice)
            {
                Caption = 'Show Invoice';
                Image = SalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    DocNo: Code[20];
                begin
                    if SalesInvHead.Get(Rec."Invoice No") then begin
                        PAGE.RunModal(PAGE::"Posted Sales Invoice", SalesInvHead)
                    end else
                        if SalesCreditHeader.Get(Rec."Invoice No") then begin
                            PAGE.RunModal(PAGE::"Posted Sales Credit Memo", SalesCreditHeader)
                        end;
                end;
            }

            action("Create Lines")
            {
                Caption = 'Refresh Data';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.UpdateItemHistory;
                end;
            }

        }
    }

    var
        SalesInvHead: Record "Sales Invoice Header";
        SalesCreditHeader: Record "Sales Cr.Memo Header";
        RecItem: Record Item;
        TotalPrice: Decimal;

    local procedure CheckValues()
    var
        SalesinvHeader: Record "Sales Invoice Header";
        SInvLine: Record "Sales Invoice Line";
        SalesCrMoHeader: Record "Sales Cr.Memo Header";
        SalesCrMoLine: Record "Sales Cr.Memo Line";
        DateFrom: Date;
        DateTo: Date;
        SInvTaxAmt: Decimal;
        SCrTaxAmt: Decimal;
        VATEntry: Record "VAT Entry";
        VatAmount: Decimal;
        DateFilter: Text;
    begin
        DateFrom := 20180101D;
        DateFrom := 20180531D;
        DateFilter := '01/01/18..07/31/18';
        SInvTaxAmt := 0;
        SCrTaxAmt := 0;

        SalesinvHeader.Reset;
        //SalesinvHeader.SETFILTER("Posting Date",DateFilter);
        if SalesinvHeader.Find('-') then
            repeat
                SInvTaxAmt := SInvTaxAmt + (SalesinvHeader."Amount Including VAT" - SalesInvHead.Amount);
            until SalesinvHeader.Next = 0;

        SalesCrMoHeader.Reset;
        //SalesCrMoHeader.SETFILTER("Posting Date",DateFilter);
        if SalesCrMoHeader.Find('-') then
            repeat
                SCrTaxAmt := SCrTaxAmt + (SalesCrMoHeader."Amount Including VAT" - SalesCrMoHeader.Amount);
            until SalesCrMoHeader.Next = 0;

        VATEntry.Reset;
        //VATEntry.SETFILTER("Posting Date",DateFilter);
        if VATEntry.FindFirst then
            repeat
                VatAmount := VatAmount + VATEntry.Amount;
            until VATEntry.Next = 0;


        Message('Total Tax Amount %1', SInvTaxAmt);
        Message('Total Sales Cr.Tax Amount %1', SCrTaxAmt);

        Message('Total VAT Amount %1', VatAmount);
    end;


}

