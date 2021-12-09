
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;

namespace CCQ_Portal.Layouts.CCQPortal
{
    public partial class Portal : LayoutsPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }



        //public static string AddFeedBack(string param)
        //{
        //    string strResponse = "";
        //    try
        //    {
        //        string strUrl = SPContext.Current.Site.Url;

        //        SPSecurity.RunWithElevatedPrivileges(delegate ()
        //        {
        //            using (SPSite objSite = new SPSite(strUrl))
        //            {
        //                using (SPWeb objWeb = objSite.OpenWeb())
        //                {
        //                    objWeb.AllowUnsafeUpdates = true;
        //                    SPList objList = objWeb.Lists["CCQFeedback"];
        //                    SPListItem item = objList.Items.Add();
        //                    item["Title"] = "using C# :Add new list item programmatically";
        //                    item.Update();

        //                    strResponse = "Success";
        //                    objWeb.AllowUnsafeUpdates = false;

        //                }
        //            }
        //        });
        //    }
        //    catch(Exception ex)
        //    {
        //        strResponse = "Failed";


        //    }
        //    return strResponse;
        //}
        [WebMethod]
        public static string CurrentlogInUserName()
        {
            return "Hello World";
        }
    }
}
