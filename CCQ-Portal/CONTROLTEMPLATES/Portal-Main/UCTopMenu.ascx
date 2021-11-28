<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCTopMenu.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCTopMenu" %>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<style>
    .dropdown-item{
        background-color:white !important;
    }
</style>
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
        $("#ulMainNav").html(htmlTopNav);


    }
    function doErrorTopNavigation(err) {
        alert(JSON.stringify(err));
    }
    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
</script>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary" style="background-color:#8f0051!important">
<div class="container-fluid">

 <div class="collapse navbar-collapse" id="main_nav">
  <ul class="navbar-nav" id="ulMainNav">
 
  </ul>
</div>
<!-- navbar-collapse.// -->
</div>
<!-- container-fluid.// -->
</nav>

