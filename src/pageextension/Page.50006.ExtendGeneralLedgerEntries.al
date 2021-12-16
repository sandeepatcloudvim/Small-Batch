pageextension 50006 ExtendGeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("Bal. Account Type")
        {

            field("Source Name"; Rec."Source Name")
            {
                ApplicationArea = All;
                Caption = 'Vendor / Customer Name';
            }
            field("UserID"; Rec."User ID")
            {
                ApplicationArea = All;
                Caption = 'USER';
            }
            field("Create DATE"; Rec."Create DATE")
            {
                ApplicationArea = All;
                Caption = 'Create Date';
            }

        }

    }

    actions
    {
        addafter("Value Entries")
        {
            action("Update Source Details")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                RunObject = report UpdateGLEntry;
            }
        }
    }

}