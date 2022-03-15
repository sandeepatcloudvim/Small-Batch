tableextension 50017 Extend_WhseJournalLine_CBR extends "Warehouse Journal Line"
{
    fields
    {
        field(50002; "External Document No."; Code[50])
        {
            Caption = 'External Document No.';

        }

    }

    var
        myInt: Integer;
}