pageextension 50030 ExtendAssemblyBOM_CBR extends "Assembly BOM"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Show BOM")
        {
            action("Tolling Substitutions")
            {
                AccessByPermission = TableData "CBR Tolling Substitutions" = irdm;
                ApplicationArea = Suite;
                Caption = 'Tolling Substitutions';
                Image = SelectItemSubstitution;
                trigger OnAction()
                var
                    TollingSubstit: Record "CBR Tolling Substitutions";
                    TollingSubstitutions: Page "Tolling Substitutions";
                begin
                    if Rec.Type = Rec.Type::Resource then begin
                        TollingSubstit.SetCurrentKey("Original Item No.");
                        TollingSubstit.SetRange("Original Item No.", Rec."No.");
                        TollingSubstitutions.SetTableView(TollingSubstit);
                        TollingSubstitutions.Run();
                    end;

                end;
            }
        }
    }

    var
        myInt: Integer;
}