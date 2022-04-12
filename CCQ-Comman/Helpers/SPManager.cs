using CCQ_Comman.Constants;
using Microsoft.SharePoint;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCQ_Comman.Helpers
{
  public  class SPManager
    {
        public SPSite sPSite;
        public SPWeb sPWeb;
        public string GetConfigurationValue(string key)
        {
            try
            {
                string strSiteUrl = string.Empty;
                if (SPContext.Current != null)
                {
                    strSiteUrl = SPContext.Current.Site.Url;
                }
                else
                {
                    strSiteUrl = ConfigHelper.GetAppSetting(ConfigurationKeys.ConfigIntranetUrl);
                }
                using (SPSite site = new SPSite(strSiteUrl, SPUserToken.SystemAccount))
                {
                    using (SPWeb web = site.OpenWeb("/"))
                    {
                        Query query = new Query(Operator.And);
                        query.AddFilter("Title", "Text", key, "Eq");
                        SPList configurationList = web.Lists[SPListNames.Configurations];
                        SPListItemCollection items = configurationList.GetItems(query.GetSPQuery());
                        if (items != null && items.Count > 0)
                        {
                            return items[0]["Value"].ToString();
                        }
                    }
                }

                throw new Exception("The entry '" + key + "' does not exist in the configuration list");
            }
            catch (Exception ex)
            {
                ExceptionHandling.ProcessDataException(ex);

                return String.Empty;
            }
        }
        public List<SPListItem> GetSPListItems(string listTitle, string camlQuery, uint? rowLimit, string subSite = "", SPList list = null)
        {
            List<SPListItem> listItems = null;
            try
            {
                string siteUrl = SPContext.Current.Site.Url;
                if (!string.IsNullOrEmpty(subSite))
                    siteUrl += string.Concat("/", subSite);

                using (SPSite sPSite = new SPSite(siteUrl, SPUserToken.SystemAccount))
                {
                    using (SPWeb sPWeb = sPSite.OpenWeb())
                    {
                        SPList sPList = null;

                        if (list == null)
                            sPList = sPWeb.Lists.TryGetList(listTitle);
                        else
                            sPList = list;

                        if (sPList != null)
                        {
                            SPQuery sPQuery = new SPQuery();
                            sPQuery.Query = camlQuery;
                            if (rowLimit != null)
                                sPQuery.RowLimit = (uint)rowLimit;

                            listItems = sPList.GetItems(sPQuery).OfType<SPListItem>().ToList();
                        }
                    }
                }
            }
            catch (Exception Ex)
            {
                ExceptionHandling.ProcessDataException(Ex);

            }
            return listItems;
        }

    }
}
