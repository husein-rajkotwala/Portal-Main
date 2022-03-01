using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Comman.Helpers
{
    public class ApiHelper
    {
        private static string _language;

        public static string Language
        {
            get { return string.IsNullOrWhiteSpace(_language) ? "en" : _language; }
            set { _language = value; }
        }
    }
}
