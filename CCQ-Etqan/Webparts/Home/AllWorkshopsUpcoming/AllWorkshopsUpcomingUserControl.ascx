<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AllWorkshopsUpcomingUserControl.ascx.cs" Inherits="CCQ_Etqan.Webparts.Home.AllWorkshopsUpcoming.AllWorkshopsUpcomingUserControl" %>
<script src="/Style%20Library/Script/ccq/assets/Events/moment.min.js"></script>

<script>
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
    var sflag;
    var pageIndex = 1; // default page index value   
    var pageSize = 2;//defualt page size  
    var nextPagingInfo;
    var previousPagingInfo;
    var position;
    var oListItem;
    sortColumn = "StartDate";
    var collUpcomingWorkshopListItem;
    function btnnextclick() {
        pageIndex = pageIndex + 1;
        if (nextPagingInfo) {
            position = new SP.ListItemCollectionPosition();
            position.set_pagingInfo(nextPagingInfo);
        }
        else {
            position = null;
        }

        GetUpcomingWorkshops();
    }
    //prev click code
    function btnprevclick() {
        pageIndex = pageIndex - 1;
        position = new SP.ListItemCollectionPosition();
        position.set_pagingInfo(previousPagingInfo);
        GetUpcomingWorkshops();
    }
    $(document).ready(function () {
    
        SP.SOD.executeFunc("sp.js", "SP.ClientContext", function () {
            GetUpcomingWorkshops();
        });
        

    });
    function GetUpcomingWorkshops() {
        var collListItem;
        var clientContext = new SP.ClientContext.get_current();
        var upcomingWorkShopList = clientContext.get_web().get_lists().getByTitle('CCQWorkshops');
        var camlQuery = new SP.CamlQuery();
        if (position == undefined) {
            camlQuery.set_listItemCollectionPosition(undefined);

        }
        else {
            camlQuery.set_listItemCollectionPosition(position);


        }
        camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='StartDate' /><FieldRef Name='EndDate' /><FieldRef Name='Level' /><FieldRef Name='Instructor' /><FieldRef Name='Title' /><FieldRef Name='ID' /><FieldRef Name='Description' /></ViewFields><Query><Where><And><Geq><FieldRef Name='StartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Geq><Eq><FieldRef Name='Active' /><Value Type='Boolean'>1</Value></Eq></And></Where><OrderBy><FieldRef Name='StartDate' /></OrderBy></Query><RowLimit>2</RowLimit></View>");

        collUpcomingWorkshopListItem = upcomingWorkShopList.getItems(camlQuery);
        clientContext.load(collUpcomingWorkshopListItem);
        clientContext.executeQueryAsync(function () {
            var listItemInfo = '';
            var listItemEnumerator = collUpcomingWorkshopListItem.getEnumerator();

            var index = 0;
            var upcomingWorkshopHtml = "";
            while (listItemEnumerator.moveNext()) {
                var oListItem = listItemEnumerator.get_current();
               
                //var startDateMonth = moment(oListItem.get_item("StartDate")).format('MMMM');
                var startDate = moment(oListItem.get_item("StartDate")).format('Do MMMM  YYYY, h:mm a');
                var starDateArr = startDate.split(',');
                var Id = oListItem.get_item("ID");
                var workShopTitle = oListItem.get_item("Title");
                var workShopDescription = oListItem.get_item("Description");
                var workshopDetailsUrl = _spPageContextInfo.webAbsoluteUrl + "/Pages/EtqanWorkshopDetails.aspx?WorkshopId=" + Id;
                upcomingWorkshopHtml += '<div class="col-md-6 col-lg-4 py-2 workshop-item">';
                upcomingWorkshopHtml += '<div class="card h-100">';
                upcomingWorkshopHtml += '<div class="card-body">';
                upcomingWorkshopHtml += '<h5 class="card-title"><a href=' + workshopDetailsUrl + ' class="stretched-link"><i class="fas fa-chalkboard-teacher"></i> ' + workShopTitle + '</a></h5>';
                upcomingWorkshopHtml += '<ul class="workshops-attr">';
                upcomingWorkshopHtml += '<li><span class="text-muted"><i class="fas fa-calendar-alt text-muted"></i>' + starDateArr[0] + '</span></li>';
                upcomingWorkshopHtml += '<li><span class="text-muted"><i class="far fa-clock text-muted"></i>' + starDateArr[1] + '</span></li>';
                upcomingWorkshopHtml += '</ul>';
                upcomingWorkshopHtml += '<p class="card-text">' + workShopDescription + '</p>';
                upcomingWorkshopHtml += '<a href="reg_form.html" class="btn btn-outline-primary">تسجيل <i class="far fa-arrow-alt-circle-left"></i></a>';
                upcomingWorkshopHtml += '</div>';
                upcomingWorkshopHtml += '</div>';
                upcomingWorkshopHtml += '</div>';
                index++;
            }
            $("#Allworkshops").html(upcomingWorkshopHtml);

            if (collUpcomingWorkshopListItem.get_listItemCollectionPosition()) {
                nextPagingInfo = collUpcomingWorkshopListItem.get_listItemCollectionPosition().get_pagingInfo();
            } else {
                nextPagingInfo = null;
            }
            previousPagingInfo = "PagedPrev=TRUE&Paged=TRUE&p_ID=" + collUpcomingWorkshopListItem.itemAt(0).get_item('ID') + "&p_" + sortColumn + "=" + encodeURIComponent(collUpcomingWorkshopListItem.itemAt(0).get_item(sortColumn).toISOString());
            //position = collUpcomingWorkshopListItem.ListItemCollectionPosition;

           
        }, function (sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        });
    }

    

   

</script>
<div class="latest-workshops">
        <div class="container-fluid">
            <div class="row py-3 workshops-cards" id="Allworkshops">
                </div>
            <input type="button" id="Back" value="Back" onclick='btnprevclick()'>
            <input type="button" id="Next" value="Next" onclick='btnnextclick()' >
            </div>
    </div>

