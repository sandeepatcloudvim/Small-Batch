pageextension 50007 ExtendPostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        addafter("No. Printed")
        {
            field("ShiptoName"; Rec."Ship-to Name")
            {
                ApplicationArea = All;
                Caption = 'Ship-to Name';
            }
            field("ShiptoContact"; Rec."Ship-to Contact")
            {
                ApplicationArea = aLL;
                Caption = 'Ship-to Contact';
            }
            field("ShiptoAddress"; Rec."Ship-to Address")
            {
                ApplicationArea = All;
                Caption = 'Ship-to Address';
            }
            field("ShiptoAddress 2"; Rec."Ship-to Address 2")
            {
                ApplicationArea = All;
                Caption = 'Ship-to Address 2';
            }
            field("ShiptoCity"; Rec."Ship-to City")
            {
                ApplicationArea = All;
                Caption = 'Ship-to City';
            }
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
                Caption = 'Ship-to State';
            }
            field("Ship-toCountryRegion Code"; Rec."Ship-to Country/Region Code")
            {
                ApplicationArea = All;
                Caption = 'Ship-to Country';
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                Caption = 'User';
            }
            field("Create DATE"; DT2DATE(Rec.SystemCreatedAt))
            {
                ApplicationArea = All;
                Caption = 'Create Date';
            }
        }
    }

    actions
    {
        addafter("&Invoice")
        {
            action("Item Sales History")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Sales History';
                RunObject = page "Item Sales History";
                Promoted = true;
                PromotedIsBig = true;
                Image = ViewPostedOrder;
                PromotedCategory = Process;
            }
            action("Sales Invoice Detail Page")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice Detail Page';
                Image = Invoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Sales Invoice Detail Page";
            }
        }
    }

    var
        myInt: Integer;
}