report 50051 "Update Transfer Postable"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Transfer Line"; "Transfer Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE(Quantity = FILTER(> 0));

            trigger OnAfterGetRecord()
            begin
                if Quantity <= GetItemQty("Transfer Line"."Item No.", "Transfer Line"."Transfer-from Code") then begin
                    Postable := TRUE;
                    Modify();
                end else begin
                    Postable := FALSE;
                    Modify();
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        recItem: Record Item;
        recILE: Record "Item Ledger Entry";

    procedure GetItemQty(Item: Code[20]; LocCode: Code[10]): Decimal
    begin
        recILE.Reset();
        recILE.SetRange("Item No.", Item);
        recILE.SetRange("Location Code", LocCode);
        recILE.SetFilter(Open, '%1', true);
        recILE.CalcSums(recILE."Remaining Quantity");
        exit(recILE."Remaining Quantity");
    end;
}

