using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQDTO
{
   public class UserProfile
    {
        public string CCQMobileNumber { get; set; }
        public string CCQAlternateEmail { get; set; }
        public string MobileNumber { get; set; }
        public string Category { get; set; }

        public string currentApplication { get; set; }
        public string currentUser { get; set; }



    }
    public class UserProfileList
    {
        public List<UserProfile> UserProfile { get; set; }
    }
}
