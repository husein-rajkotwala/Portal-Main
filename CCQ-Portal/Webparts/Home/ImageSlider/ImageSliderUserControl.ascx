<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImageSliderUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.ImageSlider.ImageSliderUserControl" %>

<script>
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
    var language = lang;
    $(document).ready(function () {
        getImageSlider();
    });

    function getImageSlider() {
        var Title = "CCQ Headlines";
        var ID = "";
        var Filter = "isHide eq 'No'";
        var Select = "";
        var orderBy = "SortOrder asc";
        var top = "3";
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
        $.each(data.d.results, function (index, item) {
            if (language == "en-us") {
                if (index == 0) {
                    imageSliderHTML += '<div class="carousel-item active"><img class="d-block w-100" src=' + item.ImageEn.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleEn + '</h5><p>' + item.DescriptionEn + '</p></div></div>';
                    //imageSliderHTML = '<div class="item active"><img src=' + item.ImageEn.Url + '  style="width:100%;"></div>'
                }
                else {
                    imageSliderHTML += '<div class="carousel-item "><img class="d-block w-100" src=' + item.ImageEn.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleEn + '</h5><p>' + item.DescriptionEn + '</p></div></div>';
                    //imageSliderHTML += '<div class="item active"><img src=' + item.ImageEn.Url + '  style="width:100%;"></div>'

                }
                
            }
            else {
                if (index == 0) {
                    imageSliderHTML = '<div class="carousel-item active"><img class="d-block w-100" src=' + item.ImageAr.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleAr + '</h5><p>' + $(item.DescriptionAr).text() + '</p></div></div>';

                }
                else {



                    imageSliderHTML += '<div class="carousel-item"><img class="d-block w-100" src=' + item.ImageAr.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleAr + '</h5><p>' + $(item.DescriptionAr).text() + '</p></div></div>';
                }
            }

        });
        $("#carouselItems").html(imageSliderHTML);


    }
    function doErrorImageSlider(err) {
        alert(JSON.stringify(err));
    }
</script>

<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width:800px !important">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner" id="carouselItems">
 
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>