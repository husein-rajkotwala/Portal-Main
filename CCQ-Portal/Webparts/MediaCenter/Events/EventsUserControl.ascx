<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EventsUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.MediaCenter.Events.EventsUserControl" %>

<link href="/Style%20Library/Script/ccq/assets/Events/fullcalendar.min.css" rel="stylesheet" />
<script src="/Style%20Library/Script/ccq/assets/Events/moment.min.js"></script>
<script src="/Style%20Library/Script/ccq/assets/Events/fullcalendar.min.js"></script>

<section class="calendar-sec">
    <div class="mainbox p-3">
        <div class="row sec-title">
            <div class="col text-left">
                <h2 class="fz-28 color-prime"><%=GetLocalResourceObject("EVENTS")%> <span class="d-block fz-12 color-gray2"><%=GetLocalResourceObject("RecentlyAdded")%></span></h2>
            </div>

            <div class="col text-right fz-16">
              <%--  <a href="/MediaCenter/Pages/ViewAllEvents.aspx"><%=GetLocalResourceObject("ExpandAll")%>
                                        <i class="icon-arrow_forward_ios"></i>
                </a>--%>
            </div>

        </div>
        <!--titel-mainBox -->
        <div class="row">
            <div class="col-md-6">
                <div id="FullCaleander">
                    <!--Script at main.js-->
                </div>
            </div>
            <div class="col-md-6">
                <strong class="events"><%=GetLocalResourceObject("UpcomingEvents")%></strong>
                <!--events-->
                <ul class="ul-events" id="recentEvents">
                </ul>
                <!--ul-events-->

            </div>

        </div>

    </div>
    <!-- mainbox -->
    <div id="ModalEvents" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="ModalEvents" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
			
			   <div class="modal-header">
                <h5 class="modal-title ml-0 mr-0 color-prime"><span id="eventTitle"></span></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
			
	
                <div class="modal-body">
                    <p id="pDetails"></p>
                </div>
        
            </div>
        </div>
    </div>
</section>


<script>
    var eventsSiteEventUrl = _spPageContextInfo.siteAbsoluteUrl+'/MediaCenter';
    var language = lang;
    var EventTitle = "CCQ Events";
    var ID = "";
    var events = [];
    var calEventDescription = "";
    var calEventTitle = "";
    var months = ["يناير", "فبراير", "مارس", "إبريل", "مايو", "يونيو",
        "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
    ];
    var days = ["اﻷحد", "اﻷثنين", "الثلاثاء", "اﻷربعاء", "الخميس", "الجمعة", "السبت"];
    $(document).ready(function () {
        getEvents();
        getRecentEvents();
        
      
   
    });


    function getEvents() {
        var Filter = "";
        var Select = "";
        var orderBy = "Created desc";
        var top = "10";
        var restWeb = new RESTApiHelper.Web(eventsSiteEventUrl);
        var myList = new restWeb.List(EventTitle);
        var items = new myList.Items();
        
        jQuery.ajax({
            url: eventsSiteEventUrl + "/_api/web/lists/GetByTitle('" + EventTitle + "')/items?$select=Title,EventDate,EndDate,TitleEn,TitleAr,DescriptionEn,DescriptionAr,CategoryEvents/Title,CategoryEvents/Color,CategoryEvents/DepartmentEn,CategoryEvents/DepartmentAr&$expand=CategoryEvents",
            type: "GET",
            headers: { "Accept": "application/json; odata=verbose" },
            success: doSuccessEvents,
            error: doErrorEvents
        });

        function doSuccessEvents(data) {

            $.each(data.d.results, function (index, item) {

                if (language == "en-us") {
                    events.push({
                        title: item.TitleEn,
                        description: item.DescriptionEn,
                        start: moment(item.EventDate),
                        end: item.EndDate != null ? moment(item.EndDate) : null,
                        color: item.CategoryEvents.Color.substring(1),
                    });
                }
                else {
                    events.push({
                        title: item.TitleAr,
                        description: item.DescriptionAr,
                        start: moment(item.EventDate),
                        end: item.EndDate != null ? moment(item.EndDate) : null,
                        color: item.CategoryEvents.Color.substring(1),
                    });
                }

            });
              GenerateCalender(events);
        }
      
    }

    function doErrorEvents(err) {
        alert(JSON.stringify(err));
    }

    function GenerateCalender(events) {
        $('#FullCaleander').fullCalendar('destroy');
        $('#FullCaleander').fullCalendar({
            contentHeight: 400,
            defaultDate: new Date(),
            timeFormat: 'h(:mm)a',
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,basicWeek,basicDay,agenda'
            },
            eventLimit: true,
            eventColor: 'green',
            events: events,
            eventClick: function (calEvent, jsEvent, view) {
                var startDate = "";
                if (language == "en-us") {
                    startDate = calEvent.start.format("DD-MMM-YYYY HH:mm a");
                    endDate = calEvent.end.format("DD-MMM-YYYY HH:mm a");
                    calEventDescription = calEvent.DescriptionEn;
                    calEventTitle = calEvent.TitleEn;
                }
                else {
                    startDate = new Date(calEvent.start).toLocaleDateString("ar-Qa") + " " + new Date(calEvent.start).toLocaleTimeString("ar-Qa");
                    endDate = new Date(calEvent.end).toLocaleDateString("ar-Qa") + " " + new Date(calEvent.end).toLocaleTimeString("ar-Qa");
                    calEventDescription = calEvent.DescriptionAr;
                    calEventTitle = calEvent.TitleAr;


                }

                $('#ModalEvents #eventTitle').text(calEvent.title);
                var $description = $('<div/>');
                $description.append($('<p/>').html('<strong><i class="icon-calendar-check-o color-green"></i> <%=GetLocalResourceObject("StartDate")%></strong> ' + startDate));
                if (calEvent.end != null) {
                    $description.append($('<p/>').html('<strong><i class="icon-calendar-times-o color-red"></i><%=GetLocalResourceObject("EndDate")%></strong> ' + endDate));
                }
                $description.append($('<p/>').html('<b><%=GetLocalResourceObject("Description")%>:</b>' + calEventDescription));
                $('#ModalEvents #pDetails').empty().html($description);

                $('#ModalEvents').modal();
            }
        })

        
    }


    function getRecentEvents() {
        var now = moment().format("MM/DD/YYYY");
        var FilterRecentEvents = "EventDate ge '" + now + "'";
        var Select = "";
        var orderBy = "Created desc";
        var top = "10";
        var restWeb = new RESTApiHelper.Web(eventsSiteEventUrl);
        var myList = new restWeb.List(EventTitle);
        var items = new myList.Items();
        if (ID != '')
            items.GetItemByID(ID, doSuccessRecentEvents, doErrorRecentEvents);
        else
            items.GetItems(Select, FilterRecentEvents, orderBy, top, doSuccessRecentEvents, doErrorRecentEvents);


        function doSuccessRecentEvents(RecentData) {
       
            $.each(RecentData.d.results, function (index, RecentItem) {
                var RecentEventsContent = "";
                var RecentDate = moment(RecentItem.EventDate);
              

                if (language == "en-us") {
                    RecentEventsContent += '<li><div class="date-Events d-inline-block"><span class="date d-inline-block fz-40 font-weight-bold">' + RecentDate.format("dddd") + '</span><span class="date d-inline-block monthly text-center"><span class="d-block">' + RecentDate.format('MMMM') + ' </span>' + RecentDate.format('YYYY') + ' </span>';
                    RecentEventsContent += '<a href="#" class="Upcoming-event d-inline-block pl-3"><strong>' + RecentItem.TitleEn + ' </strong><small class="d-block"><i class="icon-location_on"></i>' + RecentItem.Location + ' </small></a>';
                    RecentEventsContent += '</div></li>';
                }
                else {
                    RecentDate = new Date(RecentDate);

                    var delDateString = days[RecentDate.getDay()] + ', ' + RecentDate.getDate() + ' ' + months[RecentDate.getMonth()] + ', ' + RecentDate.getFullYear();
                    var ArabicYear = RecentDate.toLocaleDateString("ar-Qa").split("/");


                    RecentEventsContent += '<li><div class="date-Events d-inline-block"><span class="date d-inline-block fz-40 font-weight-bold">' + days[RecentDate.getDay()] + '</span><span class="date d-inline-block monthly text-center"><span class="d-block">' + months[RecentDate.getMonth()] + ' </span>' + ArabicYear[2]+ ' </span>';
                    RecentEventsContent += '<a href="#" class="Upcoming-event d-inline-block pl-3"><strong>' + RecentItem.TitleAr + ' </strong><small class="d-block"><i class="icon-location_on"></i>' + RecentItem.Location + ' </small></a>';
                    RecentEventsContent += '</div></li>';
                }

                $("#recentEvents").append(RecentEventsContent);
            });
        }
    }
    function doErrorRecentEvents(err) {
        alert(JSON.stringify(err));
    }

</script>


<%--<script type="text/javascript">
    var defaultEvents = [
        {
            // Just an event
            title: 'Test Event',
            start: '2021-11-14',
            className: 'scheduler_basic_event',
            color: 'red !important'
        },
    ];

    // Any value represanting monthly repeat flag
    var REPEAT_MONTHLY = 1;
    // Any value represanting yearly repeat flag
    var REPEAT_YEARLY = 2;

    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        editable: true,
        // defaultDate: '2017-02-16',
        eventSources: [defaultEvents],
        dayRender: function (date, cell) {
            // Get all events
            var events = $('#calendar').fullCalendar('clientEvents').length ? $('#calendar').fullCalendar('clientEvents') : defaultEvents;
        }
    });
</script>--%>


