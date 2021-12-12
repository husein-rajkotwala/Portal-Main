<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCTopMenu.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCTopMenu" %>


<script>
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
   var language = lang;
  

    var configurationApiUrl = "";
    $(document).ready(function () {
        getTopNavigation();
    });

    function getTopNavigation() {
        var Title = "TopNavigation";
        var ID = "";
        var Filter = "isHide eq 'No'";
        var Select = "";
        var orderBy = "SortOrder asc";
        var top = "";
        var restWeb = new RESTApiHelper.Web(siteUrl);
        var myList = new restWeb.List(Title);
        var items = new myList.Items();
        if (ID != '')
            items.GetItemByID(ID, doSuccess, doError);
        else
            items.GetItems(Select, Filter, orderBy, top, doSuccessTopNavigation, doErrorTopNavigation);
    }
    

   
    function doSuccessTopNavigation(data) {
        var htmlTopNav = "";
        var userRoleDetails = userOURole;

        $.each(data.d.results, function (index, item) {
            if (language == "en-us") {
                if (userRoleDetails == "Common") {
                    htmlTopNav += item.htmlEn;

                }
                else if (userRoleDetails == "Student" && item.isStudent) {
                    htmlTopNav += item.htmlEn;
                }
                else if (userRoleDetails == "Staff" && item.isStaff) {
                    htmlTopNav += item.htmlEn;

                }
                
            }
            else {
                if (userRoleDetails == "Common") {
                    htmlTopNav += item.htmlAr;

                }
               else if (userRoleDetails == "Student" && item.isStudent) {
                    htmlTopNav += item.htmlAr;
                }
                else if (userRoleDetails == "Staff" && item.isStaff) {
                    htmlTopNav += item.htmlAr;

                }
               
            }

        });
        $("#MainNav").html(htmlTopNav);


    }
    function doErrorTopNavigation(err) {
        alert(JSON.stringify(err));
    }

</script>
  <ul class="navbar-nav mr-auto-cust" id="MainNav">
      </ul>


