


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
using System.Configuration;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices;
using System.Net.Http;
using System.Text;
using System.Net.Http.Headers;
using Newtonsoft.Json.Linq;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Host.SystemWeb;
using System.Web;
using CCQ_Comman.Helpers;
using System.IdentityModel.Services;
using System.Security.Cryptography;
using System.IO;
using System.Collections;
using CCQ_Comman.Constants;

namespace CCQ_Portal.Layouts.CCQPortal
{

    public partial class PortalMethods : LayoutsPageBase
    {



        private string getEmailBody()
        {
            string strEmailBody = string.Empty;
            return strEmailBody;

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        //[WebMethod]
        //public static async void Logout()
        //{
         
        //    try
        //    {


        //        System.Web.HttpContext.Current.GetOwinContext()
        //                   .Authentication
        //                   .SignOut(CookieAuthenticationDefaults.AuthenticationType);

        //    }
        //    catch (Exception ex)
        //    {
               
        //    }
           
        //}
        [WebMethod]
        public static string getUserApplications()
        {
            string strApiResponse = string.Empty;
            List<UserProfileList> objUserProfileList = new List<UserProfileList>();
            UserProfile objUserProfile = new UserProfile();
           string strEnabledSSO=new SPManager().GetConfigurationValue("EnabledSSO");
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
                var byteArray = Encoding.ASCII.GetBytes(""+struserName+":"+strPassword+"");
                httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));
                //   HttpResponseMessage response = await httpClient.GetAsync("https://soar-iiq-dt.tccq.edu.qa:8443/identityiq/scim/v2/Users?filter=emails eq \"jhain.khan@ccq.edu.qa\"");

                string strSailPointEndpontUrl = string.Empty;
                if(strEnabledSSO=="Yes")
                {
                    UserName = SPContext.Current.Web.CurrentUser.LoginName.Split('|')[2];
                    strSailPointEndpontUrl = strSailpointApiUrl + "?filter=emails eq \"" + UserName + "\"";
                }
                else
                {
                    UserName = SPContext.Current.Web.CurrentUser.LoginName.Split('\\')[1];
                    UserName = UserName + "@ccq.edu.qa";

                }

                var httpResponse = httpClient.GetAsync(strSailpointApiUrl+"?filter=emails eq \""+UserName+"\"").Result;
               // var httpResponse = httpClient.GetAsync(strSailPointEndpontUrl).Result;

                var response = httpResponse.Content.ReadAsStringAsync().Result;
           
               
              
                strApiResponse = response;
            }
            catch(Exception ex)
            {
                strApiResponse = ex.Message;
                ExceptionHandling.ProcessDataException(ex);
            }
            return strApiResponse;
        }

        [WebMethod]
        public static string Logout()
        {
            string strResponse = "true";


            HttpContext.Current.Response.Cookies["FedAuth"].Expires = DateTime.Now.AddDays(-1);
            return strResponse;
        }
        public static string DecryptString(string key, string cipherText)
        {
            byte[] iv = new byte[16];
            byte[] buffer = Convert.FromBase64String(cipherText);

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(key);
                aes.IV = iv;
                ICryptoTransform decryptor = aes.CreateDecryptor(aes.Key, aes.IV);

                using (MemoryStream memoryStream = new MemoryStream(buffer))
                {
                    using (CryptoStream cryptoStream = new CryptoStream((Stream)memoryStream, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader streamReader = new StreamReader((Stream)cryptoStream))
                        {
                            return streamReader.ReadToEnd();
                        }
                    }
                }
            }
        }

        private static string DecryptStringFromBytes_Aes(string cipherTextString, byte[] Key, byte[] IV)
        {
            byte[] cipherText = Convert.FromBase64String(cipherTextString);

            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");

            string plaintext = null;

            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt =
                            new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }
            return plaintext;
        }

        [WebMethod]
        public static bool  ChangePassword(string Password, string UserName)
        {
            bool isPasswordChanged = false;

            try
            {
                var userLoginName = UserName;
                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {

                    string struserName = ConfigurationManager.AppSettings["User"];
                    string strPassword = ConfigurationManager.AppSettings["Password"];
                    string strDomain = ConfigurationManager.AppSettings["Domain"];
                    string strEnvironment = ConfigurationManager.AppSettings["Environment"];
                    string strDecryptedPassword = string.Empty;
                    
                        var key = "350EAF128A50478DA48D601895404381";
                        strDecryptedPassword = DecryptString(key, strPassword);
                        strPassword = strDecryptedPassword;
                  
                    using (var context = new PrincipalContext(ContextType.Domain, strDomain, struserName, strPassword))

                    {

                        using (var user = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, UserName))

                        {
                            try
                            {

                                user.SetPassword(Password);

                                user.Save();
                                isPasswordChanged = true;
                               

                            }
                            catch (Exception ex)
                            {
                                ExceptionHandling.ProcessDataException(ex);

                                isPasswordChanged = false;
                            }
                        }

                    }

                });
            }
            catch (Exception ex)
            {
                isPasswordChanged = false;
                ExceptionHandling.ProcessDataException(ex);
            }
            return isPasswordChanged;
           
        }
        [WebMethod]
        public static bool ChangeUserProfile(List<UserProfile> UserProfile)
        {
            bool isUserProfileUpdated = false;

            try
            {
                var userLoginName = UserProfile[0].currentUser;

                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {

                    string struserName = ConfigurationManager.AppSettings["User"];
                    string strPassword = ConfigurationManager.AppSettings["Password"];
                    string strDomain = ConfigurationManager.AppSettings["Domain"];
                    var dsDirectoryEntry = new DirectoryEntry("LDAP://"+strDomain, struserName, strPassword);

                    var dsSearch = new DirectorySearcher(dsDirectoryEntry) { Filter = "(&(objectClass=user)(SAMAccountName=" + userLoginName + "))" };

                    var dsResults = dsSearch.FindOne();
                    var myEntry = dsResults.GetDirectoryEntry();
                  
                    myEntry.Properties["ccqMobileNumber"].Value = UserProfile[0].CCQMobileNumber;
                    myEntry.Properties["ccqAlternateEmail"].Value = UserProfile[0].CCQAlternateEmail;
                    myEntry.CommitChanges();
                    isUserProfileUpdated = true;

                });
            }
            catch (Exception ex)
            {
                isUserProfileUpdated = false;
                ExceptionHandling.ProcessDataException(ex);
            }
            return isUserProfileUpdated;

        }
        [WebMethod]
        public static List<UserProfile> getUserProfile(string UserName)
        {
            List<UserProfile> objListUserProfile = new List<UserProfile>();

            try
            {
               
                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {

                    string struserName = ConfigurationManager.AppSettings["User"];
                    string strPassword = ConfigurationManager.AppSettings["Password"];
                    string strDomain = ConfigurationManager.AppSettings["Domain"];
                    var dsDirectoryEntry = new DirectoryEntry("LDAP://" + strDomain, struserName, strPassword);

                   var dsSearch = new DirectorySearcher(dsDirectoryEntry) { Filter = "(&(objectClass=user)(SAMAccountName=" + UserName + "))" };
                // var dsSearch = new DirectorySearcher(dsDirectoryEntry) { Filter = "(&(objectClass=user)(mail=" + userLoginName + "))" };

                    var dsResults = dsSearch.FindOne();
                    var myEntry = dsResults.GetDirectoryEntry();

                    string strCCQMobile = string.Empty;
                    string strAlternateEmail = string.Empty;
                   if(!string.IsNullOrEmpty(myEntry.Properties["ccqMobileNumber"].Value.ToString()))
                    {

                        strCCQMobile = myEntry.Properties["ccqMobileNumber"].Value.ToString();
                    }
                    if (!string.IsNullOrEmpty(myEntry.Properties["ccqAlternateEmail"].Value.ToString()))
                    {

                        strAlternateEmail = myEntry.Properties["ccqAlternateEmail"].Value.ToString();
                    }

                    var objUserProfile = new UserProfile
                    {

                        CCQMobileNumber = strCCQMobile,
                        CCQAlternateEmail = strAlternateEmail,
                      


                    };
                    objListUserProfile.Add(objUserProfile);

                });
            }
            catch (Exception ex)
            {
                objListUserProfile = null;
                ExceptionHandling.ProcessDataException(ex);
            }
            return objListUserProfile;


        }
        private static SPListItemCollection getEmailTemplates(string strUrl,string strListName,string strQuery, string strViewFields)
        {
            SPListItemCollection objEmailTemplateListItemColleciton;

            try
            {

                 objEmailTemplateListItemColleciton = GetListItems(strUrl, strListName, strQuery, strViewFields);

            }
            catch (Exception ex)
            {
                objEmailTemplateListItemColleciton = null;
                ExceptionHandling.ProcessDataException(ex);
            }

            return objEmailTemplateListItemColleciton;
        }
        [WebMethod]
        public static List<GoalDetails> GetGoals()
        {
            SPListItemCollection objGoalMaster = null;
            SPListItemCollection objGoalDetails = null;
        List<GoalDetails> lstGoalDetails = new List<GoalDetails>();

            try
            {
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
                        DescriptionEn = listItem["DescriptionEn"].ToString(),
                        DescriptionAr = listItem["DescriptionAr"].ToString(),
                    }).ToList();
                    if (lstGoalType.Count > 0)
                    {
                        var objJSONGoalDetails = new GoalDetails
                        {

                            TitleEn = newsItem["TitleEn"].ToString(),
                            TitleAr = newsItem["TitleAr"].ToString(),
                            HtmlEn = newsItem["HtmlEn"].ToString(),
                            HtmlAr = newsItem["HtmlAr"].ToString(),
                            GoalType = lstGoalType,


                        };


                        lstGoalDetails.Add(objJSONGoalDetails);

                    }

                }
            }
            catch(Exception ex)
            {
                lstGoalDetails = null;
                ExceptionHandling.ProcessDataException(ex);
            }
            return lstGoalDetails;
        }

        [WebMethod]
        public static List<NewsDetails> GetNews()
        {
            List<NewsDetails> lstNewDetails = new List<NewsDetails>();
            try
            {
                SPListItemCollection objNewsMaster = null;
                SPListItemCollection objNewsDetails = null;
             

                string strViewFields = "";
                string strQuery = "";
                strQuery = "<OrderBy><FieldRef Name = 'SortOrder'/></OrderBy><Where><Eq><FieldRef Name = 'isHide'/><Value Type = 'Boolean'>0</Value></Eq></Where>";

                string strUrl = SPContext.Current.Site.Url + "/MediaCenter";
                strViewFields = @"<FieldRef Name='isHide' /><FieldRef Name='Title' /><FieldRef Name='TitleEn'/><FieldRef Name='TitleAr'/>";
                string strNewsMasterListName = SPListNames.NewsMaster;
                string strCCQNews = SPListNames.News;
                objNewsMaster = GetListItems(strUrl, strNewsMasterListName, strQuery, strViewFields);
                strQuery = "<OrderBy><FieldRef Name = 'NewsType'/><FieldRef Name = 'NewsSortOrder'/></OrderBy><Where><Eq><FieldRef Name = 'isHide'/><Value Type = 'Boolean'>0</Value></Eq></Where>";
                strViewFields = @"<FieldRef Name='NewsType' /><FieldRef Name='TitleEn' /><FieldRef Name='TitleAr'/><FieldRef Name='NewsSortOrder'/><FieldRef Name='DescriptionEn'/><FieldRef Name='DescriptionAr'/><FieldRef Name='ImageEn'/><FieldRef Name='ImageAr'/>";

                objNewsDetails = GetListItems(strUrl, strCCQNews, strQuery, strViewFields);

                foreach (SPListItem newsItem in objNewsMaster)
                {





                    var result = objNewsDetails.Cast<SPListItem>();



                    List<NewsType> lstNewsType =
                          (from SPListItem listItem in result.Where(m => m["NewsType"].ToString().Split('#')[1] == newsItem["TitleEn"].ToString())
                           select new NewsType
                           {
                               TitleEn = listItem["TitleEn"].ToString(),
                               TitleAr = listItem["TitleAr"].ToString(),
                               DescriptionEn = listItem["DescriptionEn"].ToString(),
                               DescriptionAr = listItem["DescriptionAr"].ToString(),
                               ImageEn = listItem["ImageEn"].ToString(),
                               ImageAr = listItem["ImageAr"].ToString(),
                               ID = int.Parse(listItem["ID"].ToString())



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
            }
            catch (Exception ex)
            {
                lstNewDetails = null;
                ExceptionHandling.ProcessDataException(ex);
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
                ExceptionHandling.ProcessDataException(ex);

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
                                item["Subject"] = FeedBack[0].Subject;



                                item["Category"] = new SPFieldLookupValue(FeedBack[0].CategoryId);

                                item.Update();
                                     strResponse = "Success";
                                string strEmailTemplateQuery = "<OrderBy><FieldRef Name = 'ID'/></OrderBy>";
                                string strEmailTemplateViewFields = @"<FieldRef Name='Title' /><FieldRef Name='TargetAudience' /><FieldRef Name='EmailBody'/><FieldRef Name='Subject'/>";
                             var emailContent=getEmailTemplates(strUrl, SPListNames.EmailTemplates, strEmailTemplateQuery, strEmailTemplateViewFields);
                              
                                string strFromUser = ConfigurationManager.AppSettings["FromUser"];

                                foreach (SPListItem  emailItem in emailContent)
                                {
                                    string strBody = string.Empty;
                                    strBody = emailItem["EmailBody"].ToString();
                                    if (emailItem["TargetAudience"].ToString() == "Department")
                                    {
                                        
                                        strBody = strBody.Replace("[Department]", FeedBack[0].DepartmentName);
                                        strBody = strBody.Replace("[User]", FeedBack[0].Name);
                                        strBody = strBody.Replace("[EMail]", FeedBack[0].Email);

                                        strBody = strBody.Replace("[Phone]", FeedBack[0].Phone);
                                        strBody = strBody.Replace("[Subject]", FeedBack[0].Subject);
                                        strBody = strBody.Replace("[Details]", FeedBack[0].Comments);
                                        EmailHelper.SendEmail(FeedBack[0].DepartmentEmail, FeedBack[0].Email, emailItem["Subject"].ToString(), strBody);

                                    }
                                 else if (emailItem["TargetAudience"].ToString() == "User")
                                    {
                                       
                                        strBody = strBody.Replace("[User]", FeedBack[0].Name);
                                        EmailHelper.SendEmail(FeedBack[0].Email, strFromUser, emailItem["Subject"].ToString(), strBody);

                                    }



                                }

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

    }
}

