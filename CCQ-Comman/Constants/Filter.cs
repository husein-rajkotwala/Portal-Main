using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Comman.Constants
{
    public class Filter
    {
        #region Constructors

        public Filter(string fieldName, string fieldType, string fieldValue, string filterOperator)
        {
            this.FieldName = fieldName;
            this.FieldType = fieldType;
            this.FieldValue = fieldValue;
            this.FilterOperator = filterOperator;
        }

        #endregion

        #region Local Variables/Properties

        private string fieldName;

        public string FieldName
        {
            get { return fieldName; }
            set { fieldName = value; }
        }

        private string fieldType;

        public string FieldType
        {
            get { return fieldType; }
            set { fieldType = value; }
        }

        private string fieldValue;

        public string FieldValue
        {
            get { return fieldValue; }
            set { fieldValue = value; }
        }

        private string filterOperator;

        public string FilterOperator
        {
            get { return filterOperator; }
            set { filterOperator = value; }
        }


        #endregion

        #region Methods

        public string GetFilterStatement()
        {
            return @"<" + this.FilterOperator + @">
               <FieldRef Name='" + this.FieldName + @"' />
               <Value Type='" + this.FieldType + @"'>" + this.FieldValue + @"</Value>
            </" + this.FilterOperator + @">";
        }

        #endregion
    }
}
