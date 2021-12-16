reportextension 50001 ExtendAssemblyOrder_CBR extends "Assembly Order" //902
{


    dataset
    {
        modify("Assembly Header")
        {
            CalcFields = "Wet Pound Weight";
        }
        add("Assembly Header")
        {
            column(Reference; Reference)
            {

            }
            column(Wet_Pound_Weight; "Wet Pound Weight")
            {
                DecimalPlaces = 0 : 5;
            }

        }
    }

}