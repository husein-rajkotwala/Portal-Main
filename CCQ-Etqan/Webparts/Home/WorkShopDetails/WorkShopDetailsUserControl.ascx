<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorkShopDetailsUserControl.ascx.cs" Inherits="CCQ_Etqan.Webparts.Home.WorkShopDetails.WorkShopDetailsUserControl" %>
<script src="/Style%20Library/Script/ccq/assets/Events/moment.min.js"></script>

<div class="one-workshop-container">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="one-workshop py-3" id="dvWorkshopDetails">
               
                    </div>
                </div>
            </div>
        </div>
    
    </div>
<script>
  

        var siteUrl = _spPageContextInfo.siteAbsoluteUrl;

        $(document).ready(function () {

            SP.SOD.executeFunc("sp.js", "SP.ClientContext", function () {
                GetWorkShopDetails();
            });
            function getParameterByName(name, url = window.location.href) {
                name = name.replace(/[\[\]]/g, '\\$&');
                var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, ' '));
            }
            function GetWorkShopDetails() {
                var workShopId = getParameterByName("WorkshopId");
                var collWorkShopDetails;
                var clientContext = new SP.ClientContext.get_current();
                var upcomingWorkShopList = clientContext.get_web().get_lists().getByTitle('CCQWorkshops');
                var camlQuery = new SP.CamlQuery();
                camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='Subject' /><FieldRef Name='StartDate' /><FieldRef Name='EndDate' /><FieldRef Name='Level' /><FieldRef Name='Instructor' /><FieldRef Name='Title' /><FieldRef Name='ID' /><FieldRef Name='Description' /></ViewFields><Query><Where><Eq><FieldRef Name='ID' /><Value Type='Counter'>" + workShopId + "</Value></Eq><Eq><FieldRef Name='Active' /><Value Type='Boolean'>1</Value></Eq></Where></Query></View>");
                collWorkShopDetails = upcomingWorkShopList.getItems(camlQuery);
                clientContext.load(collWorkShopDetails);
                clientContext.executeQueryAsync(function () {
                    var listItemInfo = '';
                    var listItemEnumerator = collWorkShopDetails.getEnumerator();

                    var index = 0;
                    var workshopDetailsHtml = "";
                    while (listItemEnumerator.moveNext()) {
                        var oListItem = listItemEnumerator.get_current();

                        //var startDateMonth = moment(oListItem.get_item("StartDate")).format('MMMM');
                        var startDate = moment(oListItem.get_item("StartDate")).format('Do MMMM  YYYY, h:mm a');
                        var starDateArr = startDate.split(',');

                        var workShopTitle = oListItem.get_item("Title");
                        var workShopDescription = oListItem.get_item("Description");
                        var workshopLevel = oListItem.get_item("Level");
                        var workshopSubject = oListItem.get_item("Subject");
                        var workshopInstructor = oListItem.get_item("Instructor");
                        

                        workshopDetailsHtml += '<div class="card">';
                        workshopDetailsHtml += '<h5 class="card-header">' + workShopTitle + '</h5>';
                        workshopDetailsHtml +='<div class="card-body">'
                        workshopDetailsHtml += '<h5 class="card-header">' + workShopTitle + '</h5>';
                        workshopDetailsHtml += '<p class="card-text">' + workShopDescription + '</p>';
                        workshopDetailsHtml += '<table class="table table-borderless">';
                        workshopDetailsHtml += '<tbody>';
                        workshopDetailsHtml += '<tr>';
                        workshopDetailsHtml += '<td class="col-2">مقدم الورشة:</td>';
                        workshopDetailsHtml += '<td>' + workshopInstructor + '</td>';
                        workshopDetailsHtml += '</tr>';
                        workshopDetailsHtml += '<tr>';
                        workshopDetailsHtml += '<td>المواضيع:</td>';
                        workshopDetailsHtml += '<td>' + workshopSubject + '</td>';
                        workshopDetailsHtml += '</tr>';
                        workshopDetailsHtml += '<tr>';
                        workshopDetailsHtml += ' <td>التاريخ:</td>';
                        workshopDetailsHtml += '<td>' + starDateArr[0] + '</td>';
                        workshopDetailsHtml += '</tr>';
                        workshopDetailsHtml += '<tr>';
                        workshopDetailsHtml += '<td>الوقت:</td>';
                        workshopDetailsHtml += '<td>' + starDateArr[1] + '</td>';
                        workshopDetailsHtml += '</tr>';
                        workshopDetailsHtml += '<tr>';
                        workshopDetailsHtml += '<td>المستوى:</td>';
                        workshopDetailsHtml += '<td>' + workshopLevel + '</td>';
                        workshopDetailsHtml += '</tr>';
                        workshopDetailsHtml += '</table>';
                        workshopDetailsHtml += '<a href="reg_form.html" class="btn btn-outline-primary">تسجيل <i class="far fa-arrow-alt-circle-left"></i></a>';
                        workshopDetailsHtml += '</div>';
                        workshopDetailsHtml += '</div>';
                    }

                    $("#dvWorkshopDetails").html(workshopDetailsHtml);
     
                }, function (sender, args) {
                    console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
                });
            }
    });
</script>