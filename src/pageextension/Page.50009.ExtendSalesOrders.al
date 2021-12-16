pageextension 50009 ExtendSalesOrderList extends "Sales Order List"
{
    layout
    {
        addafter("Document Date")
        {
            field("Requested Ship Date"; Rec."Requested Ship Date")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }

        }
        addafter("Amount Including VAT")
        {
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
        AmountInvoiced: Decimal;
        myInt: Integer;

    trigger OnAfterGetRecord()
    var
        recSalesLine: Record "Sales Line";
    begin
        Clear(AmountInvoiced);
        recSalesLine.Reset();
        recSalesLine.SetRange("Document Type", Rec."Document Type"::Order);
        recSalesLine.SetRange("Document No.", Rec."No.");
        recSalesLine.SetFilter("Quantity Invoiced", '>%1', 0);
        if recSalesLine.FindSet() then
            repeat
                AmountInvoiced := AmountInvoiced + (recSalesLine."Quantity Invoiced" * recSalesLine."Unit Price");
            until recSalesLine.Next() = 0;
    end;


}