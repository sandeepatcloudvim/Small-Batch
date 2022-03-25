pageextension 50030 ExtendAssemblyBOM_CBR extends "Assembly BOM"
{
    PromotedActionCategories = 'New,Process,Report,Item,BOM,Tolling Substitutions';
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(AssemblyBOM)
        {
            group("Tolling Sub")
            {
                Caption = 'Tolling Substitutions';
                action("Tolling Substitutions")
                {
                    AccessByPermission = TableData "CBR Tolling Substitutions" = irdm;
                    ApplicationArea = Suite;
                    Caption = 'Tolling Substitutions';
                    Image = SelectItemSubstitution;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        TollingSubstit: Record "CBR Tolling Substitutions";
                        TollingSubstitutions: Page "Tolling Substitutions";
                    begin
                        if not (Rec.Type = Rec.Type::Resource) then
                            Message('Please select Resource for Tolling Substitutions');

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
    }

    var
        myInt: Integer;
}