page 50003 "Assembly Variance"
{
    PageType = List;
    Caption = 'Assembly Variance';
    SourceTable = "Item Ledger Entry";
    SourceTableView = SORTING("Entry No.")
                      ORDER(descending)
                      WHERE("Entry Type" = FILTER("Assembly Consumption"));
    ApplicationArea = Basic, Suite;
    DataCaptionFields = "Item No.";
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Entry';
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Assembly No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'RAW Item No';
                }
                field(Description; Itemrec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                }

                field("Finished Item No."; PostedAssemblyOrder."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Finished Item No.';
                }
                field("Finished Item Desc"; PostedAssemblyOrder.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Finished Item Desc';
                }
                field("Unit of Measure"; PostedAssemblyOrder."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Caption = 'Unit of Measure';
                }
                field("Sales Order No."; PostedAssemblyOrder."Sales Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order No.';
                }
                field("Customer No"; CustomerNo)
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                }
                field("Customer Name"; CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field(OriginalQty; OriginalQty)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Caption = 'BOM Qty';

                }
                field(RawQtyPlanned; RawQtyPlanned)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Caption = 'BOM RAW LBS';
                }
                field(RawCostPlanned; RawCostPlanned)
                {
                    ApplicationArea = All;
                    Caption = 'BOM RAW $';
                }
                field("Qty Assembled"; PostedAssemblyOrder.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'FINISHED QTY';
                }
                field(Quantity; Abs(Rec.Quantity))
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Caption = 'RAW LBS CONS';
                }
                field("Total Cost"; CostAmountActual)
                {
                    ApplicationArea = All;
                    Caption = 'RAW $ CONS';
                }
                field("Qty Variance"; Abs(RawQtyPlanned - Abs(Rec.Quantity)))
                {
                    ApplicationArea = All;
                    Caption = 'RAW LBS VARIANCE';
                }
                field("Cost Variance"; (RawCostPlanned - CostAmountActual))
                {
                    ApplicationArea = All;
                    Caption = 'RAW $ VARIANCE';
                }
                field(QtyVariancePer; QtyVariancePer)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 2;
                    Caption = 'RAW LBS % VARIANCE';
                }
                field(CostVariancePer; CostVariancePer)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 2;
                    Caption = 'COST VARIANCE %';
                }


            }
        }
    }

    actions
    {
    }
    var
        PostedAssemblyOrder: Record "Posted Assembly Header";
        recItem: Record Item;
        Itemrec: Record Item;
        ValueEntry: Record "Value Entry";
        BOMComponent: Record "BOM Component";
        RawQtyPlanned: Decimal;
        RawCostPlanned: Decimal;
        CostVariancePer: Decimal;
        QtyVariancePer: Decimal;
        CostAmountActual: Decimal;
        OriginalQty: Decimal;
        Qty1: Decimal;
        recSalesHeader: Record "Sales Header";
        CustomerNo: Code[20];
        CustomerName: Text[100];
        SalesHeaderArchive: Record "Sales Header Archive";



    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Cost Amount (Actual)");
        Clear(CostAmountActual);
        ValueEntry.Reset();
        ValueEntry.SetRange("Item Ledger Entry No.", Rec."Entry No.");
        ValueEntry.SetFilter(Adjustment, '%1', false);
        if ValueEntry.FindFirst() then begin
            CostAmountActual := Abs(ValueEntry."Cost Amount (Actual)");
        end;

        if Itemrec.Get(Rec."Item No.") then;

        if PostedAssemblyOrder.Get(Rec."Document No.") then begin
            PostedAssemblyOrder.CalcFields("Sales Order No.");

            Clear(CustomerNo);
            Clear(CustomerName);

            SalesHeaderArchive.Reset();
            SalesHeaderArchive.SetRange("Document Type", SalesHeaderArchive."Document Type"::Order);
            SalesHeaderArchive.SetRange("No.", PostedAssemblyOrder."Sales Order No.");
            if SalesHeaderArchive.FindFirst() then begin
                CustomerNo := SalesHeaderArchive."Sell-to Customer No.";
                CustomerName := SalesHeaderArchive."Sell-to Customer Name";
            end;


            if recSalesHeader.Get(recSalesHeader."Document Type"::Order, PostedAssemblyOrder."Sales Order No.") then;

            //OriginalQty := GetOriginallyQty(PostedAssemblyOrder."Order No.");  //AGT_SV

            if recItem.Get(PostedAssemblyOrder."Item No.") then begin
                recItem.CalcFields("Assembly BOM");
                if recItem."Assembly BOM" then begin
                    RawCostPlanned := 0;
                    RawQtyPlanned := 0;
                    CostVariancePer := 0;
                    QtyVariancePer := 0;

                    BOMComponent.Reset();
                    BOMComponent.SetRange(Type, BOMComponent.Type::Item);
                    BOMComponent.SetRange("Parent Item No.", recItem."No.");
                    BOMComponent.SetRange("No.", Rec."Item No.");
                    if BOMComponent.FindFirst() then begin
                        OriginalQty := BOMComponent."Quantity per";
                        RawQtyPlanned := BOMComponent."Quantity per" * PostedAssemblyOrder.Quantity;
                        RawCostPlanned := (BOMComponent."Quantity per" * PostedAssemblyOrder.Quantity) * GetUnitCost(BOMComponent."No.");

                        if (Abs(RawQtyPlanned - Abs(Rec.Quantity)) = 0) then begin
                            QtyVariancePer := 0.00;
                        end else begin
                            if RawQtyPlanned <> 0 then
                                QtyVariancePer := ((Abs(RawQtyPlanned - Abs(Rec.Quantity))) / RawQtyPlanned) * 100;
                        end;

                        if RawCostPlanned <> 0 then
                            CostVariancePer := (CostAmountActual) / RawCostPlanned;
                    end;
                end;
            end;
        end;
    end;

    local procedure GetUnitCost(ItemNo: Code[20]): Decimal
    var
        Itemrec: Record Item;
    begin
        if Itemrec.Get(ItemNo) then
            exit(Itemrec."Unit Cost");
    end;

    local procedure GetOriginallyQty(OrderNo: Code[20]): Decimal
    var
        recAssemblyOrder: Record "Assembly Header";
        recPostedAssembly: Record "Posted Assembly Header";
    begin
        if recAssemblyOrder.Get(recAssemblyOrder."Document Type"::Order, OrderNo) then
            Qty1 := recAssemblyOrder.Quantity
        else
            Qty1 := 0;

        recPostedAssembly.Reset();
        recPostedAssembly.SetRange("Order No.", OrderNo);
        if recPostedAssembly.FindSet() then begin
            recPostedAssembly.CalcSums(Quantity);
            OriginalQty := recPostedAssembly.Quantity + Qty1;
            exit(OriginalQty);
        end;


    end;
}

