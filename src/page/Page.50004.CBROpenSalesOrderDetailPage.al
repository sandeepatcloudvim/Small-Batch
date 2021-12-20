page 50006 "Open Sales Order Detail Page"
{
    Editable = false;
    Caption = 'Open Sales Order Detail Page';
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order No.';
                }

                field("Customer ID"; RecSalesHead."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                }
                field("Customer Name"; RecCust.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field("Order Date"; RecSalesHead."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Order Date';
                }
                field(Address; RecSalesHead."Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                field(City; RecSalesHead."Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
                field(State; RecSalesHead."Ship-to County")
                {
                    ApplicationArea = All;
                    Caption = 'State';
                }
                field(Postcode; RecSalesHead."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Post Code';
                }
                field(CountryRegionCode; RecSalesHead."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country/Region Code';
                }
                field(ExternalDocumentNo; RecSalesHead."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'External Document No.';
                }
                field(RequestedDeliveryDate; RecSalesHead."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Caption = 'Requested Delivery Date';
                }
                field(RequestedShipDate; RecSalesHead."Requested Ship Date")
                {
                    ApplicationArea = All;
                    Caption = 'Requested Ship Date';
                }
                field(Item; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No';
                }
                field("Item Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                }

                field(Qty; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Qty of Order';
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Price';
                }
                field("Total Value"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Extended Price';
                }

            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    var
    begin
        Rec.CalcFields(Status);
        Rec.SetFilter(Status, '%1', Rec.Status::Open);
    end;

    trigger OnAfterGetRecord()
    begin
        if RecSalesHead.Get(Rec."Document Type", Rec."Document No.") then;
        if RecItem.Get(Rec."No.") then;
        if RecCust.Get(Rec."Sell-to Customer No.") then;
    end;

    var
        RecCust: Record Customer;
        RecSalesHead: Record "Sales Header";
        RecItem: Record Item;
        LineNo: Integer;
        RecVariant: Record "Item Variant";
        RemQtytoship: Decimal;
        RemValue: Decimal;


}

