<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQAppsUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.CCQApps.CCQApps.CCQAppsUserControl" %>
<script type="text/javascript">
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
    var currentUser = _spPageContextInfo.userLoginName.split('\\')[1];
    var currentUserApplications = "";
    var currentUserAppArray = [];
    var currentUserRole = "";
    $(document).ready(function () {
        //getCCQApplcations();
        getUserInformation();
    });
    function getCCQApplcations() {
        var Title = "CCQApps";
        var ID = "";
        var Filter = "Role eq '" + currentUserRole + "' and Active eq 1 or Role eq 'All'";
        var Select = "";
        var orderBy = "";
        var top = "";
        var restWeb = new RESTApiHelper.Web(siteUrl);
        var myList = new restWeb.List(Title);
        var items = new myList.Items();
        if (ID != '')
            items.GetItemByID(ID, doSuccess, doError);
        else
            items.GetItems(Select, Filter, orderBy, top, doSuccessCCQApplcations, doErrorCCQApplcations);
    }
    function doSuccessCCQApplcations(data) {
        var userApplicationHTML = "";
       

        $.each(data.d.results, function (index, item) {
            var checkIndex = "";
            var applicationTitle = "";
            var applicationImage = $($(item.ApplicationImage)[0]).find("img").attr("src");
            var applicationUrl = item.ApplicationUrl.Url;
            if (item.Role.results[0] != "All") {
                checkIndex = jQuery.inArray(item.ApplicationType, currentUserAppArray)
            }
            if (checkIndex != -1) {

                if (lang == "en-us") {
                    applicationTitle = item.ApplicationTitleEn;
                }
                else {
                    applicationTitle = item.ApplicationTitleAr;
                }
                userApplicationHTML += '<div class="col-lg-3 col-sm-6 col-md-4 my-2 px-1 col-xl-2" >';
                userApplicationHTML += '<div class="card border-0 card-shadow text-center p-3">';
                userApplicationHTML += '<a class=""  target="_blank" href=' + applicationUrl + '>'
                userApplicationHTML += '<img src=' + applicationImage + ' class="card-img-top">';
                userApplicationHTML += '</a>';
                userApplicationHTML += '<div class="card-body">';
                userApplicationHTML += '<a href=' + applicationUrl + ' class="card-title-link" target="_blank"><p class="card-text"  target="_blank">' + applicationTitle + '</p></a>';
                userApplicationHTML += '</div>';
                userApplicationHTML += '</div>';
                userApplicationHTML += '</div>';
            }

        });
        

        $("#dvApplication").html(userApplicationHTML);

    }
    function doErrorCCQApplcations(err) {

    }
    function getUserInformation() {
        var Title = "CCQUserSSO";
        var ID = "";
        var Filter = "SAMACCOUNTNAME eq '" + currentUser + "'";
        var Select = "";
        var orderBy = "";
        var top = "";
        var restWeb = new RESTApiHelper.Web(siteUrl);
        var myList = new restWeb.List(Title);
        var items = new myList.Items();
        if (ID != '')
            items.GetItemByID(ID, doSuccess, doError);
        else
            items.GetItems(Select, Filter, orderBy, top, doSuccessUserInformation, doErrorUserInformation);
    }

    function doSuccessUserInformation(data) {
       
        $.each(data.d.results, function (index, item) {

            if (item.CURRENTAPPLICATIONS != "" && item.CURRENTAPPLICATIONS != null) {
                currentUserApplications = item.CURRENTAPPLICATIONS;
                currentUserAppArray = currentUserApplications.split(',');
            }

            if (item.CATEGORY != "" && item.CATEGORY != null) {
                currentUserRole = item.CATEGORY;

            }

           
           
        });
        //if (currentUserRole != null && currentUserRole != "")
        {
            getCCQApplcations();
        }

                                                                                               


    }
    function doErrorUserInformation(err) {
     
    }

</script>
<div class="inner-page apps">
        <div class="container-fluid">
            <div class="row" id="dvApplication">
                
                <!-- <div class="col-lg-2 col-sm-6 col-md-4 my-2 px-1"> -->
              
                
                
                
            </div>
        </div>
    </div>