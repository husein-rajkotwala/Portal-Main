using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System;
using System.ComponentModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace CCQ_Portal.Webparts.Home.CCQChangePassword
{
    [ToolboxItemAttribute(false)]
    public class CCQChangePassword : WebPart
    {
        // Visual Studio might automatically update this path when you change the Visual Web Part project item.
        private const string _ascxPath = @"~/_CONTROLTEMPLATES/15/CCQ_Portal.Webparts.Home/CCQChangePassword/CCQChangePasswordUserControl.ascx";

        protected override void CreateChildControls()
        {
            Control control = Page.LoadControl(_ascxPath);
            Controls.Add(control);
        }
    }
}
