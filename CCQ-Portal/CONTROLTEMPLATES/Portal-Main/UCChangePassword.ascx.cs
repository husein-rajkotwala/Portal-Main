using Microsoft.SharePoint;
using System;
using System.Configuration;
using System.DirectoryServices.AccountManagement;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace CCQ_Portal.CONTROLTEMPLATES.Portal_Main
{
    public partial class UCChangePassword : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }
        

        //protected void btnSubmit_Click(object sender, EventArgs e)
        //{
          
        //    try
        //    {
        //        var userLoginName = SPContext.Current.Web.CurrentUser.LoginName;
        //        SPSecurity.RunWithElevatedPrivileges(delegate ()
        //        {

        //            string struserName = ConfigurationManager.AppSettings["User"];
        //            string strPassword = ConfigurationManager.AppSettings["Password"];
        //            string strDomain = ConfigurationManager.AppSettings["Domain"];
        //            using (var context = new PrincipalContext(ContextType.Domain, strDomain, struserName, strPassword))

        //            {

        //                using (var user = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, userLoginName))

        //                {
        //                    try
        //                    {

        //                        user.SetPassword(txtnew_password.Text);

        //                        user.Save();
        //                        int milliseconds =5000;
        //                        Thread.Sleep(milliseconds);
        //                        dvSucess.Visible = true;
                                
        //                    }
        //                    catch(Exception ex)
        //                    {
        //                        int milliseconds = 5000;
        //                        Thread.Sleep(milliseconds);
        //                        dvGeneralError.Visible = true;
        //                    }
        //                }

        //            }

        //        });
        //    }
        //    catch(Exception ex)
        //    {
        //        dvSucess.Visible = false;
        //    }
        //}
    }
}
