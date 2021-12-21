


using CCQDTO;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Linq;
using Newtonsoft.Json;

namespace CCQ_Portal.Layouts.CCQPortal
{

    public partial class PortalMethods : LayoutsPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        [WebMethod]
        public static List<GoalDetails> GetGoals()
        {
            SPListItemCollection objGoalMaster = null;
            SPListItemCollection objGoalDetails = null;
            List<GoalDetails> lstGoalDetails = new List<GoalDetails>();

            string strViewFields = "";
            string strQuery = "";
            strQuery = "<OrderBy><FieldRef Name = 'SortOrder'/></OrderBy><Where><Eq><FieldRef Name = 'isHide'/><Value Type = 'Boolean'>0</Value></Eq></Where>";

            string strUrl = SPContext.Current.Site.Url;
            strViewFields = @"<FieldRef Name='isHide' /><FieldRef Name='Title' /><FieldRef Name='TitleEn'/><FieldRef Name='TitleAr'/><FieldRef Name='HtmlEn'/><FieldRef Name='HtmlAr'/>";
            string strGoalMasterListName = "CCQGoalsMaster";
            string strGoalType = "CCQ Goals";
            objGoalMaster = GetListItems(strUrl, strGoalMasterListName, strQuery, strViewFields);
            strQuery = "<OrderBy><FieldRef Name = 'GoalType'/><FieldRef Name = 'GoalTypeSortOrder'/></OrderBy><Where><Eq><FieldRef Name = 'isHide'/><Value Type = 'Boolean'>0</Value></Eq></Where>";
            strViewFields = @"<FieldRef Name='GoalType' /><FieldRef Name='TitleEn' /><FieldRef Name='TitleAr'/><FieldRef Name='DescriptionEn' /><FieldRef Name='DescriptionAr'/>";

            objGoalDetails = GetListItems(strUrl, strGoalType, strQuery, strViewFields);

            foreach (SPListItem newsItem in objGoalMaster)
            {


                var result = objGoalDetails.Cast<SPListItem>();
                List<GoalType> lstGoalType =
               (from SPListItem listItem in result.Where(m => m["GoalType"].ToString().Split('#')[1] == newsItem["TitleEn"].ToString())
                select new GoalType
                {
                    TitleEn = listItem["TitleEn"].ToString(),
                    TitleAr = listItem["TitleAr"].ToString(),
                     DescriptionEn= listItem["DescriptionEn"].ToString(),
                    DescriptionAr = listItem["DescriptionAr"].ToString(),
                }).ToList();
                if (lstGoalType.Count > 0)
                {
                    var objJSONGoalDetails = new GoalDetails
                    {

                        TitleEn = newsItem["TitleEn"].ToString(),
                        TitleAr = newsItem["TitleAr"].ToString(),
                        HtmlEn= newsItem["HtmlEn"].ToString(),
                        HtmlAr = newsItem["HtmlAr"].ToString(),
                        GoalType = lstGoalType,


                    };


                    lstGoalDetails.Add(objJSONGoalDetails);

                }
              
            }
            return lstGoalDetails;
        }

        [WebMethod]
        public static List<NewsDetails> GetNews()
        {
            SPListItemCollection objNewsMaster = null;
            SPListItemCollection objNewsDetails = null;
            List<NewsDetails> lstNewDetails = new List<NewsDetails>();

            string strViewFields = "";
            string strQuery = "";
            strQuery = "<OrderBy><FieldRef Name = 'SortOrder'/></OrderBy><Where><Eq><FieldRef Name = 'isHide'/><Value Type = 'Boolean'>0</Value></Eq></Where>";

            string strUrl = SPContext.Current.Site.Url + "/MediaCenter";
            strViewFields = @"<FieldRef Name='isHide' /><FieldRef Name='Title' /><FieldRef Name='TitleEn'/><FieldRef Name='TitleAr'/>";
            string strNewsMasterListName = "CCQNewsMaster";
            string strCCQNews = "CCQNews";
            objNewsMaster = GetListItems(strUrl, strNewsMasterListName, strQuery, strViewFields);
            strQuery= "<OrderBy><FieldRef Name = 'NewsType'/><FieldRef Name = 'NewsSortOrder'/></OrderBy><Where><Eq><FieldRef Name = 'isHide'/><Value Type = 'Boolean'>0</Value></Eq></Where>";
            strViewFields = @"<FieldRef Name='NewsType' /><FieldRef Name='TitleEn' /><FieldRef Name='TitleAr'/><FieldRef Name='NewsSortOrder'/><FieldRef Name='DescriptionEn'/><FieldRef Name='ImageEn'/><FieldRef Name='ImageAr'/>";

            objNewsDetails = GetListItems(strUrl, strCCQNews, strQuery, strViewFields);

            foreach(SPListItem newsItem in objNewsMaster)
            {
              
                


                var result = objNewsDetails.Cast<SPListItem>();
                List<NewsType> lstNewsType =
               (from SPListItem listItem in result.Where(m => m["NewsType"].ToString().Split('#')[1] == newsItem["TitleEn"].ToString())
                select new NewsType
                {
                    TitleEn =listItem["TitleEn"].ToString(),
                    TitleAr = listItem["TitleAr"].ToString(),
                    ImageEn= listItem["ImageEn"].ToString(),
                    ImageAr = listItem["ImageAr"].ToString(),



                }).ToList();
                if (lstNewsType.Count > 0)
                {
                    var objJSONNewsDetails = new NewsDetails
                    {

                        NewsTitleEn = newsItem["TitleEn"].ToString(),
                        NewsTitleAr = newsItem["TitleAr"].ToString(),
                        NewsType = lstNewsType,


                    };


                    lstNewDetails.Add(objJSONNewsDetails);

                }
                //{
                //    NewsTitleEn = newsItem["TitleEn"].ToString(),
                //    NewsTileAr = newsItem["TitleEn"].ToString()


                //});
                //List<NewsDetails> newList = objNewsDetails.Cast<NewsDetails>().ToList();

             

                //List<string> theList = result.AsEnumerable().Select(item =>
                //        (string)item["ImageEn"]).ToList();

           //var test=     result.AsEnumerable().Select(x => Tonew(x)).ToList();
                //List<string> theList = result.AsEnumerable().ToList();
            }
            return lstNewDetails;
        }
        public static SPListItemCollection GetListItems(string SiteUrl,string ListName,string Query, string ViewFields)
        {
            SPListItemCollection objSPListItemCollection = null;
            try
            {

                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {
                    using (SPSite objSite = new SPSite(SiteUrl))
                    {
                        using (SPWeb objWeb = objSite.OpenWeb())
                        {
                            objWeb.AllowUnsafeUpdates = true;
                            SPList objList = objWeb.Lists[ListName];
                           
                            SPQuery objSPQuery = new SPQuery();
                            objSPQuery.Query = Query;
                            if (ViewFields != "")
                            {
                                objSPQuery.ViewFields = ViewFields;
                            }
                            objSPListItemCollection = objList.GetItems(objSPQuery);

                        
                            objWeb.AllowUnsafeUpdates = false;

                        }
                    }
                });
            }
            catch (Exception ex)
            {
                objSPListItemCollection = null;


            }

            return objSPListItemCollection;
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
