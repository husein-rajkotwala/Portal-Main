using Microsoft.IdentityModel.Protocols.WSFederation;
using Microsoft.IdentityModel.Web;
using Microsoft.Owin.Security.Cookies;
using Microsoft.SharePoint;
using System;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.Owin.Host.SystemWeb;

using System.DirectoryServices;

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
              Response.Redirect("https://dev-32385231.okta.com/login/signout");
            ////HttpCookie cookieSession = Context.Request.Cookies["saml-session"];
            ////cookieSession.Expires = DateTime.Now.AddYears(-1);
            ////Response.Cookies.Add(cookieSession);
            //// clear authentication cookie
            //HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            //cookie1.Expires = DateTime.Now.AddYears(-1);
            //Response.Cookies.Add(cookie1);

            //SessionStateSection sessionStateSection = (SessionStateSection)WebConfigurationManager.GetSection("system.web/sessionState");
            //HttpCookie cookie2 = new HttpCookie(sessionStateSection.CookieName, "saml-session");
            //cookie2.Expires = DateTime.Now.AddYears(-1);
            //Response.Cookies.Add(cookie2);
            //string cookieName = sessionStateSection.CookieName;

            //Microsoft.IdentityModel.Web.FederatedAuthentication.SessionAuthenticationModule.Dispose();

            ////Page.ClientScript.RegisterStartupScript(

            ////this.GetType(), "cle", "windows.history.clear", true);
            ////foreach (string key in Request.Cookies.AllKeys)
            ////{
            ////    HttpCookie c = Request.Cookies[key];
            ////    c.Expires = DateTime.Now.AddMonths(-1);
            ////    Response.AppendCookie(c);
            //  //}
            //  HttpContext.Current.GetOwinContext().Authentication.SignOut();
            //  var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            ////  authenticationManager.SignOut(authenticationManager.)
            //  Request.GetOwinContext().Authentication.SignOut();
            //  var fam = FederatedAuthentication.WSFederationAuthenticationModule;
            //  fam.Realm = "urn:okta:sharepoint:exk3xsemaor2XvkcT5d7";
            //  fam.Issuer = "https://dev-32385231.okta.com/app/sharepoint_onpremise/sso/wsfed/passive";
            //  var wrealm = string.Format("wtrealm={0}", fam.Realm);
            //  var signOutUrl = WSFederationAuthenticationModule.GetFederationPassiveSignOutUrl(fam.Issuer, null, wrealm);
            //  FederatedAuthentication.WSFederationAuthenticationModule.SignOut(false);
            //  WSFederationAuthenticationModule authModule = FederatedAuthentication.WSFederationAuthenticationModule;

            //  //clear local cookie
            //  authModule.SignOut(false);
            //  authModule.Realm = "urn:okta:sharepoint:exk3xsemaor2XvkcT5d7";
            //  authModule.Issuer = "https://dev-32385231.okta.com/app/sharepoint_onpremise/sso/wsfed/passive";
            //  var wrealm1 = string.Format("wtrealm={0}", authModule.Realm);
            //  ////initiate federated sign out request to the STS
            //  //SignOutRequestMessage signOutRequestMessage = new SignOutRequestMessage(new Uri(authModule.Issuer), wrealm1);
            //  //String queryString = signOutRequestMessage.WriteQueryString();
            /////  Response.Redirect("https://portal-01t.tccq.edu.qa/_layouts/closeConnection.aspx?loginasanotheruser=true&source=https://portal-01t.tccq.edu.qa");
            // // var wreply = "https://portal-01t.tccq.edu.qa/_layouts/closeConnection.aspx?loginasanotheruser=true&source=https://portal-01t.tccq.edu.qa";
            //  //WSFederationAuthenticationModule.FederatedSignOut(new Uri(signOutUrl), new Uri(wreply));

            // // Response.Redirect("https://portal-01t.tccq.edu.qa/_layouts/closeConnection.aspx?loginasanotheruser=true&source=https://portal-01t.tccq.edu.qa");
            //  //HttpContext.g

            // https://dev-32385231.okta.com/login/signout

            //WSFederationAuthenticationModule authModule = FederatedAuthentication.WSFederationAuthenticationModule;

            ////clear local cookie
            //authModule.SignOut(false);

            ////initiate federated sign out request to the STS
            //SignOutRequestMessage signOutRequestMessage = new SignOutRequestMessage(new Uri(authModule.Issuer), authModule.Realm);
            //String queryString = signOutRequestMessage.WriteQueryString();
            //return new RedirectResult(queryString);
        }
    }
}
