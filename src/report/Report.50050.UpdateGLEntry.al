report 50050 UpdateGLEntry
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata 17 = rimd;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {

            trigger OnAfterGetRecord()
            var
                recVendor: Record Vendor;
                recCustomer: Record Customer;

            begin
                if "Source Type" = "Source Type"::Vendor then begin
                    if recVendor.get("Source No.") then
                        "Source Name" := recVendor.Name;
                end else
                    if "Source Type" = "Source Type"::Customer then begin
                        if recCustomer.get("Source No.") then
                            "Source Name" := recCustomer.Name;
                    end;
                Modify();
            end;

            trigger OnPostDataItem()
            begin
                Message('Data updated sucessfully');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}