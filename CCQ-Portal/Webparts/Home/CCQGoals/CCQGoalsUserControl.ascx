<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQGoalsUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.CCQGoals.CCQGoalsUserControl" %>



<ul class="nav nav-pills nav-justified" id="pills-tab1" role="tablist">

</ul>
<div class="tab-content p-3" id="pills-tab1Content">

</div>

<script>

    var goalAPIUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/GetGoals";
    function doSuccessGoaldetails(data) {
        var mainGoalTabHtml = "";
        var navtabsHtml = "";
        var goalDetailHtml = "";
        var goalTitle = "";
        $.each(data, function (index, item) {
            goalTitle = "";

            if (language == "en-us") {
                goalTitle = item.TitleEn
            }
            else {
                goalTitle = item.TitleAr
            }
            if (index == 0) {
                navtabsHtml = '<li class="nav-item text-center" role="presentation"><a class="nav-link active" id="pills-' + item.TitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.TitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.TitleEn.replace(" ", "") + '" aria-selected="true">' + item.HtmlEn + '</a></li>';
            }
            else {
                navtabsHtml += '<li class="nav-item text-center" role="presentation"><a class="nav-link" id="pills-' + item.TitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.TitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.TitleEn.replace(" ", "") + '" aria-selected="true">' + item.HtmlAr + '</a></li>';
            }
            goalDetailHtml = "";
            $.each(item.GoalType, function (indexGoalDetails, itemGoalDetails) {
                var goalsDetailsLength = item.GoalType.length - 1;
                var goalDetailsTile = "";
                var goalDetailsDesc = "";
                if (language == "en-us") {
                   
                    goalDetailsTile = itemGoalDetails.TitleEn;
                    goalDetailsDesc = itemGoalDetails.DescriptionEn;
                }
                else {
                  
                    goalDetailsTile = itemGoalDetails.TitleAr;
                    goalDetailsDesc = itemGoalDetails.DescriptionAr;

                }
                if (indexGoalDetails == 0) {
                    goalDetailHtml += '<div class="card"><div class="card-header" id="heading' + indexGoalDetails + '">';
                    goalDetailHtml += '<h2 class="mb-0">';
                    goalDetailHtml += '<button class="btn btn-link btn-block text-left-cust accordion-header" type="button" data-toggle="collapse" data-target="#collapse' + indexGoalDetails + '" aria-expanded="true" aria-controls="collapse' + indexGoalDetails + '">';
                    goalDetailHtml += goalDetailsTile + '</button></h2></div>';
                    goalDetailHtml += '<div id="collapse' + indexGoalDetails + '" class="collapse show" aria-labelledby="heading' + indexGoalDetails + '" data-parent="#accordion' + item.TitleEn.replace(" ", "") + '">';
                    goalDetailHtml += '<div class="card-body">';
                    goalDetailHtml += goalDetailsDesc;
                    goalDetailHtml += '</div></div></div>';
                }
                else {
                    goalDetailHtml += '<div class="card"><div class="card-header" id="heading' + indexGoalDetails + '">';
                    goalDetailHtml += '<h2 class="mb-0">';
                    goalDetailHtml += '<button class="btn btn-link btn-block text-left-cust accordion-header" type="button" data-toggle="collapse" data-target="#collapse' + indexGoalDetails + '" aria-expanded="false" aria-controls="collapse' + indexGoalDetails + '">';
                    goalDetailHtml += goalDetailsTile + '</button></h2></div>';
                    goalDetailHtml += '<div id="collapse' + indexGoalDetails + '" class="collapse" aria-labelledby="heading' + indexGoalDetails + '" data-parent="#accordion' + item.TitleEn.replace(" ", "") + '">';
                    goalDetailHtml += '<div class="card-body">';
                    goalDetailHtml += goalDetailsDesc;
                    goalDetailHtml += '</div></div></div>';
                }

              

                if (indexGoalDetails == goalsDetailsLength) {

                    if (index == 0) {
                        mainGoalTabHtml = '<div class="tab-pane fade show active" id="pills-' + item.TitleEn.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + item.TitleEn.replace(" ", "") + '-tab"><div class="accordion" id="accordion' + item.TitleEn.replace(" ", "") + '">' + goalDetailHtml + '</div></div>';



                    }
                    else {
                        mainGoalTabHtml += '<div class="tab-pane fade show" id="pills-' + item.TitleEn.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + item.TitleEn.replace(" ", "") + '-tab"><div class="accordion" id="accordion' + item.TitleEn.replace(" ", "") + '">' + goalDetailHtml + '</div></div>';

                    }
                }

            });
        });
        $("#pills-tab1").html(navtabsHtml);
        $("#pills-tab1Content").html(mainGoalTabHtml);
    }
    function getApiGoals() {
        $.ajax({

            contentType: "application/json; charset=utf-8",

            data: {},

            dataType: "json",

            type: "POST",

            url: goalAPIUrl,
            success: function (result) {
                var output = result.d;
                console.log(output);
                doSuccessGoaldetails(output);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert('Error occured');
               
                if (jqXHR.status == 500) {
                    console.log('Internal error: ' + jqXHR.responseText);
                } else {
                    console.log('Unexpected error.');
                }
            }

        });
    }
    $(document).ready(function () {
        getApiGoals();
        //  getNewsMaster();
    });


</script>