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
            try
            {
                string strEnabledSSO = new SPManager().GetConfigurationValue("EnabledSSO");
                if (strEnabledSSO == "Yes")
                {
                    string portalSignoutUrl = ConfigurationManager.AppSettings["PortalSignoutUrl"];
                    HttpContext.Current.Response.Cookies["FedAuth"].Expires = DateTime.Now.AddDays(-1);
                    Response.Redirect(portalSignoutUrl);
                }
                else
                {
                    string strNativeSignoutUrl = new SPManager().GetConfigurationValue("NativeSignoutUrl");

                    Response.Redirect(strNativeSignoutUrl);

                }
            }
            catch(Exception ex)
            {
                ExceptionHandling.ProcessDataException(ex);


            }
        }
        

    }
}
