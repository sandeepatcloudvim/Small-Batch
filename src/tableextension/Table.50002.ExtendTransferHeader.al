tableextension 50002 Extend_TransferHeader_CBR extends "Transfer Header"
{
    fields
    {
        field(50000; "Reference"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference';
        }
        modify("Receipt Date")
        {
            trigger OnAfterValidate()
            var
            begin
                if "Receipt Date" <> 0D then
                    If Dialog.Confirm('Would you like to update all related Sales Order Lines ?', true) then
                        UpdateSalesReceiptDate("No.");

            end;
        }
    }
    var

    local procedure UpdateSalesReceiptDate(OrderNo: Code[20])
    var
        myInt: Integer;
        recSalesLine: Record "Sales Line";
    begin
        recSalesLine.Reset();
        recSalesLine.SetRange("Document Type", recSalesLine."Document Type"::Order);
        recSalesLine.SetRange("Transfer Order No.", OrderNo);
        if recSalesLine.FindSet() then
            repeat
                recSalesLine."Planned Shipment Date" := "Receipt Date";
                recSalesLine.Modify();
            until recSalesLine.Next() = 0;
    end;
}