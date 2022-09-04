<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EtqanUpcomingAnnouncementUserControl.ascx.cs" Inherits="CCQ_Etqan.Webparts.Home.EtqanUpcomingAnnouncement.EtqanUpcomingAnnouncementUserControl" %>
<script src="/Style%20Library/Script/ccq/assets/Events/moment.min.js"></script>

<div class="announcement-container py-3 px-4">
            <div id="dvupcomingAnnocements" class="owl-carousel owl-theme">

            </div>
        </div>

<script>

    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
    var collUpcomingAnnocementListItem;

    $(document).ready(function () {

        SP.SOD.executeFunc("sp.js", "SP.ClientContext", function () {
            GetUpcomingAnnocements();
        });


    });

    function GetUpcomingAnnocements() {
        var collListItem;
        var clientContext = new SP.ClientContext.get_current();
        var upcomingAnnocementList = clientContext.get_web().get_lists().getByTitle('Etqan Announcement');
        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='StartDate' /><FieldRef Name='EndDate' /><FieldRef Name='Title' /><FieldRef Name='Description' /></ViewFields><Query><Where><And><Leq><FieldRef Name='StartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Leq><Geq><FieldRef Name='EndDate' /><Value Type='DateTime'>" + moment().toISOString() +"</Value></Geq></And></Where></Query></View>");
        collUpcomingAnnocementListItem = upcomingAnnocementList.getItems(camlQuery);
        clientContext.load(collUpcomingAnnocementListItem);
        clientContext.executeQueryAsync(function () {
            var listItemInfo = '';
            var listItemEnumerator = collUpcomingAnnocementListItem.getEnumerator();

            var index = 0;
            var upcomingAnnocementHtml = "";
            while (listItemEnumerator.moveNext()) {
                var oListItem = listItemEnumerator.get_current();
                //var startDateMonth = moment(oListItem.get_item("StartDate")).format('MMMM');
  

                var workShopTitle = oListItem.get_item("Title");
               
                upcomingAnnocementHtml += '<div class="item text-center">';
                upcomingAnnocementHtml += '<a href="#">' + workShopTitle+'</a>';

          
                upcomingAnnocementHtml += '</div>';
                index++;

            }

            $("#dvupcomingAnnocements").html(upcomingAnnocementHtml);
            if (index > 0) {
                var responsive
                if (index == 1) {
                    responsive= {
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
                    else
                    {
                        responsive= {
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
                $('#dvupcomingAnnocements').owlCarousel({
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
        }, function (sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        });
    }

</script>