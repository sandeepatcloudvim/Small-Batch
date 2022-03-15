page 50007 "Tolling Substitutions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CBR Tolling Substitutions";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Original Item No."; Rec."Original Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Original Item No.';
                    Editable = false;
                }
                field("Substitute Item No."; Rec."Substitute Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Substitute Item No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}