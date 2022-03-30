using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQDTO
{
    public class FeedBackDTO
    {
    }
    public class FeedBack
    {
        public string Title { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public string Phone { get; set; }

        public string CategoryId { get; set; }

        public string Comments { get; set; }
        public string Subject { get; set; }
        public string DepartmentEmail { get; set; }
        public string DepartmentName { get; set; }


    }
}
