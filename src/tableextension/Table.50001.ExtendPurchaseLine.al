tableextension 50001 ExtendPurchaseLine extends "Purchase Line"
{
    fields
    {
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                recPurcLine: Record "Purchase Line";
            begin
                if Quantity <> 0 then begin
                    "Amount to Receive" := "Qty. to Receive" * "Direct Unit Cost";
                    "Amount to Invoice" := "Qty. to Invoice" * "Direct Unit Cost";
                end;
            end;

        }
        modify("Qty. to Receive")
        {
            trigger OnAfterValidate()
            var
            begin
                if Quantity <> 0 then begin
                    "Amount to Receive" := "Qty. to Receive" * "Direct Unit Cost";
                    "Amount to Invoice" := "Qty. to Receive" * "Direct Unit Cost";
                end;
            end;

        }

        modify("Quantity Received")
        {
            trigger OnAfterValidate()
            var
            begin
                if "Quantity Received" <> 0 then begin
                    "Amount Received" := "Quantity Received" * "Direct Unit Cost";
                    "Amount Invoiced" := "Quantity Received" * "Direct Unit Cost";
                end;

            end;
        }



        field(50000; "Amount Received"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Received';
            Editable = false;
        }
        field(50001; "Amount to Receive"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount to Receive';
            Editable = false;
        }
        field(50002; "Total Amount to Receive"; Decimal)
        {

            Caption = 'Total Amount to Receive';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Amount to Receive" WHERE("Document Type" = filter(Order), "Document No." = FIELD("Document No.")));

        }
        field(50003; "Total Amount Received"; Decimal)
        {

            Caption = 'Total Amount Received';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Amount Received" WHERE("Document Type" = filter(Order), "Document No." = FIELD("Document No.")));

        }
        field(50004; "Amount Invoiced"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Invoiced';
            Editable = false;
        }
        field(50005; "Amount to Invoice"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount to Invoice';
            Editable = false;
        }


    }

    var
        myInt: Integer;
        recResource: Record Resource;
        recItem: Record Item;

    procedure GetUnitCost(No: Code[20]): Decimal
    begin
        if recItem.Get(No) then begin
            exit(recItem."Unit Cost");
        end else
            if recResource.get(No) then begin
                exit(recResource."Unit Cost");
            end;

    end;
}