pageextension 50008 Extends_SalesOrder extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        moveafter(General; "Shipping and Billing")

        addafter("Promised Delivery Date")
        {
            field("Requested Ship Date"; Rec."Requested Ship Date")
            {
                ApplicationArea = All;
            }
        }

        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            var

            begin
                recordCount := 0;
                recShipToAddress.Reset();
                recShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                if not recShipToAddress.FindSet() then
                    exit
                else
                    if recShipToAddress.FindSet() then
                        repeat
                            recordCount := recordCount + 1;
                        until recShipToAddress.Next() = 0;

                if recordCount = 1 then begin
                    ShipToOptions := ShipToOptions::"Alternate Shipping Address";
                    Rec.UpdateAlternateShippingAddress(Rec."Sell-to Customer No.");
                    Rec.Modify(false);
                end else
                    if recordCount > 1 then begin
                        ShipToAddress.Reset();
                        ShipToAddress.Setrange("Customer No.", Rec."Sell-to Customer No.");
                        if ShipToAddress.FindSet() then begin
                            Commit();
                            IF Page.RunModal(301, ShipToAddress) = Action::LookupOK then begin

                                ShipToOptions := ShipToOptions::"Alternate Shipping Address";
                                Rec.VALIDATE("Ship-to Code", ShipToAddress.Code);
                                Rec.Modify(false);
                            end;
                        end;

                    end;
            end;

        }

    }

    actions
    {


    }

    var
        myInt: Integer;
        recShipToAddress: Record "Ship-to Address";
        ShipToAddress: Record "Ship-to Address";
        ShipToAddressList: page "Ship-to Address List";
        recordCount: Integer;
        FormatAddress: Codeunit "Format Address";
}