pageextension 50021 ExtendAssemblyOrderSubform extends "Assembly Order Subform"
{
    layout
    {
        addafter(Type)
        {
            field(Postable; Rec.Postable)
            {
                ApplicationArea = All;
                Caption = 'Postable';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        AssemblyPage1: Page "Assembly Order";
        TotalUnitCost: Decimal;

    // trigger OnAfterGetRecord()
    // var
    // begin
    //     UpdateUnitCostValue;
    // end;


    // procedure UpdateUnitCostValue()
    // var
    //     recAssemblyLine: Record "Assembly Line";
    //     recAsseemblyHeader: Record "Assembly Header";
    // begin
    //     Clear(TotalUnitCost);
    //     recAssemblyLine.Reset();
    //     recAssemblyLine.SetRange("Document Type", Rec."Document Type");
    //     recAssemblyLine.SetRange("Document No.", Rec."Document No.");
    //     if recAssemblyLine.FindSet()
    //     then
    //         repeat
    //             TotalUnitCost := TotalUnitCost + (recAssemblyLine."Quantity to Consume" * recAssemblyLine."Unit Cost");
    //         until recAssemblyLine.Next() = 0;

    //     if recAsseemblyHeader.Get(Rec."Document Type", Rec."Document No.") then begin
    //         recAsseemblyHeader.Validate("Unit Cost", TotalUnitCost);
    //         recAsseemblyHeader.Modify();
    //     end;

    // end;
}