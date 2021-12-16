tableextension 50014 ExtendAssemblyLine extends "Assembly Line"
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
                if Rec.Quantity <= GetItemQty(Rec."No.", Rec."Location Code") then
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