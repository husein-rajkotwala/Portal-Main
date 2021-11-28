<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCPrayerTime.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCPrayerTime" %>

<script>
    var language = lang;
$(document).ready(function() {
    var prayterNames = {"Fajr": "الفجر","Dhuhr": "الظهر","Asr": "العصر","Maghrib": "المغرب","Isha": "العشاء"};


	
    var settings = {
         beforeSend: function (jqXHR) {
                            if($.ajaxSettings.headers)
								delete $.ajaxSettings.headers.AuthToken;
                            return true;
                        },
		"crossDomain":true,
        "datatype": "json",
        "url": "https://api.aladhan.com/v1/timingsByCity?city=Doha&country=Qatar&method=10",
        "method": "GET",
        "headers": {
            "accept": "application/json",
        }
    }

    $.ajax(settings).done(function(response) {

        var excludedTimes = ["Imsak", "Sunrise", "Sunset", "Midnight"];
        var currentDateTime = new Date();
        var timings = Object.keys(response.data.timings).map((key) => [String(key), response.data.timings[key]]);
        timings = timings.sort(CompareTimings);
        var nextPrayerTime = ['Fajr', response.data.timings.Fajr];
        for (var i = 0; i < timings.length - 1; i++) {
            if (AddTimeInCurrentDate(timings[i][1]) > currentDateTime && excludedTimes.indexOf(timings[i][0]) < 0) {
                nextPrayerTime = timings[i];
                break;
            }
        }

        if (language == "en-us") {
            $('.prayer_laber').text(nextPrayerTime[0]);
        } 
      else {

               $('.prayer_laber').text(prayterNames[nextPrayerTime[0]]);
           }
        $('.prayer_timing').text(nextPrayerTime[1]);

    });
});

function CompareTimings(timingA, timingB) {

    if (AddTimeInCurrentDate(timingA[1]) < AddTimeInCurrentDate(timingB[1]))
        return -1
    else if (AddTimeInCurrentDate(timingA[1]) > AddTimeInCurrentDate(timingB[1])) {
        return 1;
    }
    return 0;
}

var AddTimeInCurrentDate = function(time) {

    var splittedTime = time.split(':');
    if (splittedTime.length <= 0) {
        console.log("Invalid time format:" + time);
        return;
    }
    var currentDate = new Date();
    var currentDateWithoutTime = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate());
    currentDateWithoutTime.setHours(parseInt(splittedTime[0]));
    if (splittedTime.length > 1)
        currentDateWithoutTime.setMinutes(parseInt(splittedTime[1]));
    if (splittedTime.length > 2)
        currentDateWithoutTime.setSeconds(parseInt(splittedTime[2]));
    return currentDateWithoutTime;
};

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


<div class="prayer">
                                            <div class="ico d-inline-block">
                                                <img src="/Style Library/script/ccq/img/icons/ic_prayer.svg" class="" />
                                            </div>
                                            <div class="prayer-info d-inline-block">
                                                <label class="color-prime m-0 font-weight-bold prayer_timing" > 
                                                
                                                
                                                
                                                </label>
                                                
                                                <label class="d-block text-center prayer_laber">
                                                
                                                
                                                
                                                </label>
                                            </div>
                                        </div>
