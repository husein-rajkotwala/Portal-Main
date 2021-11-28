using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace CCQ_Portal.CONTROLTEMPLATES.Portal_Main
{
    public partial class UCLanguageSwitcher : UserControl
    {
        private static string strKeyName = "lang";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.Cookies[strKeyName]?.Value == "ar-SA")
            {
                lbEnglish.Visible = true;
                lbarabic.Visible = false;
            }
            else
            {
                SwitchLang("en-us");
                lbarabic.Visible = true;
                lbEnglish.Visible = false;
            }
        }
        private void SwitchLang(string strLanguage)
        {
            HttpCookie acookie = new HttpCookie(strKeyName)
            {
                Value = strLanguage,
                Expires = DateTime.MaxValue
            };
            Response.Cookies.Add(acookie);


        }

        protected void lbEnglish_Click(object sender, EventArgs e)
        {
            SwitchLang("en-us");
            Response.Redirect(Request.RawUrl);
        }
        protected void lbarabic_Click(object sender, EventArgs e)
        {
            SwitchLang("ar-SA");
            Response.Redirect(Request.RawUrl);
        }
    }
}

