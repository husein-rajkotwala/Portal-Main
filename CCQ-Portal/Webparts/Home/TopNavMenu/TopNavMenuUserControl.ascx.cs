using Microsoft.SharePoint;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace CCQ_Portal.Webparts.Home.TopNavMenu
{
    public class MenuItem
    {
        public string Title { get; set; }
        public string Parent { get; set; }
        public string URL { get; set; }
        public int DisplayOrder { get; set; }
        public bool IsActive { get; set; }
    }
    public partial class TopNavMenuUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = RendMenuItems();
        }

        private List<MenuItem> LoadListItems()
        {
            List<MenuItem> MenuItems = new List<MenuItem>();
            try
            {
                SPList list = SPContext.Current.Site.RootWeb.Lists.TryGetList("Top Nav");
                if (list != null)
                {
                    string caml = @"<Where><Eq><FieldRef Name = 'isActive' /><Value Type = 'Boolean'>0</Value></Eq></Where><OrderBy><FieldRef Name = 'DisplayOrder' /></OrderBy>";


                    SPQuery qry = new SPQuery();
                    qry.Query = caml;
                    SPListItemCollection items = list.GetItems(qry);
                    foreach (SPListItem item in items)
                    {
                        MenuItems.Add(new MenuItem { Title = item.Title, Parent = ParseLookUpItem(item["ParentLink"]), DisplayOrder = int.Parse(item["DisplayOrder"].ToString()), URL = item["URL"] != null ? parseUrl(item["URL"]) : "" });
                    }
                }
                return MenuItems;
            }
            catch (Exception ex)
            {
                string str = ex.Message;
                return null;
            }
        }

        public string parseUrl(object item)
        {
            string linkUrl = string.Empty;
            if (item != null)
            {
                SPFieldUrlValue fieldValue = new SPFieldUrlValue(item.ToString());
                if (fieldValue != null)
                {
                    linkUrl = fieldValue.Url;
                }
            }
            return linkUrl;
        }

        public string RendMenuItems()
        {
            try
            {

                StringBuilder sb = new StringBuilder();
                List<MenuItem> AllItems = LoadListItems();

                sb.AppendLine(@"<ul id=""AHMenu"" class=""topmenu"">");
                sb.AppendLine(@"<li class=""switch""><label onclick="""" for=""switcher""></label></li>");
                IEnumerable<MenuItem> ParentNodes = AllItems.Where(hd => hd.Parent == null || hd.Parent.Length == 0).OrderBy(h => h.DisplayOrder);
                foreach (MenuItem Node in ParentNodes)
                {
                    if (HasChildItems(AllItems, Node.Title))
                    {
                        if (ParentNodes.First().Title == Node.Title)
                        {
                            RenderItems(sb, AllItems, Node, "topfirst", true);
                        }
                        else if (ParentNodes.Last().Title == Node.Title)
                        {
                            RenderItems(sb, AllItems, Node, "toplast", true);
                        }
                        else
                        {
                            RenderItems(sb, AllItems, Node, "topmenu", true);
                        }

                    }
                    else
                    {
                        if (ParentNodes.First().Title == Node.Title)
                        {
                            sb.AppendLine(@"<li class=""topfirst""><a href=""" + Node.URL + @""">" + Node.Title + "</a></li>");

                        }
                        else if (ParentNodes.Last().Title == Node.Title)
                        {
                            sb.AppendLine(@"<li class=""toplast""><a href=""" + Node.URL + @""">" + Node.Title + "</a></li>");
                        }
                        else
                        {
                            sb.AppendLine(@"<li class=""topmenu""><a href=""" + Node.URL + @""">" + Node.Title + "</a></li>");
                        }
                    }
                }
                sb.AppendLine("</ul>");
                return sb.ToString();
            }
            catch
            {
                return string.Empty;
            }
        }

        private void RenderItems(StringBuilder sb, List<MenuItem> AllItems, MenuItem Node, string classname, bool span)
        {
            var Items = AllItems.Where(h => h.Parent == Node.Title).OrderBy(q => q.DisplayOrder);
            if (Items != null && Items.Count() > 0)
            {

                sb.AppendLine("<li classs=" + classname + ">");

                if (span)
                {
                    if (string.IsNullOrEmpty(Node.URL))
                    {
                        sb.AppendLine(@"<a href=""javascript:void(0);""><span>" + Node.Title + "</span></a>");
                    }
                    else
                    {
                        sb.AppendLine(@"<a href=" + Node.URL + "><span>" + Node.Title + "</span></a>");
                    }
                }
                else
                {
                    sb.AppendLine(@"<a href=""" + Node.URL + @""">" + Node.Title + "</a>");
                }
                sb.AppendLine("<ul>");
                foreach (var item in Items)
                {
                    if (!HasChildItems(AllItems, item.Title))
                    {
                        if (Items.First().Title == item.Title)
                        {
                            sb.AppendLine(@" <li class=""subfirst""><a href=""" + item.URL + @""">" + item.Title + "</a></li>");
                        }
                        else if (Items.Last().Title == item.Title)
                        {
                            sb.AppendLine(@" <li class=""sublast""><a href=""" + item.URL + @""">" + item.Title + "</a></li>");
                        }
                        else
                        {
                            sb.AppendLine(@" <li class=""submenu""><a href=""" + item.URL + @""">" + item.Title + "</a></li>");

                        }
                    }
                    else
                    {
                        if (Items.First().Title == item.Title)
                        {
                            RenderItems(sb, AllItems, item, "subfirst", true);
                        }
                        else if (Items.Last().Title == item.Title)
                        {
                            RenderItems(sb, AllItems, item, "sublast", true);
                        }
                        else
                        {
                            RenderItems(sb, AllItems, item, "submenu", true);
                        }
                    }
                }
                sb.AppendLine("</ul>");
                sb.AppendLine("</li>");
            }
        }

        private void RenderSubItems()
        {

        }

        private bool HasChildItems(List<MenuItem> Items, string Title)
        {
            var Children = Items.Where(h => h.Parent == Title);
            return (Children == null || Children.Count() == 0) ? false : true;
        }

        private string ParseLookUpItem(object obj)
        {
            if (obj != null && !string.IsNullOrEmpty(obj.ToString()))
            {
                return obj.ToString().Split(new string[] { ";#" }, StringSplitOptions.RemoveEmptyEntries)[1];
            }
            else
                return "";

        }
    }
 
    
}
