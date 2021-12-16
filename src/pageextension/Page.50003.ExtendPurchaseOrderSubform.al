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

    trigger OnAfterGetRecord()
    var
    begin
        if Rec.Quantity <> 0 then begin
            Rec."Amount to Receive" := Rec."Qty. to Receive" * Rec.GetUnitCost(Rec."No.");
        end;
        if Rec."Quantity Received" <> 0 then begin
            Rec."Amount Received" := Rec."Quantity Received" * Rec.GetUnitCost(Rec."No.");
        end;
        Rec.Modify();

    end;


}