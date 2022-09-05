<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UpComingWorkShopsUserControl.ascx.cs" Inherits="CCQ_Etqan.Webparts.Home.UpComingWorkShops.UpComingWorkShopsUserControl" %>

<script>
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
   
    $(document).ready(function () {
    
        SP.SOD.executeFunc("sp.js", "SP.ClientContext", function () {
            GetUpcomingWorkshops();
        });
        

    });
    function GetUpcomingWorkshops() {
        var collListItem;
        var clientContext = new SP.ClientContext.get_current();
        var upcomingWorkShopList = clientContext.get_web().get_lists().getByTitle('CCQWorkshops');
        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='StartDate' /><FieldRef Name='EndDate' /><FieldRef Name='Level' /><FieldRef Name='Instructor' /><FieldRef Name='Title' /><FieldRef Name='ID' /><FieldRef Name='Description' /></ViewFields><Query><Where><And><Geq><FieldRef Name='StartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Geq><Eq><FieldRef Name='Active' /><Value Type='Boolean'>1</Value></Eq></And></Where><OrderBy><FieldRef Name='StartDate' /></OrderBy></Query></View>");
        collUpcomingWorkshopListItem = upcomingWorkShopList.getItems(camlQuery);
        clientContext.load(collUpcomingWorkshopListItem);
        clientContext.executeQueryAsync(function () {
            var listItemInfo = '';
            var listItemEnumerator = collUpcomingWorkshopListItem.getEnumerator();

            var index = 0;
            var upcomingWorkshopHtml = "";
            while (listItemEnumerator.moveNext()) {
                var oListItem = listItemEnumerator.get_current();
               
                //var startDateMonth = moment(oListItem.get_item("StartDate")).format('MMMM');
                var startDate = moment(oListItem.get_item("StartDate")).format('Do MMMM  YYYY, h:mm a');
                var starDateArr = startDate.split(',');
                var Id = oListItem.get_item("ID");
                var workShopTitle = oListItem.get_item("Title");
                var workShopDescription = oListItem.get_item("Description");
                var workshopDetailsUrl = _spPageContextInfo.webAbsoluteUrl + "/Pages/EtqanWorkshopDetails.aspx?WorkshopId=" + Id;
                upcomingWorkshopHtml += '<div class="item">';
                upcomingWorkshopHtml += '<div class="card">';
                upcomingWorkshopHtml += '<div class="card-body">';
                upcomingWorkshopHtml += '<h5 class="card-title"><a href=' + workshopDetailsUrl + ' class="stretched-link"><i class="fas fa-chalkboard-teacher"></i> ' + workShopTitle + '</a></h5>';
                upcomingWorkshopHtml += '<ul class="workshops-attr">';
                upcomingWorkshopHtml += '<li><span class="text-muted"><i class="fas fa-calendar-alt text-muted"></i>' + starDateArr[0] + '</span></li>';
                upcomingWorkshopHtml += '<li><span class="text-muted"><i class="far fa-clock text-muted"></i>' + starDateArr[1] + '</span></li>';
                upcomingWorkshopHtml += '</ul>';
                upcomingWorkshopHtml += '<p class="card-text">' + workShopDescription + '</p>';
                upcomingWorkshopHtml += '<a href="reg_form.html" class="btn btn-outline-primary">تسجيل <i class="far fa-arrow-alt-circle-left"></i></a>';
                upcomingWorkshopHtml += '</div>';
                upcomingWorkshopHtml += '</div>';
                upcomingWorkshopHtml += '</div>';
                index++;
            }

            $("#owl1").html(upcomingWorkshopHtml);
            if (index > 0) {
                var responsive
                if (index == 1) {
                    responsive = {
                        0: {
                            loop: true,
                            items: 1
                        }
                    }



                }
                else if (index == 2) {
                    responsive = {
                        0: {
                            loop: true,
                            items: 1,
                            nav: true
                        },
                        600: {
                            loop: true,
                            items: 2,
                            nav: true
                        }
                    }
                }
                else {
                    responsive = {
                        0: {
                            loop: true,
                            items: 1,
                            nav: true
                        },
                        600: {
                            loop: true,
                            items: 2,
                            nav: true
                        },
                        1000: {
                            loop: true,
                            items: 3,
                            nav: true
                        }
                    }
                }

                //$("#carouselItems").html(imageSliderHTML);
                $('#owl1').owlCarousel({
                    loop: true,
                    rtl: true,
                    margin: 30,
                    responsiveClass: true,
                    autoplay: true,
                    autoplayTimeout: 3000,
                    stagePadding: 3,
                    dots: false,
                    autoplayHoverPause: true,
                    navText: ["<i class='fas fa-angle-right fa-lg'></i>", "<i class='fas fa-angle-left fa-lg'></i>"],
                    responsive: responsive

                });
            }
            //$("#carouselItems").html(imageSliderHTML);
        }, function (sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        });
    }

    

   

</script>

<div class="latest-workshops py-5 px-4">
            <h4 class="text-center pb-3">الورش</h4>
            <div id="owl1" class="owl-carousel owl-theme">


              

            </div>
        </div>
