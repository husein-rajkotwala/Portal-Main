<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UpcomingStudentRegisterWorkshopsUserControl.ascx.cs" Inherits="CCQ_Etqan.Webparts.Home.UpcomingStudentRegisterWorkshops.UpcomingStudentRegisterWorkshopsUserControl" %>

<div class="enrolled-workshops py-5">
            <div class="overlay"></div>
            <div class="container">
                <h4 class="text-center pb-3 text-white enrolled-title">الورش المسجل بها</h4>
                <div class="d-flex flex-row justify-content-center flex-wrap align-content-stretch" id="dvStudentWorkShopRegister">


<%--                    <div class="py-1 mx-2 card-container">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="border border-danger circleBase"><span class="days-num">20</span><br><span class="days-text">يوم</span></div>
                                <h5 class="card-title"><a href="one_workshop.html" class="stretched-link">القراءة وأنواعها</a></h5>
                                <ul class="workshops-attr">
                                    <li><span class="text-muted"><i class="fas fa-calendar-alt text-muted"></i> 24 يوليو 2022</span></li>
                                    <li><span class="text-muted"><i class="far fa-clock text-muted"></i> 10:00 AM</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>


                    <div class="py-1 mx-2 card-container">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="border border-danger circleBase"><span class="days-num">30</span><br><span class="days-text">يوم</span></div>
                                <h5 class="card-title"><a href="one_workshop.html" class="stretched-link">القراءة وأنواعها</a></h5>
                                <ul class="workshops-attr">
                                    <li><span class="text-muted"><i class="fas fa-calendar-alt text-muted"></i> 24 يوليو 2022</span></li>
                                    <li><span class="text-muted"><i class="far fa-clock text-muted"></i> 10:00 AM</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="py-1 mx-2 card-container">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="border border-danger circleBase"><span class="days-num">10</span><br><span class="days-text">يوم</span></div>
                                <h5 class="card-title"><a href="one_workshop.html" class="stretched-link">الروابط اللفظية والمعنوية في الكتابة</a></h5>
                                <ul class="workshops-attr">
                                    <li><span class="text-muted"><i class="fas fa-calendar-alt text-muted"></i> 24 يوليو 2022</span></li>
                                    <li><span class="text-muted"><i class="far fa-clock text-muted"></i> 10:00 AM</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="py-1 mx-2 card-container">
                        <div class="card h-100 text-center">
                            <div class="card-body">
                                <div class="border border-danger circleBase"><span class="days-num">7</span><br><span class="days-text">يوم</span></div>
                                <h5 class="card-title"><a href="one_workshop.html" class="stretched-link">القراءة وأنواعها</a></h5>
                                <ul class="workshops-attr">
                                    <li><span class="text-muted"><i class="fas fa-calendar-alt text-muted"></i> 24 يوليو 2022</span></li>
                                    <li><span class="text-muted"><i class="far fa-clock text-muted"></i> 10:00 AM</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>--%>

                </div>
            </div>
        </div>

<script>
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
   
    $(document).ready(function () {
    
        SP.SOD.executeFunc("sp.js", "SP.ClientContext", function () {
            debugger;
            GetUpcomingStudentWorkshops();
        });
        

    });
    function GetUpcomingStudentWorkshops() {
        var collUpcomingStudenRegisterListItem;
        var currentUserEmail = _spPageContextInfo.userLoginName;
        var clientContext = new SP.ClientContext.get_current();
        var upcomingStudentRegistrationList = clientContext.get_web().get_lists().getByTitle('StudentRegistration');
        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='WorkShopName' /><FieldRef Name='WorkShopName_x003a_StartDate' /><FieldRef Name='Email' /><FieldRef Name='ID' /><FieldRef Name='Title' /><FieldRef Name='WorkShopName_x003a_ID' /></ViewFields><Query><Where><And><And><Geq><FieldRef Name='WorkShopName_x003a_StartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Geq><Eq><FieldRef Name='Status' /><Value Type='Choice'>Active</Value></Eq></And><Eq><FieldRef Name='Email' /><Value Type='Text'>" + currentUserEmail + "</Value></Eq></And></Where><OrderBy><FieldRef Name='WorkShopStartDate' /></OrderBy></Query></View>");

        //camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='WorkShopName' /><FieldRef Name='WorkShopStartDate' /><FieldRef Name='Email' /><FieldRef Name='ID' /><FieldRef Name='Title' /></ViewFields><Query><Where><And><And><Geq><FieldRef Name='WorkShopStartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Geq><Eq><FieldRef Name='Status' /><Value Type='Choice'>Active</Value></Eq></And><Eq><FieldRef Name='Email' /><Value Type='Text'>" + currentUserEmail + "</Value></Eq></And></Where><OrderBy><FieldRef Name='WorkShopStartDate' /></OrderBy></Query></View>");
        collUpcomingStudenRegisterListItem = upcomingStudentRegistrationList.getItems(camlQuery);
        clientContext.load(collUpcomingStudenRegisterListItem);
        clientContext.executeQueryAsync(function () {
            var listItemInfo = '';
            var listItemEnumerator = collUpcomingStudenRegisterListItem.getEnumerator();

            var index = 0;
            var upcomingStudentRegistrationWorkshopHtml = "";
           
            while (listItemEnumerator.moveNext()) {
                var oListItem = listItemEnumerator.get_current();
               
                //var startDateMonth = moment(oListItem.get_item("StartDate")).format('MMMM');
                var startDate = moment(oListItem.get_item("WorkShopName_x003a_StartDate").get_lookupValue()).format('Do MMMM  YYYY, h:mm a');
                var starDateArr = startDate.split(',');
                var WorkshopStartDate = moment(oListItem.get_item("WorkShopName_x003a_StartDate").get_lookupValue(),"YYYY-MM-DD");
                var current = moment().startOf('day');
                var daysToGo = moment.duration(WorkshopStartDate.diff(current)).asDays();
                daysToGo = Math.round(daysToGo);
                var workshopId = oListItem.get_item("WorkShopName_x003a_ID").get_lookupValue()

                var workshopDetailsUrl = _spPageContextInfo.webAbsoluteUrl + "/Pages/EtqanWorkshopDetails.aspx?WorkshopId=" + workshopId;
                var workShopName = oListItem.get_item("WorkShopName").get_lookupValue();
                upcomingStudentRegistrationWorkshopHtml += '<div class="py-1 mx-2 card-container">';
                upcomingStudentRegistrationWorkshopHtml += '<div class="card h-100 text-center">';
                upcomingStudentRegistrationWorkshopHtml += '<div class="card-body">';
                upcomingStudentRegistrationWorkshopHtml += '<div class="border border-danger circleBase"><span class="days-num">'+daysToGo+'</span><br><span class="days-text">يوم</span></div>';

                upcomingStudentRegistrationWorkshopHtml += '<h5 class="card-title"><a href=' + workshopDetailsUrl + ' class="stretched-link">' + workShopName + '</a></h5>';
                upcomingStudentRegistrationWorkshopHtml += '<ul class="workshops-attr">';
                upcomingStudentRegistrationWorkshopHtml += '<li><span class="text-muted"><i class="fas fa-calendar-alt text-muted"></i>' + starDateArr[0] + '</span></li>';
                upcomingStudentRegistrationWorkshopHtml += '<li><span class="text-muted"><i class="far fa-clock text-muted"></i> ' + starDateArr[1] + '</span></li>';
                upcomingStudentRegistrationWorkshopHtml += '</ul>';
                upcomingStudentRegistrationWorkshopHtml += '</div>';
                upcomingStudentRegistrationWorkshopHtml += '</div>';
                upcomingStudentRegistrationWorkshopHtml += '</div>';
                
            }

            $("#dvStudentWorkShopRegister").html(upcomingStudentRegistrationWorkshopHtml);
 
            //$("#carouselItems").html(imageSliderHTML);
           
        }, function (sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        });
    }

    

   

</script>