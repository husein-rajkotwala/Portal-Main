using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQDTO
{
    class CCQGoals
    {
    }
    public class GoalDetails
    {
        public string TitleEn { get; set; }
        public string TitleAr { get; set; }
        public string HtmlEn { get; set; }

        public string HtmlAr { get; set; }

        public List<GoalType> GoalType { get; set; }
    }
    public class GoalType
    {
        public string TitleEn { get; set; }

        public string TitleAr { get; set; }

      public string DescriptionEn { get; set; }
        public string DescriptionAr { get; set; }

        public int SortOrder { get; set; }

    }
}
