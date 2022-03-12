<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQNewsUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.MediaCenter.CCQNews.CCQNewsUserControl" %>
<style>
    #pills-newsContent{ 
    max-height: 425px;
    overflow-y: auto;
}

</style>
<div class="news-container">

    <ul class="nav nav-pills nav-justified text-uppercase" id="pills-news" role="tablist">
  
    </ul>
    <div class="tab-content p-1" id="pills-newsContent">
  
    </div>

</div>
<script>
 
    var newsAPIUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/GetNews";
    var newsArray = [];
    function doSuccessNewsdetails(data) {
        var mainNewsTabHtml = "";
        var navtabsHtml = "";
        var newsDetailHtml = "";
        var newsTitle = "";
        var readMore = "";
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
                    readMore = "Read More";
                }
                else {
                    imageDetails = $($(itemNewsDetails.ImageAr)[0]).find("img").attr("src");
                    newsDetailsTile = itemNewsDetails.TitleAr;
                    readMore = "اقرأ أكثر";
                }
                var newsObject = {
                    ID: itemNewsDetails.ID,
                    NewsDetails: itemNewsDetails
                };

                newsArray.push(newsObject);
          
                newsDetailHtml += '<div class="card mb-1">'
                newsDetailHtml += '<div class="row no-gutters">'
                newsDetailHtml += '<div class="col-md-4">'
                newsDetailHtml += '<div class="img-hover-zoom"><img class="img-fluid" src=' + imageDetails + '></div>',
                newsDetailHtml += '</div>',
                newsDetailHtml += ' <div class="col-md-8">',
                newsDetailHtml += '<div class="card-body d-flex flex-column">'
               // newsDetailHtml += '<a href="#" class="card-title-link" data-toggle="modal" data-target="#news_modal"><h5 class="card-title">' + newsDetailsTile + '</h5></a>'
               newsDetailHtml += '<h5 class="card-title">' + newsDetailsTile + '</h5>'

                newsDetailHtml += '<a href="#" class="btn btn-primary align-self-end btnReadMore" data-toggle="modal" data-target="#news_modal" NewsID="' + itemNewsDetails.ID + '">' + readMore + '</a>'
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
    $(document).on('click', '.btnReadMore', function () {
        var newsID = $(this).attr("NewsID");
       var newsArr= jQuery.grep(newsArray, function (n, i) {
           return (n.ID == newsID);
       });
        var newsPopupDetails = newsArr[0].NewsDetails;
        var imageDetails = "";
        var newsDetailsTile = "";
        var newsDetailsDescription = "";
        if (language == "en-us") {
            imageDetails = $($(newsPopupDetails.ImageEn)[0]).find("img").attr("src");
            newsDetailsTile = newsPopupDetails.TitleEn;
            newsDetailsDescription = newsPopupDetails.DescriptionEn;

        }
        else {
            imageDetails = $($(newsPopupDetails.ImageAr)[0]).find("img").attr("src");
            newsDetailsTile = newsPopupDetails.TitleAr;
            newsDetailsDescription = newsPopupDetails.DescriptionAr;
        }
        var mediaBodyHtml = '<p><img src=' + imageDetails + ' class="image_popup border border - dark" alt="...">' + newsDetailsDescription+'</p>';
  
        $("#news_modal_M").text(newsDetailsTile);
        $(".media-body").html(mediaBodyHtml);

       
    });


</script>



 
    
    
<div class="modal fade" id="news_modal" tabindex="-1" aria-labelledby="news_modal_M" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="news_modal_M"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            <div class="media">
                <div class="media-body">
                   
                </div>
            </div>

            </div>
        </div>
    </div>
</div> 