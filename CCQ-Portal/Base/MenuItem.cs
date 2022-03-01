using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Portal.Base
{
    public class MenuItem
    {
        public string Title { get; set; }
        public string Parent { get; set; }
        public string URL { get; set; }
        public int DisplayOrder { get; set; }
        public bool IsActive { get; set; }
    }
}
