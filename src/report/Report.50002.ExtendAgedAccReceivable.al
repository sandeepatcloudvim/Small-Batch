reportextension 50002 ExtendAgedAccReceivable_CBR extends "Aged Accounts Receivable NA"//10040
{
    dataset
    {
        add(Customer)
        {
            column(Email_Lbl; FieldCaption(Customer."E-Mail"))
            {

            }
            column(E_Mail_Value; Customer."E-Mail")
            {

            }

        }
    }

}