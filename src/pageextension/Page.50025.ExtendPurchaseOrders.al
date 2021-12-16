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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        AmountReceived: Decimal;

    trigger OnAfterGetRecord()
    var
        PostedPurchHeader: Record "Purch. Inv. Header";
    begin
        Clear(AmountReceived);
        PostedPurchHeader.Reset();
        PostedPurchHeader.SetRange("Order No.", Rec."No.");
        if PostedPurchHeader.FindSet() then
            repeat
                PostedPurchHeader.CalcFields("Amount Including VAT");
                AmountReceived := AmountReceived + PostedPurchHeader."Amount Including VAT";
            until PostedPurchHeader.Next() = 0;
    end;
}