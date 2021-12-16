pageextension 50021 ExtendAssemblyOrderSubform extends "Assembly Order Subform"
{
    layout
    {
        addafter(Type)
        {
            field(Postable; Rec.Postable)
            {
                ApplicationArea = All;
                Caption = 'Postable';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}