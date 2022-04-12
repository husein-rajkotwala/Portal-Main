using Microsoft.SharePoint;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Comman.Constants
{
    public class Query
    {
        #region Constructors

        public Query(Operator logicOperator)
        {
            this.LogicOperator = logicOperator;
            this.filterCollection = new List<Filter>();
            this.fieldCollection = new List<string>();
            this.sortFieldCollection = new List<SortField>();
        }

        public Query(string configurationID)
        {
            //Initialize the Query object based on configuration somewhere
        }

        #endregion

        #region Local Variables/Properties

        internal List<Filter> filterCollection;

        internal List<string> fieldCollection;

        internal List<SortField> sortFieldCollection;

        private Operator logicOperator;

        public Operator LogicOperator
        {
            get { return logicOperator; }
            set { logicOperator = value; }
        }

        private NestedFilter nestedFilters;

        public NestedFilter NestedFilters
        {
            get { return nestedFilters; }
            set { nestedFilters = value; }
        }

        #endregion

        #region Methods

        /// <summary>
        /// returns the XML Caml query represented by current object
        /// </summary>
        /// <returns></returns>
        public string GetQueryStatement()
        {
            string queryStatement = null;
            string filter = Helper.GetFiltersStatement(this.filterCollection, this.logicOperator, this.nestedFilters);
            if (filter != "")
            {
                queryStatement = "<Where>" + filter + "</Where>";
            }
            queryStatement += GetSortFieldXml();
            return queryStatement;
        }

        public SPQuery GetSPQuery()
        {
            SPQuery query = new SPQuery();
            query.Query = GetQueryStatement();
            query.ViewFields = this.GetFieldXml();
            return query;
        }

        public SPQuery GetSPQueryLimit()
        {
            SPQuery query = new SPQuery();
            query.Query = GetQueryStatement();
            query.RowLimit = 4;
            query.ViewFields = this.GetFieldXml();
            return query;
        }

        public void AddFilter(Filter filter)
        {
            this.filterCollection.Add(filter);
        }

        public void AddFilters(Filter[] filters)
        {
            this.filterCollection.AddRange(filters);
        }

        public void AddFilter(string fieldName, string fieldType, string fieldValue, string filterOperator)
        {
            this.filterCollection.Add(new Filter(fieldName, fieldType, fieldValue, filterOperator));
        }

        public void AddFieldToReturn(string fieldName)
        {
            this.fieldCollection.Add(fieldName);
        }

        public void AddFieldsToReturn(string[] fieldNames)
        {
            this.fieldCollection.AddRange(fieldNames);
        }

      

        public void AddSortField(SortField sortField)
        {
            this.sortFieldCollection.Add(sortField);
        }

        public void AddSortFields(SortField[] sortFields)
        {
            this.sortFieldCollection.AddRange(sortFields);
        }

        private string GetFieldXml()
        {
            StringBuilder xml = new StringBuilder();
            foreach (string fld in this.fieldCollection)
            {
                xml.Append("<FieldRef Name='" + fld + "'/>");
            }
            return xml.ToString();
        }

        private string GetSortFieldXml()
        {
            StringBuilder xml = new StringBuilder();
            if (this.sortFieldCollection.Count > 0)
            {
                xml.Append("<OrderBy>");
                foreach (SortField fld in this.sortFieldCollection)
                {
                    string ascending = (fld.SortDirection == SortType.Ascending ? "True" : "False");
                    xml.Append("<FieldRef Name='" + fld.FieldName + "' Ascending='" + ascending + "'/>");
                }
                xml.Append("</OrderBy>");
            }
            return xml.ToString();
        }

        #region Configuration Based Methods

      

     

        #endregion

        #endregion        
    }
}
