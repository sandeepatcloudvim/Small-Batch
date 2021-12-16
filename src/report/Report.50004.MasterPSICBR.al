report 50004 "Master PSI CBR"
{

    DefaultLayout = RDLC;
    Caption = 'Master PSI';
    RDLCLayout = './MasterPSI.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(EntryNo_ItemLedgerEntry; "Item Ledger Entry"."Entry No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(Item_Description; recItem.Description)
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
            }
            column(RemainingQuantity_ItemLedgerEntry; "Item Ledger Entry"."Remaining Quantity")
            {
            }
            column(InvoicedQuantity_ItemLedgerEntry; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(SourceType_ItemLedgerEntry; "Item Ledger Entry"."Source Type")
            {
            }
            column(DropShipment_ItemLedgerEntry; "Item Ledger Entry"."Drop Shipment")
            {
            }
            column(TransactionType_ItemLedgerEntry; "Item Ledger Entry"."Transaction Type")
            {
            }
            column(DocumentDate_ItemLedgerEntry; "Item Ledger Entry"."Document Date")
            {
            }
            column(ExternalDocumentNo_ItemLedgerEntry; "Item Ledger Entry"."External Document No.")
            {
            }
            column(Qty_on_SO; recItem."Qty. on Sales Order")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if recItem.Get("Item Ledger Entry"."Item No.") then
                    recItem.CalcFields("Qty. on Sales Order");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        recItem: Record Item;
}

