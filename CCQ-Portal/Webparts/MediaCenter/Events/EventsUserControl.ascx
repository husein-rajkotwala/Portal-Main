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

<script src="http://webapp-t.ccq.edu.qa/js/fullcalendar.min.js"></script>



<div class="calendar-header-title p-3 text-uppercase"><span class="d-inline-block text-left-cust">Upcoming Events</span> <div class="d-inline-block fa-pull-right-cust mb-1"><i class="fas fa-calendar-alt fa-2x"></i></div></div>
                    <div id="calendar"></div>



<script>
    //document.addEventListener('DOMContentLoaded', function () {
    //    console.log("trs");
    //    var calendarEl = document.getElementById('calendar');

    //    var calendar = new FullCalendar.Calendar(calendarEl, {
    //        initialDate: '2021-12-01',
    //        editable: true,
    //        selectable: true,
    //        businessHours: true,
    //        dayMaxEvents: true,
    //        buttonText: {
    //            today: 'Today'
    //        },
    //        events: events
    //        //events: [
    //        //    {
    //        //        title: 'All Day Event',
    //        //        start: '2021-09-01'
    //        //    },
    //        //    {
    //        //        title: 'Long Event',
    //        //        start: '2021-09-07',
    //        //        end: '2021-09-10'
    //        //    },
    //        //    {
    //        //        groupId: 999,
    //        //        title: 'Repeating Event',
    //        //        start: '2021-09-09T16:00:00'
    //        //    },
    //        //    {
    //        //        groupId: 999,
    //        //        title: 'Repeating Event',
    //        //        start: '2021-09-16T16:00:00'
    //        //    },
    //        //    {
    //        //        title: 'Conference',
    //        //        start: '2021-09-11',
    //        //        end: '2021-09-13'
    //        //    },
    //        //    {
    //        //        title: 'Meeting',
    //        //        start: '2021-09-12T10:30:00',
    //        //        end: '2021-09-12T12:30:00'
    //        //    },
    //        //    {
    //        //        title: 'Lunch',
    //        //        start: '2021-09-12T12:00:00'
    //        //    },
    //        //    {
    //        //        title: 'Meeting',
    //        //        start: '2021-09-12T14:30:00'
    //        //    },
    //        //    {
    //        //        title: 'Happy Hour',
    //        //        start: '2021-09-12T17:30:00'
    //        //    },
    //        //    {
    //        //        title: 'Dinner',
    //        //        start: '2021-09-12T20:00:00'
    //        //    },
    //        //    {
    //        //        title: 'Birthday Party',
    //        //        start: '2021-09-13T07:00:00'
    //        //    },
    //        //    {
    //        //        title: 'Click for Google',
    //        //        url: 'http://google.com/',
    //        //        start: '2021-09-28'
    //        //    }
    //        //]
    //    });

    //    calendar.render();
    //});

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
       // getRecentEvents();
        
      
   
    });

 

       
    
    function getEvents() {
        var Filter = "";
        var Select = "";
        var orderBy = "Created desc";
        var top = "";
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
                        start: moment(item.EventDate).format('YYYY-MM-DD'),
                        end: item.EndDate != null ? moment(item.EndDate).format('YYYY-MM-DD') : null,
                        color: item.CategoryEvents.Color.substring(1),
                    });
                }
                else {
                    events.push({
                        title: item.TitleAr,
                        description: item.DescriptionAr,
                        start: moment(item.EventDate).format('YYYY-MM-DD'),
                        end: item.EndDate != null ? moment(item.EndDate).format('YYYY-MM-DD') : null,
                        color: item.CategoryEvents.Color.substring(1),
                    });
                }

            });
            console.log("eventLoaded");

            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialDate: '2021-12-01',
                editable: true,
                selectable: true,
                businessHours: true,
                dayMaxEvents: true,
                buttonText: {
                    today: 'Today'
                },
                events: events
                //events: [
                //    {
                //        title: 'All Day Event',
                //        start: '2021-09-01'
                //    },
                //    {
                //        title: 'Long Event',
                //        start: '2021-09-07',
                //        end: '2021-09-10'
                //    },
                //    {
                //        groupId: 999,
                //        title: 'Repeating Event',
                //        start: '2021-09-09T16:00:00'
                //    },
                //    {
                //        groupId: 999,
                //        title: 'Repeating Event',
                //        start: '2021-09-16T16:00:00'
                //    },
                //    {
                //        title: 'Conference',
                //        start: '2021-09-11',
                //        end: '2021-09-13'
                //    },
                //    {
                //        title: 'Meeting',
                //        start: '2021-09-12T10:30:00',
                //        end: '2021-09-12T12:30:00'
                //    },
                //    {
                //        title: 'Lunch',
                //        start: '2021-09-12T12:00:00'
                //    },
                //    {
                //        title: 'Meeting',
                //        start: '2021-09-12T14:30:00'
                //    },
                //    {
                //        title: 'Happy Hour',
                //        start: '2021-09-12T17:30:00'
                //    },
                //    {
                //        title: 'Dinner',
                //        start: '2021-09-12T20:00:00'
                //    },
                //    {
                //        title: 'Birthday Party',
                //        start: '2021-09-13T07:00:00'
                //    },
                //    {
                //        title: 'Click for Google',
                //        url: 'http://google.com/',
                //        start: '2021-09-28'
                //    }
                //]
            });

            calendar.render();
           // $('#calendar').fullCalendar('destroy');
          
             // GenerateCalender(events);
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


