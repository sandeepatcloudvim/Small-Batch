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
        addafter("Payment Discount %")
        {
            field("Credits Applied"; Rec."Credits Applied")
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

        addafter("Create Inventor&y Put-away/Pick")
        {
            action("Retrieve Credits")
            {
                ApplicationArea = All;
                Caption = 'Retrieve Credits';
                Promoted = true;
                PromotedCategory = Process;
                Image = TransferFunds;
                trigger OnAction()
                begin
                    UpdateCreditsAppliedValue(Rec."Sell-to Customer No.");
                end;
            }
        }
    }

    var
        myInt: Integer;
        recShipToAddress: Record "Ship-to Address";
        ShipToAddress: Record "Ship-to Address";
        ShipToAddressList: page "Ship-to Address List";
        recordCount: Integer;
        FormatAddress: Codeunit "Format Address";
        CreditAmount: Decimal;

    local procedure UpdateCreditsAppliedValue(CustomerNo: Code[20])
    var
        recCustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        Clear(CreditAmount);
        recCustLedgerEntry.Reset();
        recCustLedgerEntry.SetFilter("Document Type", '%1', recCustLedgerEntry."Document Type"::"Credit Memo");
        recCustLedgerEntry.SetRange("Customer No.", CustomerNo);
        if recCustLedgerEntry.FindSet() then
            repeat
                recCustLedgerEntry.CalcFields("Remaining Amount");
                CreditAmount := CreditAmount + Abs(recCustLedgerEntry."Remaining Amount");
            until recCustLedgerEntry.Next() = 0;
        Rec."Credits Applied" := CreditAmount;
        Rec.Modify();
    end;
}