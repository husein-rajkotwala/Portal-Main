using CCQ_Etqan.EtqanComman;
using CCQ_Etqan.EtqanDTO;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web.Services;

namespace CCQ_Etqan.Layouts.CCQEtqan
{
    public partial class EtqanMethods : LayoutsPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        private static bool RollBackSeat(string workShopId)
        {
            bool isSucess=false;

            try
            {
                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {
                    using (SPSite objSite = new SPSite(SPContext.Current.Site.Url))
                    {
                        using (SPWeb objWeb = objSite.OpenWeb())
                        {
                            objWeb.AllowUnsafeUpdates = true;
                            SPList objList = objWeb.Lists["CCQWorkshops"];
                            SPListItem objListItem = objList.GetItemById(int.Parse(workShopId));

                            int seatsLeft = int.Parse(objListItem["Seatsleft"].ToString());
                            int capacity = int.Parse(objListItem["Capacity"].ToString());

                            if (seatsLeft < capacity)
                            {
                                objListItem["Seatsleft"] = seatsLeft + 1;
                                objListItem.Update();
                                isSucess = true;
                                objWeb.AllowUnsafeUpdates = false;
                            }
                        }
                    }
                });
            }
            catch (Exception ex)
            {
                isSucess = false;
                ExceptionHandling.ProcessDataException(ex);
            }
            return isSucess;
        }
       private static string ISSeatAvailable(string workShopId)
        {
            string strResponse = "";
            try
            {
                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {
                    using (SPSite objSite = new SPSite(SPContext.Current.Site.Url))
                    {
                        using (SPWeb objWeb = objSite.OpenWeb())
                        {
                            objWeb.AllowUnsafeUpdates = true;
                            SPList objList = objWeb.Lists["CCQWorkshops"];
                            SPListItem objListItem = objList.GetItemById(int.Parse(workShopId));
                            int seatsLeft = int.Parse(objListItem["Seatsleft"].ToString());
                            if (seatsLeft > 0)
                            {
                                objListItem["Seatsleft"] = seatsLeft - 1;
                                objListItem.Update();
                                strResponse = "Sucess";
                            }
                            else
                            {
                                strResponse = "NoSeat";
                            }
                            objWeb.AllowUnsafeUpdates = false;
                        }
                    }
                });
            }
            catch(Exception ex)
            {
                strResponse = "Error";
                ExceptionHandling.ProcessDataException(ex);
            }
            return strResponse;
        }
        [WebMethod]
       
        public static string AddRegisterStudent(List<StudentRegistration> StudentRegistration)
        {
            string strResponse = "";
            string strUrl = SPContext.Current.Site.Url;

            if (StudentRegistration != null)
            {
                try
                {
                    SPSecurity.RunWithElevatedPrivileges(delegate ()
                    {

                        using (SPSite objSite = new SPSite(strUrl))
                        {
                            using (SPWeb objWeb = objSite.OpenWeb())
                            {
                                string strSeatStatus = ISSeatAvailable(StudentRegistration[0].WorkShopNameId);
                                if (strSeatStatus == "Sucess")
                                {
                                    try
                                    {
                                        objWeb.AllowUnsafeUpdates = true;

                                        SPList objList = objWeb.Lists["StudentRegistration"];
                                        SPListItem item = objList.Items.Add();
                                        item["Title"] = StudentRegistration[0].Title;
                                        item["Name"] = StudentRegistration[0].Name;

                                        item["Email"] = StudentRegistration[0].Email;

                                        item["PhoneNumber"] = StudentRegistration[0].Phone;
                                        item["Gender"] = StudentRegistration[0].Gender;
                                        item["Status"] = "Active";
                                        item["WorkShopName"] = new SPFieldLookupValue(StudentRegistration[0].WorkShopNameId);
                                        item.Update();

                                        strResponse = "Success";
                                    }
                                    catch(Exception ex)
                                    {
                                        strResponse = "Error";
                                        bool response = RollBackSeat(StudentRegistration[0].WorkShopNameId);
                                        ExceptionHandling.ProcessDataException(ex);

                                    }

                                }
                        //        string strEmailTemplateQuery = "<OrderBy><FieldRef Name = 'ID'/></OrderBy>";
                        //        string strEmailTemplateViewFields = @"<FieldRef Name='Title' /><FieldRef Name='TargetAudience' /><FieldRef Name='EmailBody'/><FieldRef Name='Subject'/>";
                        //        var emailContent = getEmailTemplates(strUrl, SPListNames.EmailTemplates, strEmailTemplateQuery, strEmailTemplateViewFields);

                        //        string strFromUser = ConfigurationManager.AppSettings["FromUser"];

                        //        foreach (SPListItem emailItem in emailContent)
                        //        {
                        //            string strBody = string.Empty;
                        //            strBody = emailItem["EmailBody"].ToString();
                        //            if (emailItem["TargetAudience"].ToString() == "Department")
                        //            {

                        //                strBody = strBody.Replace("[Department]", FeedBack[0].DepartmentName);
                        //                strBody = strBody.Replace("[User]", FeedBack[0].Name);
                        //                strBody = strBody.Replace("[EMail]", FeedBack[0].Email);

                        //                strBody = strBody.Replace("[Phone]", FeedBack[0].Phone);
                        //                strBody = strBody.Replace("[Subject]", FeedBack[0].Subject);
                        //                strBody = strBody.Replace("[Details]", FeedBack[0].Comments);
                        //                EmailHelper.SendEmail(FeedBack[0].DepartmentEmail, FeedBack[0].Email, emailItem["Subject"].ToString(), strBody);

                        //            }
                        //            else if (emailItem["TargetAudience"].ToString() == "User")
                        //            {

                        //                strBody = strBody.Replace("[User]", FeedBack[0].Name);
                        //                EmailHelper.SendEmail(FeedBack[0].Email, strFromUser, emailItem["Subject"].ToString(), strBody);

                        //            }



                              // }

                            objWeb.AllowUnsafeUpdates = false;

                        }
                    }
                    });
                }
                catch (Exception ex)
                {
                    strResponse = "Failed";
                    ExceptionHandling.ProcessDataException(ex);

                }

            }

            return strResponse;

        }
        [WebMethod]
        public static string getUserApplications()
        {
            string strApiResponse = string.Empty;
            List<UserProfileList> objUserProfileList = new List<UserProfileList>();
            UserProfile objUserProfile = new UserProfile();
            
            try
            {
                var httpClientHandler = new HttpClientHandler();
                httpClientHandler.ServerCertificateCustomValidationCallback = (message, cert, chain, sslPolicyErrors) =>
                {
                    return true;
                };
                string UserName = string.Empty;

                string strSailpointApiUrl = ConfigurationManager.AppSettings["SailPointApiUrl"];
                string struserName = ConfigurationManager.AppSettings["SailPointUser"];
                string strPassword = ConfigurationManager.AppSettings["SailPointPassword"];

                var httpClient = new HttpClient(httpClientHandler) { BaseAddress = new Uri(strSailpointApiUrl + "?filter=emails eq \"" + UserName + "\"") };
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var byteArray = Encoding.ASCII.GetBytes("" + struserName + ":" + strPassword + "");
                httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));
                //   HttpResponseMessage response = await httpClient.GetAsync("https://soar-iiq-dt.tccq.edu.qa:8443/identityiq/scim/v2/Users?filter=emails eq \"jhain.khan@ccq.edu.qa\"");

                string strSailPointEndpontUrl = string.Empty;
               
                    UserName = SPContext.Current.Web.CurrentUser.LoginName.Split('|')[2];
                    strSailPointEndpontUrl = strSailpointApiUrl + "?filter=emails eq \"" + UserName + "\"";
               
                

                var httpResponse = httpClient.GetAsync(strSailpointApiUrl + "?filter=emails eq \"" + UserName + "\"").Result;

                var response = httpResponse.Content.ReadAsStringAsync().Result;



                strApiResponse = response;
            }
            catch (Exception ex)
            {
                strApiResponse = ex.Message;
                ExceptionHandling.ProcessDataException(ex);
            }
            return strApiResponse;
        }
    }
}
