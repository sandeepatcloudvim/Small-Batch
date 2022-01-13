tableextension 50005 ExtendSalesHeader extends "Sales Header"
{
    fields
    {
        field(50000; "Requested Ship Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Ship Date';
            trigger OnValidate()
            begin
                if "Requested Delivery Date" <> 0D then
                    UpdatePlannedShipDate("No.", "Requested Ship Date");
            end;
        }
        field(50001; "Create DATE"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Create Date';
        }
        field(50002; "Credits Applied"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credits Applied';
        }


    }

    var
        myInt: Integer;

    local procedure UpdatePlannedShipDate(DocNo: Code[20]; RequestedShipDate: Date)
    var
        myInt: Integer;
        recSalesLine: Record "Sales Line";
    begin
        recSalesLine.Reset();
        recSalesLine.SetRange("Document Type", recSalesLine."Document Type"::Order);
        recSalesLine.SetRange("Document No.", DocNo);
        if recSalesLine.FindSet() then
            repeat
                recSalesLine."Planned Shipment Date" := RequestedShipDate;
                recSalesLine.Modify();
            until recSalesLine.Next() = 0;
    end;

    procedure UpdateAlternateShippingAddress(CustomerNo: Code[20])
    var
        ShipToAddr: Record "Ship-to Address";
    begin
        ShipToAddr.Reset();
        ShipToAddr.SetRange("Customer No.", CustomerNo);
        if ShipToAddr.FindFirst() then begin
            Rec.Validate(Rec."Ship-to Code", ShipToAddr.Code);
            Rec."Ship-to Name" := ShipToAddr.Name;
            Rec."Ship-to Name 2" := ShipToAddr."Name 2";
            Rec."Ship-to Address" := ShipToAddr.Address;
            Rec."Ship-to Address 2" := ShipToAddr."Address 2";
            Rec."Ship-to City" := ShipToAddr.City;
            Rec."Ship-to Post Code" := ShipToAddr."Post Code";
            Rec."Ship-to County" := ShipToAddr.County;
            VALIDATE(Rec."Ship-to Country/Region Code", ShipToAddr."Country/Region Code");
            Rec."Ship-to Contact" := ShipToAddr.Contact;
            IF ShipToAddr."Shipment Method Code" <> '' THEN
                VALIDATE(Rec."Shipment Method Code", ShipToAddr."Shipment Method Code");
            IF ShipToAddr."Location Code" <> '' THEN
                VALIDATE(Rec."Location Code", ShipToAddr."Location Code");
            Rec."Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
            Rec."Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
            IF ShipToAddr."Tax Area Code" <> '' THEN
                Rec."Tax Area Code" := ShipToAddr."Tax Area Code";
            Rec."Tax Liable" := ShipToAddr."Tax Liable";
            Rec.Modify();
        end;
    end;
}