using Microsoft.SharePoint;
using System;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace CCQ_Portal.CONTROLTEMPLATES.Portal_Main
{
    public partial class UCCommanControls : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogoutout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            HttpCookie cookieSession = Context.Request.Cookies["FedAuth"];
            cookieSession.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookieSession);
            // clear authentication cookie
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie1);

            SessionStateSection sessionStateSection = (SessionStateSection)WebConfigurationManager.GetSection("system.web/sessionState");
            HttpCookie cookie2 = new HttpCookie(sessionStateSection.CookieName, "");
            cookie2.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie2);
            Microsoft.IdentityModel.Web.FederatedAuthentication.SessionAuthenticationModule.Dispose();

            Page.ClientScript.RegisterStartupScript(

            this.GetType(), "cle", "windows.history.clear", true);
            Response.Redirect(SPContext.Current.Site.Url+"/_layouts/15/SignOut.aspx");
        }
    }
}
