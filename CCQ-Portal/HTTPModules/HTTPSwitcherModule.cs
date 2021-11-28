using Microsoft.SharePoint.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace CCQ_Portal.HTTPModules
{

    public class HTTPSwitcherModule : IHttpModule
    {
        public void Init(HttpApplication context)
        {
            context.PreRequestHandlerExecute += context_PreRequestHandlerExecute;
        }

        void context_PreRequestHandlerExecute(object sender, EventArgs e)
        {
            HttpApplication HttpApp = sender as HttpApplication;

            HttpContext Context = HttpApp.Context;
            string StringLanguage = string.Empty;
            string StringKeyName = "lang";

            try
            {
                if (HttpApp.Request.Cookies[StringKeyName] != null)
                    StringLanguage = HttpApp.Request.Cookies[StringKeyName].Value;
                else
                    StringLanguage = "en-us";

                var Language = Context.Request.Headers["Accept-Language"];
                if (Language != null)
                {
                    if (!Language.Contains(StringLanguage))
                        Context.Request.Headers["Accept-Language"] = StringLanguage + "," + Context.Request.Headers["Accept-Language"];

                    var Culture = new System.Globalization.CultureInfo(StringLanguage);
                    SPUtility.SetThreadCulture(Culture, Culture);

                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void Dispose()
        {
        }
    }

}


