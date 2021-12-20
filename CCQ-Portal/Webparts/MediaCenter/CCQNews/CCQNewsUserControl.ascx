<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQNewsUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.MediaCenter.CCQNews.CCQNewsUserControl" %>
<div class="news-container">

    <ul class="nav nav-pills nav-justified text-uppercase" id="pills-news" role="tablist">
  
    </ul>
    <div class="tab-content p-1" id="pills-newsContent">
  
    </div>

</div>
<script>
  
    var newsAPIUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/GetNews";
    function doSuccessNewsdetails(data) {
        var mainNewsTabHtml = "";
        var navtabsHtml = "";
        var newsDetailHtml = "";
        var newsTitle = "";
        $.each(data, function (index, item) {
             newsTitle = "";

            if (language == "en-us") {
                newsTitle = item.NewsTitleEn
            }
            else {
                newsTitle = item.NewsTitleAr
            }
            if (index == 0) {
                navtabsHtml = '<li class="nav-item text-center" role="presentation"><a class="nav-link active" id="pills-' + item.NewsTitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.NewsTitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.NewsTitleEn.replace(" ", "") + '" aria-selected="true">' + newsTitle + '</a></li>';
            }
            else {
                navtabsHtml += '<li class="nav-item text-center" role="presentation"><a class="nav-link" id="pills-' + item.NewsTitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.NewsTitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.NewsTitleEn.replace(" ", "") + '" aria-selected="true">' + newsTitle + '</a></li>';

            }
            newsDetailHtml = "";
            $.each(item.NewsType, function (indexNewsDetails, itemNewsDetails) {
                var newsDetailsLength = item.NewsType.length - 1;
                var imageDetails = "";
                var newsDetailsTile = "";
                if (language == "en-us") {
                    imageDetails = $($(itemNewsDetails.ImageEn)[0]).find("img").attr("src");
                    newsDetailsTile = itemNewsDetails.TitleEn;
                }
                else {
                    imageDetails = $($(itemNewsDetails.ImageAr)[0]).find("img").attr("src");
                    newsDetailsTile = itemNewsDetails.TitleAr;
                }
          
                newsDetailHtml = '<div class="card mb-1">'
                newsDetailHtml += '<div class="row no-gutters">'
                newsDetailHtml += '<div class="col-md-4">'
                newsDetailHtml += '<div class="img-hover-zoom"><img class="img-fluid" src=' + imageDetails + '></div>',
                newsDetailHtml += '</div>',
                newsDetailHtml += ' <div class="col-md-8">',
                newsDetailHtml += '<div class="card-body d-flex flex-column">'
                newsDetailHtml += '<a href="#" class="card-title-link"><h5 class="card-title">' + newsDetailsTile + '</h5></a>'
                newsDetailHtml += '<button href="#" class="btn btn-primary align-self-end">Read More</button>'
                newsDetailHtml += '</div></div></div></div>';
                if (indexNewsDetails == newsDetailsLength) {
                    if (index == 0) {
                        mainNewsTabHtml = '<div class="tab-pane fade show active" id="pills-' + item.NewsTitleEn.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + item.NewsTitleEn.replace(" ", "") + '-tab">' + newsDetailHtml + '</div>';


                    }
                    else {
                        mainNewsTabHtml += '<div class="tab-pane fade show" id="pills-' + item.NewsTitleEn.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + item.NewsTitleEn.replace(" ", "") + '-tab">' + newsDetailHtml + '</div>';

                    }

                }
            });
        });
        $("#pills-news").html(navtabsHtml);
        $("#pills-newsContent").html(mainNewsTabHtml);
    }
    function getApiNews() {
        $.ajax({

            contentType: "application/json; charset=utf-8",

            data: {},

            dataType: "json",

            type: "POST",

            url: newsAPIUrl,
            success: function (result) {
                var output = result.d;
                console.log(output);
                doSuccessNewsdetails(output);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert('Error occured');
                hideLoader();
                if (jqXHR.status == 500) {
                    console.log('Internal error: ' + jqXHR.responseText);
                } else {
                    console.log('Unexpected error.');
                }
            }

        });
    }
    $(document).ready(function () {
       getApiNews();
     //  getNewsMaster();
    });


</script>