pageextension 50002 ExtendItemList_CBR extends "Item List"
{
    layout
    {
        addafter(InventoryField)
        {
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Asm. Component"; Rec."Qty. on Asm. Component")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Item Reclassification Journal")
        {
            action("Master PSI")
            {
                ApplicationArea = All;
                Caption = 'Master PSI';
                Image = Print;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Master PSI CBR";
            }
        }
    }

    var
        myInt: Integer;


}