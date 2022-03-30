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
using System.Configuration;
using System.Net;
using System.IO;
using System.Text;
using Microsoft.Owin.Security;
using Microsoft.AspNet.Identity;
using Mono.Cecil;
using System.Linq;
using System.Threading.Tasks;
using System.Net.Http;
using System.IdentityModel.Services.Configuration;
using CCQ_Comman.Helpers;
using System.Net.Http.Headers;

namespace CCQ_Portal.CONTROLTEMPLATES.Portal_Main
{
    public partial class UCCommanControls : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public string GetResponse(string sURL)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(sURL); request.MaximumAutomaticRedirections = 4;
            request.Credentials = CredentialCache.DefaultCredentials;
            try
            {
                HttpWebResponse response = (HttpWebResponse)request.GetResponse(); Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8); string sResponse = readStream.ReadToEnd();
                response.Close();
                readStream.Close();
                return sResponse;
            }
            catch
            {
              
                return "";
            }
        }

        public static async Task<string> HttpGetAsync(string uri)
        {
            string content = null;

            var client = new HttpClient();
            var response = await client.GetAsync(uri);
            if (response.IsSuccessStatusCode)
            {
                content = await response.Content.ReadAsStringAsync();
            }

            return content;
        }
        public static async void signout()
        {
            var url = "https://trial-7608953.okta.com/login/signout";

            // Error CS4033  The 'await' operator can only be used within an async method.
            // Consider marking this method with the 'async' modifier and changing its return type to 'Task'
            string res = await HttpGetAsync(url);

        }
        protected void btnLogoutout_Click(object sender, EventArgs e)
        {
            //FormsAuthentication.SignOut();
            
            string portalSignoutUrl = ConfigurationManager.AppSettings["PortalSignoutUrl"];
            //string url = "https://mysso.ccq.edu.qa/Account/Logout";
            //// Using WebRequest
            //WebRequest request = WebRequest.Create(url);
            //WebResponse response = request.GetResponse();
            //string result = new StreamReader(response.GetResponseStream()).ReadToEnd();
            //// Using WebClient
            //string result1 = new WebClient().DownloadString(url);
            //// Response.Redirect(portalSignoutUrl, false);
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.Cache.SetExpires(DateTime.Now);
            //Response.Cache.SetNoServerCaching();
            //Response.Cache.SetNoStore();
            //System.Diagnostics.Process.Start("https://dev-32385231.okta.com/login/signout");

            //Response.Redirect("/");
            //// Response.Redirect("https://mysso.ccq.edu.qa/Account/Logout", false);
            //IAuthenticationManager AuthenticationManager = System.Web.HttpContext.Current.GetOwinContext().Authentication;
            //// FormsAuthentication.();
            //AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            //// string url = SPContext.Current.Site.Url + "/_layouts/closeConnhttps://trial-7608953.okta.com/login/signoutection.aspx?loginasanotheruser=true";

            ////Response.Redirect("");
            //FederatedAuthentication.SessionAuthenticationModule.Dispose();

            //Page.ClientScript.RegisterStartupScript(

            ////this.GetType(), "cle", "windows.history.clear", true);
            //var fam = FederatedAuthentication.WSFederationAuthenticationModule;
            //var wrealm = string.Format("wtrealm={0}", fam.Realm);
            //var signOutUrl = WSFederationAuthenticationModule.GetFederationPassiveSignOutUrl(fam.Issuer, null, wrealm);
            //var wreply = "http://localhost/myapplication/account/message";
            /// Response.Redirect("https://portal-01t.tccq.edu.qa/_layouts/closeConnection.aspx?loginasanotheruser=true&iss=https%3A%2F%2Ftrial-7608953.okta.com&session_hint=AUTHENTICATED");

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
            //var client = new IdxClient();
            //  var accessToken = HttpContext.GetOwinContext().Authentication.User.Claims.FirstOrDefault(x => x.Type == "access_token");
            //  await client.RevokeTokensAsync(TokenType.AccessToken, accessToken.Value);
            //  _authenticationManager.SignOut();
            //  return RedirectToAction("Login", "Account")

            // var accessToken = HttpContext.Current.GetOwinContext().Authentication.User.Claims.FirstOrDefault(x => x.Type == "access_token");

            //Wait for all the requests to finish
            FederatedAuthentication.SessionAuthenticationModule.Dispose();
          
           // HttpContext.Current.Response.Cookies["FedAuth"].Expires = DateTime.Now.AddDays(-1);

           Response.Redirect(portalSignoutUrl);
            //var httpClientHandler = new HttpClientHandler();
            //httpClientHandler.ServerCertificateCustomValidationCallback = (message, cert, chain, sslPolicyErrors) =>
            //{
            //    return true;
            //};

           
            //var httpClient = new HttpClient(httpClientHandler) { BaseAddress = new Uri("https://trial-7608953.okta.com/api/v1/sessions/me") };
            //httpClient.DefaultRequestHeaders.Accept.Clear();
            //httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //var httpResponse = httpClient.DeleteAsync("https://trial-7608953.okta.com/api/v1/sessions/me").Result;
            //var response = httpResponse.Content.ReadAsStringAsync().Result;
        }
        

    }
}
