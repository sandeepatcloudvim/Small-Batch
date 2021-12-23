pageextension 50029 ExtendItemCard extends "Item Card"
{
    layout
    {
        addafter("Unit Cost")
        {
            field(BomCostValue; BomCostValue)
            {
                ApplicationArea = All;
                Caption = 'BOM Cost';
                Editable = false;
                DecimalPlaces = 0 : 5;
            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        BomCost: Decimal;
        BomCost1: Decimal;
        BomCostValue: Decimal;
        BomComponent: Record "BOM Component";
        BomComponent1: Record "BOM Component";

    trigger OnAfterGetRecord()
    var
    begin
        Clear(BomCost);
        Clear(BomCost1);
        Clear(BomCostValue);
        Rec.CalcFields("Assembly BOM");
        if Rec."Assembly BOM" then begin
            BomComponent.Reset();
            BomComponent.SetRange("Parent Item No.", Rec."No.");
            if BomComponent.FindSet() then
                repeat
                    BomComponent.CalcFields("Assembly BOM");
                    if BomComponent."Assembly BOM" then begin
                        BomComponent1.Reset();
                        BomComponent1.SetRange("Parent Item No.", BomComponent."No.");
                        if BomComponent1.FindSet() then
                            repeat
                                BomCost1 := BomCost1 + (BomComponent."Quantity per" * (BomComponent1."Quantity per" * GetItemCost(BomComponent1."No.")));
                            until BomComponent1.Next() = 0;
                    end else begin
                        BomCost := BomCost + (BomComponent."Quantity per" * GetItemCost(BomComponent."No."));
                    end;
                until BomComponent.Next() = 0;

            BomCostValue := BomCost1 + BomCost;
        end;

    end;

    local procedure GetItemCost(BomItem: code[20]): Decimal
    var
        recItem: Record Item;
        recResource: Record Resource;
    begin
        if recItem.Get(BomItem) then begin
            exit(recItem."Unit Cost");
        end else
            if recResource.Get(BomItem) then begin
                exit(recResource."Unit Cost");
            end;
    end;
}