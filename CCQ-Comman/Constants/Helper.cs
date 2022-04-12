using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CCQ_Comman.Constants
{
    internal class Helper
    {
        internal static string GetFiltersStatement(List<Filter> filterCollection, Operator logicOper, NestedFilter nestedFilter)
        {
            StringBuilder xml = new StringBuilder();
            string oper = logicOper.ToString();//AND/OR
            int nbOfOperators = 0;
            if (filterCollection.Count > 0)
            {
                nbOfOperators += filterCollection.Count - 1;
            }
            //check if Nested filters is supplied
            bool hasNestedFilters = false;
            if (nestedFilter != null)
            {
                if (nestedFilter.filterCollection.Count > 0)
                {
                    nbOfOperators += 1;
                    hasNestedFilters = true;
                }
            }

            //build the collection of operators at the begin of the query : <And><And><And>....
            for (int i = 0; i < nbOfOperators; i++)
            {
                xml.Append("<" + oper + ">");
            }

            //append the first filter of the query
            if (filterCollection.Count > 0)
            {
                xml.Append(filterCollection[0].GetFilterStatement());
            }

            //append rest of filters of the query
            for (int i = 1; i < filterCollection.Count; i++)
            {
                xml.Append(filterCollection[i].GetFilterStatement());
                xml.Append("</" + oper + ">");
            }

            if (hasNestedFilters)
            {
                xml.Append(nestedFilter.GetFiltersStatement());
                xml.Append("</" + oper + ">");
            }
            return xml.ToString();
        }

        internal static string GetFilterValue(FindControlValueDelegate findControlValueMethod, Control parentCtrl, string valueType, string value)
        {
            string returnValue = "";

            switch (valueType)
            {
                case "Const":
                    {
                        returnValue = value;
                    }
                    break;
                case "UI":
                    {
                        returnValue = findControlValueMethod(parentCtrl, value);
                    }
                    break;
                case "Code":
                    {
                        switch (value)
                        {
                            //case "Today": returnValue = Common.GetSPDateFormat(DateTime.Today); break;
                        }
                    }
                    break;
            }

            return returnValue;
        }

        internal static string GetFilterOperator(FindControlValueDelegate findControlValueMethod, Control pageCtrl, string operType, string oper)
        {
            string returnValue = "";

            switch (operType)
            {
                case "Const":
                    {
                        returnValue = oper;
                    }
                    break;
                case "UI":
                    {
                        returnValue = findControlValueMethod(pageCtrl, oper);
                    }
                    break;
            }

            return returnValue;
        }

        internal static string FindControlValue(Control parent, string controlID)
        {
            string returnValue = "";

            Control ctrl = FindControl(parent, controlID);

            if (ctrl is TextBox)
            {
                TextBox txt = (TextBox)ctrl;
                returnValue = txt.Text;
            }
            else
                if (ctrl is DropDownList)
            {
                DropDownList ddl = (DropDownList)ctrl;
                if (ddl.SelectedValue != "-1")
                {
                    returnValue = ddl.SelectedValue;
                }
            }
            return returnValue;
        }

        internal static Control FindControl(Control parent, string controlID)
        {
            if (!parent.HasControls())
            {
                throw new CamlQueryException("Control '" + controlID + "' not found while trying to build CAML query based on dynamic configuration.");
            }
            Control ctrlToFind = parent.FindControl(controlID);
            if (ctrlToFind == null)
            {
                foreach (Control ctrl in parent.Controls)
                {
                    ctrlToFind = FindControl(ctrl, controlID);
                    if (ctrlToFind != null)
                    {
                        break;
                    }
                }
            }
            return ctrlToFind;
        }

        internal static void LoadFiltersFromDataRows(ref List<Filter> filterCollection, Control parentCtrl, DataRow[] rows, Operator logicOperator)
        {
            LoadFiltersFromDataRows(ref filterCollection, Helper.FindControlValue, parentCtrl, rows, logicOperator);
        }

        internal static void LoadFiltersFromDataRows(ref List<Filter> filterCollection, FindControlValueDelegate findControlValueMethod, Control parentCtrl, DataRow[] rows, Operator logicOperator)
        {
            foreach (DataRow dr in rows)
            {
                string fieldValue = Helper.GetFilterValue(findControlValueMethod, parentCtrl, dr["ValueType"].ToString(), dr["Value"].ToString());

                string compOperator = Helper.GetFilterOperator(findControlValueMethod, parentCtrl, dr["CompareOperatorType"].ToString(), dr["CompareOperator"].ToString());

                if (fieldValue != "")
                {
                    filterCollection.Add(new Filter(dr["ParameterName"].ToString(), dr["ParameterType"].ToString(), fieldValue, compOperator));
                }
            }
        }
    }
}
