table 50001 "CBR Tolling Substitutions"
{
    Caption = 'Tolling Substitutions';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Tolling Substitutions";
    LookupPageID = "Tolling Substitutions";


    fields
    {
        field(1; "Original Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Original Item No.';
            TableRelation = Resource."No.";
        }
        field(2; "Substitute Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Substitute Item No.';
            TableRelation = Resource."No.";
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Original Item No.", "Substitute Item No.", "Location Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}