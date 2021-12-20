tableextension 50006 ExtendSalesLine extends "Sales Line"
{
    fields
    {
        field(50000; "Transfer Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transfer Order No.';
            TableRelation = "Transfer Line"."Document No." WHERE("Item No." = FIELD("No."));
        }
        field(50001; Status; Option)
        {

            Caption = 'Status';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header".Status WHERE("No." = FIELD("Document No.")));
        }

    }
}