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
.carousel-control-next-icon { 
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%233eaaf5' width='8' height='8' viewBox='0 0 8 8'%3e%3cpath d='M2.75 0l-1.5 1.5L3.75 4l-2.5 2.5L2.75 8l4-4-4-4z'/%3e%3c/svg%3e");
}

.carousel-control-prev-icon {
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%233eaaf5' width='8' height='8' viewBox='0 0 8 8'%3e%3cpath d='M5.25 0l-4 4 4 4 1.5-1.5L4.25 4l2.5-2.5L5.25 0z'/%3e%3c/svg%3e");
}
.carousel-indicators > li{ 
    border-radius: 50%;
    width: 12px;
    height: 12px;
    background-color: #3eaaf5;
}

</style>
<script>
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
    var language = lang;
    $(document).ready(function () {
        jQuery.fn.carousel.Constructor.TRANSITION_DURATION = 5000  // 2 seconds
        SP.SOD.executeFunc("sp.js", "SP.ClientContext", function () {
            GetImageSlides();
        });
        //$('.carousel').carousel({
        //    interval: false
        //});

    });
    function GetImageSlides() {
        var clientContext = new SP.ClientContext.get_current();
        var oList = clientContext.get_web().get_lists().getByTitle('CCQ Headlines');
        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml("<View><Query><Where><And><Leq><FieldRef Name='HeadLineStartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Leq><Geq><FieldRef Name='HeadLineEndDate' /><Value Type='DateTime'>" + moment().toISOString() +"</Value></Geq></And></Where></Query></View>");
        this.collListItem = oList.getItems(camlQuery);
        clientContext.load(collListItem);
        clientContext.executeQueryAsync(function () {
            var listItemInfo = '';
            var listItemEnumerator = collListItem.getEnumerator();
            while (listItemEnumerator.moveNext()) {
                var oListItem = listItemEnumerator.get_current();
                listItemInfo += '\nID: ' + oListItem.get_id() + '  Title: ' + oListItem.get_item('Title');
            }
            console.log(listItemInfo.toString());
        }, function (sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        });
    }
    function getImageSlider() {
    
       

        var Title = "CCQ Headlines";
        var ID = "";
        var today = new Date(new Date().setDate(new Date().getDate()));

        var Filter = "HeadLineStartDate leq datetime'" + today.toISOString() + "' and HeadLineEndDate geq datetime'" + today.toISOString() + "'";

        //moment().toISOString();
        var orderBy = "SortOrder asc";
        var top = "";
        var restWeb = new RESTApiHelper.Web(siteUrl);
        var myList = new restWeb.List(Title);
        var items = new myList.Items();
        var url = _spPageContextInfo.siteAbsoluteUrl + "/_api/web/lists/GetByTitle('" + Title + "')/items?$filter=" + Filter;



        jQuery.ajax({
            url: url,

            type: "GET",
            headers: { "Accept": "application/json; odata=verbose" },
            success: doSuccessImageSlider,
            error: doErrorImageSlider
        });
      
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
               // slideDescription = item.DescriptionEn;
            }
            else {
                imageDetails = $($(item.ImageAr)[0]).find("img").attr("src");
                slideTitle = item.TitleAr;
                //slideDescription = item.DescriptionAr;
            }
           
            if (index == 0) {
                liCarouselIndicator = '<li data-target="#carouselExampleCaptions" data-slide-to=' + index + ' class="active"></li>';
                //imageSliderHTML += '<div class="carousel-item active"><img class="d-block w-100" src=' + item.ImageEn.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleEn + '</h5><p>' + item.DescriptionEn + '</p></div></div>';
                imageSliderHTML = '<div class="carousel-item active" data-mdb-interval="10000">';
                imageSliderHTML += '<img src=' + imageDetails + ' class="d-block w-100" alt=' + slideTitle + '>';
              
               
                imageSliderHTML += '</div>';
            }
            else {

                liCarouselIndicator += '<li data-target="#carouselExampleCaptions" data-slide-to=' + index + '></li>';
                //imageSliderHTML += '<div class="carousel-item active"><img class="d-block w-100" src=' + item.ImageEn.Url + '><div class="carousel-caption d-none d-md-block"><h5>' + item.TitleEn + '</h5><p>' + item.DescriptionEn + '</p></div></div>';
                imageSliderHTML += '<div class="carousel-item" data-mdb-interval="10000" >';
                imageSliderHTML += '<img src=' + imageDetails + ' class="d-block w-100" alt=' + slideTitle + '>';
          
                imageSliderHTML += '</div>';
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

