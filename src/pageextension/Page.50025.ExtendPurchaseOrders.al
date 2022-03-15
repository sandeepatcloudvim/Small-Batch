pageextension 50025 Ext_PurchaseOrderList_CBR extends "Purchase Order List"
{
    layout
    {
        addbefore("Amount Received Not Invoiced (LCY)")
        {
            field(AmountReceived; AmountReceived)
            {
                ApplicationArea = All;
                Caption = 'Amount Received';

            }
            field(AmountToInvoice; AmountToInvoice)
            {
                ApplicationArea = All;
                Caption = 'Amount to Invoice';
            }
            field(AmountInvoiced; AmountInvoiced)
            {
                ApplicationArea = All;
                Caption = 'Amount Invoiced';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        AmountReceived: Decimal;
        AmountToInvoice: Decimal;
        AmountInvoiced: Decimal;

    trigger OnAfterGetRecord()
    var
        PostedPurchHeader: Record "Purch. Inv. Header";
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(AmountReceived);
        PostedPurchHeader.Reset();
        PostedPurchHeader.SetRange("Order No.", Rec."No.");
        if PostedPurchHeader.FindSet() then
            repeat
                PostedPurchHeader.CalcFields("Amount Including VAT");
                AmountReceived := AmountReceived + PostedPurchHeader."Amount Including VAT";
            until PostedPurchHeader.Next() = 0;

        Clear(AmountToInvoice);
        Clear(AmountInvoiced);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", Rec."No.");
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine."Qty. to Invoice" > 0 then
                    AmountToInvoice := AmountToInvoice + (PurchaseLine."Qty. to Invoice" * PurchaseLine."Unit Cost");
                if PurchaseLine."Qty. Invoiced (Base)" > 0 then
                    AmountInvoiced := AmountInvoiced + (PurchaseLine."Qty. Invoiced (Base)" * PurchaseLine."Unit Cost");
            until PurchaseLine.Next() = 0;

    end;
}