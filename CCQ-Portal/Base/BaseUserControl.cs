using CCQ_Comman.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;

namespace CCQ_Portal.Base
{
    public class BaseUserControl: UserControl
    {
        public BaseUserControl()
        {

        }
        public bool IsEnglish
        {
            get
            {
                return ActiveLanguage.Equals("en-us", StringComparison.InvariantCultureIgnoreCase);
            }
        }
        private string _activeLanguage;
        public string ActiveLanguage
        {
            get
            {
                if (string.IsNullOrEmpty(_activeLanguage))
                    _activeLanguage = Request.Cookies["lang"]?.Value ?? "en-US";
                ApiHelper.Language = _activeLanguage;
                return _activeLanguage;
            }
        }
    }
}
