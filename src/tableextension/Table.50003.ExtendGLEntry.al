tableextension 50003 ExtendGLEntry extends "G/L Entry"
{
    fields
    {
        modify("Source No.")
        {
            Caption = 'Vendor / Customer ID';
        }
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