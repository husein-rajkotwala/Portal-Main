<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImageSliderUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.ImageSlider.ImageSliderUserControl" %>
<style>

.carousel-inner .carousel-item {
  transition: -webkit-transform 5s ease;
  transition: transform 5s ease;
  transition: transform 5s ease, -webkit-transform 5s ease;
}
</style>
<script>
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
    var language = lang;
    $(document).ready(function () {
        jQuery.fn.carousel.Constructor.TRANSITION_DURATION = 5000  // 2 seconds

       getImageSlider();

        //$('.carousel').carousel({
        //    interval: false
        //});

    });

    function getImageSlider() {
        var Title = "CCQ Headlines";
        var ID = "";
        var Filter = "isHide eq 0";
        var Select = "";
        var orderBy = "SortOrder asc";
        var top = "";
        var restWeb = new RESTApiHelper.Web(siteUrl);
        var myList = new restWeb.List(Title);
        var items = new myList.Items();
        if (ID != '')
            items.GetItemByID(ID, doSuccess, doError);
        else
            items.GetItems(Select, Filter, orderBy, top, doSuccessImageSlider, doErrorImageSlider);
    }
    

   
    function doSuccessImageSlider(data) {
        var imageSliderHTML = "";
        var liCarouselIndicator = "";
        var imageDetails = "";
        var slideTitle = "";
        var slideDescription = "";
        $.each(data.d.results, function (index, item) {

            if (language == "en-us") {
                imageDetails = $($(item.ImageEn)[0]).find("img").attr("src");
                slideTitle = item.TitleEn;
                slideDescription = item.DescriptionEn;
            }
            else {
                imageDetails = $($(item.ImageAr)[0]).find("img").attr("src");
                slideTitle = item.TitleAr;
                slideDescription = item.DescriptionAr;
            }
           
            if (index == 0) {
                liCarouselIndicator = '<li data-target="#carouselExampleCaptions" data-slide-to=' + index + ' class="active"></li>';
                //imageSliderHTML += '<div class="carousel-item active"><img class="d-block w-100" src=' + item.ImageEn.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleEn + '</h5><p>' + item.DescriptionEn + '</p></div></div>';
                imageSliderHTML = '<div class="carousel-item active" data-mdb-interval="10000">';
                imageSliderHTML += '<img src=' + imageDetails + ' class="d-block w-100" alt=' + slideTitle + '>';
                imageSliderHTML += '<div class="carousel-caption d-none d-md-block">';
                imageSliderHTML += '<h5>' + slideTitle + '</h5>';
                imageSliderHTML += '<p>' + slideDescription + '</p>';
                imageSliderHTML += '</div></div>';
            }
            else {

                liCarouselIndicator += '<li data-target="#carouselExampleCaptions" data-slide-to=' + index + '></li>';
                //imageSliderHTML += '<div class="carousel-item active"><img class="d-block w-100" src=' + item.ImageEn.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleEn + '</h5><p>' + item.DescriptionEn + '</p></div></div>';
                imageSliderHTML += '<div class="carousel-item" data-mdb-interval="10000" >';
                imageSliderHTML += '<img src=' + imageDetails + ' class="d-block w-100" alt=' + slideTitle + '>';
                imageSliderHTML += '<div class="carousel-caption d-none d-md-block">';
                imageSliderHTML += '<h5>' + slideTitle + '</h5>';
                imageSliderHTML += '<p>' + slideDescription + '</p>';
                imageSliderHTML += '</div></div>';
                // imageSliderHTML += '<div class="carousel-item "><img class="d-block w-100" src=' + item.ImageEn.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleEn + '</h5><p>' + item.DescriptionEn + '</p></div></div>';
                //imageSliderHTML += '<div class="item active"><img src=' + item.ImageEn.Url + '  style="width:100%;"></div>'

            }
      
        });

        $("#olCarouselIndicator").html(liCarouselIndicator);
        $("#carouselItems").html(imageSliderHTML);
       
      


    }
    function doErrorImageSlider(err) {
        alert(JSON.stringify(err));
    }
</script>


<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel" data-interval="10000">
    <ol class="carousel-indicators" id="olCarouselIndicator">
     
    </ol>

    <div class="carousel-inner" id="carouselItems">
        
    </div>
    <button class="carousel-control-prev" type="button" data-target="#carouselExampleCaptions" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-target="#carouselExampleCaptions" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </button>
</div>

