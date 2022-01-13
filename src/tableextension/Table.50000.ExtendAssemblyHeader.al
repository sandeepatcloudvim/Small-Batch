tableextension 50000 Extend_AssemblyHeader_CBR extends "Assembly Header"
{
    fields
    {
        field(50000; "Reference"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference';
        }
        field(50001; "Wet Pound Weight"; Decimal)
        {

            Caption = 'Wet Pound Weight';
            CalcFormula = Sum("Assembly Line".Quantity WHERE("Document No." = FIELD("No."),
                                                              Type = FILTER(Item),
                                                              "Unit of Measure Code" = FILTER('LBS')));
            FieldClass = FlowField;

        }
        field(50002; "External Document No."; Code[50])
        {
            Caption = 'External Document No.';

        }
    }

    var
        myInt: Integer;
}