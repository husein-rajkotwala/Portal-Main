<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCWeather.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCWeather" %>



<!-- end style for weather-->



<!-- style for weather-->
<script src="/Style Library/script/ccq/assets/Weather/js/vendors.min.js"></script>
<!-- end script for weather-->


                                        <div class="weather">
                                            <div class="d-inline-block">
                                                <img src="/Style Library/script/ccq/img/icons/ic_weather.svg" />
                                            </div>
                                            <div class="weather-info d-inline-block">
                                                <label class="color-prime m-0 font-weight-bold" id="lblCurrentTemp"> 
                                                
                                                
                                                </label>
                                               
                                                <label class="d-block text-center" runat="server"><%=GetLocalResourceObject("Doha")%>
                                                
                                                
                                                
                                                </label>
                                            </div>
                                        </div>
                                
<script>

    $(document).ready(function () {
	
        var settings = {
            beforeSend: function (jqXHR) {
                            if($.ajaxSettings.headers)
								delete $.ajaxSettings.headers.AuthToken;
                            return true;
                        },
            "async": true,
            "crossDomain": true,
            "url": "https://api.openweathermap.org/data/2.5/weather?lat=25.2854&lon=51.5310&units=metric&appid=8419181060b4dc0a4080aca18bcd29b6",
            "method": "GET",
            "processData": false,
            "contentType": false,
            "mimeType": "multipart/form-data",
			

        }
        $.ajax(settings).done(function (response) {
            var data = JSON.parse(response);
            var selector = "#lblCurrentTemp";
        
            $(selector).text(Math.round(data.main.temp) + "°");
            
        })
            .fail(function (response) {
                console.log("error fetching weather data");

            });

    });

</script>
