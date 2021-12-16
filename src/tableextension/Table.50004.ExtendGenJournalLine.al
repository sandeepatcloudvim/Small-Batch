tableextension 50004 ExtendGenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Source Name"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor / Customer Name';
        }
        field(50001; "Create DATE"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Create Date';
        }
    }
}