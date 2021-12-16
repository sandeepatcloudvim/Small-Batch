tableextension 50015 ExtendTransferLine extends "Transfer Line"
{
    fields
    {
        field(50000; "Postable"; Boolean)
        {
            Caption = 'Postable';
            DataClassification = CustomerContent;
            Editable = false;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
            begin
                if Rec.Quantity <= GetItemQty(Rec."Item No.", Rec."Transfer-from Code") then
                    Rec.Postable := true
                else
                    Rec.Postable := false;
            end;
        }
    }

    var
        myInt: Integer;
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