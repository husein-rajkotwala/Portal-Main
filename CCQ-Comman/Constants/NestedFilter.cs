using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;

namespace CCQ_Comman.Constants
{
    public class NestedFilter
    {
        #region Constructors

        public NestedFilter(Operator logicOperator)
        {
            this.LogicOperator = logicOperator;
            this.filterCollection = new List<Filter>();
        }

        #endregion

        #region Local Variables / Properties

        internal List<Filter> filterCollection;

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

        public string GetFiltersStatement()
        {
            return Helper.GetFiltersStatement(this.filterCollection, this.logicOperator, this.nestedFilters);
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

        #region Configuration Based Methods

        public void LoadFiltersFromDataRows(Control parentCtrl, DataRow[] rows, Operator logicOperator)
        {
            Helper.LoadFiltersFromDataRows(ref this.filterCollection, Helper.FindControlValue, parentCtrl, rows, logicOperator);
        }

        public void LoadFiltersFromDataRows(FindControlValueDelegate findControlValueMethod, Control parentCtrl, DataRow[] rows, Operator logicOperator)
        {
            Helper.LoadFiltersFromDataRows(ref this.filterCollection, findControlValueMethod, parentCtrl, rows, logicOperator);
        }

        #endregion

        #endregion
    }
}
