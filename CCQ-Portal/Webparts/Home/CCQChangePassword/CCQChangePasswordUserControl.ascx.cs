using Microsoft.IdentityModel.Web;
using System;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace CCQ_Portal.Webparts.Home.CCQChangePassword
{
    public partial class CCQChangePasswordUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        private void RemoveCookiesAndSignOut()
        {
            // Clear session state. 
            if (Context.Session != null)
            {
                Context.Session.Clear();
            }

            string cookieValue = string.Empty;
            if (Context.Request.Browser["supportsEmptyStringInCookieValue"] == "false")
                cookieValue = "NoCookie";

            // Clear my own cookie.
            HttpCookie cookieWinSignIn = Context.Request.Cookies["Morpheus_WindowsSignedIn"];
            if (cookieWinSignIn != null)
            {
                cookieWinSignIn.Value = cookieValue;
                Context.Response.Cookies.Remove("Morpheus_WindowsSignedIn");
                Context.Response.Cookies.Add(cookieWinSignIn);
            }

            // Remove cookies for authentication. 
            HttpCookie cookieSession = Context.Request.Cookies["FedAuth"];
            if (cookieSession != null)
            {
                cookieSession.Value = cookieValue;
                Context.Response.Cookies.Remove("FedAuth");
                cookieSession.Expires = DateTime.Now.AddDays(-1D);
           Response.Cookies.Add(cookieSession);
               
             
            }

            HttpCookie cookiePersist = Context.Request.Cookies["MSOWebPartPage_AnonymousAccessCookie"];
            if (cookiePersist != null)
            {
                cookiePersist.Value = cookieValue;
                cookiePersist.Expires = new DateTime(1970, 1, 1);
                Context.Response.Cookies.Remove("MSOWebPartPage_AnonymousAccessCookie");
                Context.Response.Cookies.Add(cookiePersist);
            }

            // Sign out.
            FederatedAuthentication.SessionAuthenticationModule.SignOut();
            Response.Redirect("http://portal-01t.tccq.edu.qa/WaseemBranding/_layouts/15/SignOut.aspx");
         
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {

            string[] myCookies = Request.Cookies.AllKeys;

            //FormsAuthentication.SignOut();
            //Response.Cookies["FedAuth"].Expires = DateTime.Now.AddDays(-1);
            //Session.Clear();
            //Response.Redirect("https://portal-01t.tccq.edu.qa/_layouts/15/SignOut.aspx");

            FormsAuthentication.SignOut();
            Session.Abandon();
            HttpCookie cookieSession = Context.Request.Cookies["FedAuth"];
            cookieSession.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookieSession);
            // clear authentication cookie
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie1);

            // clear session cookie (not necessary for your current problem but i would recommend you do it anyway)
            SessionStateSection sessionStateSection = (SessionStateSection)WebConfigurationManager.GetSection("system.web/sessionState");
            HttpCookie cookie2 = new HttpCookie(sessionStateSection.CookieName, "");
            cookie2.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie2);

            Response.Redirect("https://portal-01t.tccq.edu.qa/_layouts/15/SignOut.aspx");

        }
    }
}
