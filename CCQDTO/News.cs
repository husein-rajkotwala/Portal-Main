using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQDTO
{
    public class News
    {
        public string TitleEn { get; set; }

        public string TitleAr { get; set; }

        public int SortOrder { get; set; }

        

    }
    public class NewsDetails
    {
        public string NewsTitleEn { get; set; }
        public string NewsTitleAr { get; set; }
        public List<NewsType> NewsType { get; set; }
       
    }
    public class NewsType
    {
        public string TitleEn { get; set; }

        public string TitleAr { get; set; }

        public string DescriptionEn { get; set; }

        public string DescriptionAr { get; set; }

        public string ImageEn { get; set; }

        public string ImageAr { get; set; }
        public string NewsTitle { get; set; }
        public int ID { get; set; }
        public int SortOrder { get; set; }

    }
}
