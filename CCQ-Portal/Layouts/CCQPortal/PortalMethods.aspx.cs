


using CCQDTO;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;

namespace CCQ_Portal.Layouts.CCQPortal
{

    public partial class PortalMethods : LayoutsPageBase
    {
    
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        [WebMethod]
       
        public static string AddFeedBackInfo(List<FeedBack> FeedBack)

        {
            string strResponse = "";
            if (FeedBack != null)

            {


                try
                {
                    string strUrl = SPContext.Current.Site.Url;

                    SPSecurity.RunWithElevatedPrivileges(delegate ()
                    {
                        using (SPSite objSite = new SPSite(strUrl))
                        {
                            using (SPWeb objWeb = objSite.OpenWeb())
                            {
                                objWeb.AllowUnsafeUpdates = true;
                                SPList objList = objWeb.Lists["CCQFeedback"];
                                SPListItem item = objList.Items.Add();
                                item["Title"] =FeedBack[0].Title;
                                item["Name"] = FeedBack[0].Name;

                                item["Email"] = FeedBack[0].Email;

                                item["Phone"] = FeedBack[0].Phone;
                                item["Comments"] = FeedBack[0].Comments;
                                item["Subject"] = FeedBack[0].Subject;

                                item["Category"] = new SPFieldLookupValue(FeedBack[0].CategoryId);

                                item.Update();

                                strResponse = "Success";
                                objWeb.AllowUnsafeUpdates = false;

                            }
                        }
                    });
                }
                catch (Exception ex)
                {
                    strResponse = "Failed";


                }

            }

            return strResponse;

        }

    }
}
