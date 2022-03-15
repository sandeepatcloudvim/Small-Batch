pageextension 50000 ExtendAssemblyOrder_CBR extends "Assembly Order"
{
    layout
    {

        modify("Item No.")
        {
            ApplicationArea = All;
            LookupPageID = "Item Lookup Assembly CBR";

        }
        addafter("No.")
        {
            field(Reference; Rec.Reference)
            {
                ApplicationArea = All;
                Caption = 'Reference';
            }
        }
        addafter("Posting Date")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
            }
        }
        addafter("Quantity to Assemble")
        {
            field("Wet Pound Weight"; Rec."Wet Pound Weight")
            {
                ApplicationArea = All;
                Caption = 'Wet Pound Weight';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;



}