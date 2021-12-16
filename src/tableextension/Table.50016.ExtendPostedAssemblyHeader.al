tableextension 50016 Extend_PostAssemblyHeader_CBR extends "Posted Assembly Header"
{
    fields
    {
        field(50002; "External Document No."; Code[50])
        {
            Caption = 'External Document No.';

        }
        field(50003; "Sales Order No."; Code[20])
        {

            Caption = 'Sales Order No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Assemble-to-Order Link"."Order No." WHERE("Assembly Document No." = FIELD("No.")));
        }
    }

    var
        myInt: Integer;
}