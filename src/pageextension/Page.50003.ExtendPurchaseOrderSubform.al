pageextension 50003 ExtendPurcOrderSubform extends "Purchase Order Subform"
{
    layout
    {

        addafter("Quantity Received")
        {
            field("Amount to Receive"; Rec."Amount to Receive")
            {
                ApplicationArea = All;
                Caption = 'Amount to Receive';
                Editable = false;
            }
            field("Amount Received"; Rec."Amount Received")
            {
                ApplicationArea = All;
                Caption = 'Amount Received';
                Editable = false;

            }
            field("Amount to Invoice"; Rec."Amount to Invoice")
            {
                ApplicationArea = All;
                Caption = 'Amount to Invoice';
                Editable = false;
            }
            field("Amount Invoiced"; Rec."Amount Invoiced")
            {
                ApplicationArea = All;
                Caption = 'Amount Invoiced';
                Editable = false;
            }
        }
        addafter(AmountBeforeDiscount)
        {
            field("Total Amount to Receive"; Rec."Total Amount to Receive")
            {
                ApplicationArea = All;
                Caption = 'Total Amount to Receive';
                Editable = false;
            }

            field("Total Amount Received"; Rec."Total Amount Received")
            {
                ApplicationArea = All;
                Caption = 'Total Amount Received';
                Editable = false;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        AmountToInvoice: Decimal;
        AmountInvoiced: Decimal;

    trigger OnAfterGetRecord()
    var
        PostedPurchHeader: Record "Purch. Inv. Header";
        PurchaseLine: Record "Purchase Line";
    begin
        if Rec.Quantity <> 0 then begin
            Rec."Amount to Receive" := Rec."Qty. to Receive" * Rec."Direct Unit Cost";
            Rec."Amount to Invoice" := Rec."Qty. to Invoice" * Rec."Direct Unit Cost";
        end;
        if Rec."Quantity Received" <> 0 then begin
            Rec."Amount Received" := Rec."Quantity Received" * Rec."Direct Unit Cost";
            Rec."Amount Invoiced" := Rec."Quantity Invoiced" * Rec."Direct Unit Cost";
        end;

        Rec.Modify();

    end;


}