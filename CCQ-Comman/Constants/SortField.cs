using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Comman.Constants
{
    public class SortField
    {
        #region Constructors

        public SortField(string fieldName, SortType sortDirection)
        {
            this.FieldName = fieldName;
            this.SortDirection = sortDirection;
        }

        #endregion

        #region Local Variables / Properties

        private string fieldName;

        public string FieldName
        {
            get { return fieldName; }
            set { fieldName = value; }
        }

        private SortType sortDirection;

        public SortType SortDirection
        {
            get { return sortDirection; }
            set { sortDirection = value; }
        }

        #endregion
    }
}
