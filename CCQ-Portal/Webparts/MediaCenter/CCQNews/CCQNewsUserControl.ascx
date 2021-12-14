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
     <%--   <li class="nav-item text-center" role="presentation">
            <a class="nav-link active" id="pills-news1-tab" data-toggle="pill" href="#pills-news1" role="tab" aria-controls="pills-news1" aria-selected="true">News</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="pills-news2-tab" data-toggle="pill" href="#pills-news2" role="tab" aria-controls="pills-news2" aria-selected="false">New Joiners</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="pills-news3-tab" data-toggle="pill" href="#pills-news3" role="tab" aria-controls="pills-news3" aria-selected="false">Classified Ads</a>
        </li>--%>
    </ul>
    <div class="tab-content p-1" id="pills-newsContent">
     <%--   <div class="tab-pane fade show active" id="pills-news1" role="tabpanel" aria-labelledby="pills-news1-tab">

            <div class="card mb-1">
              <div class="row no-gutters">
                <div class="col-md-4">
                  <div class="img-hover-zoom"><img class="img-fluid" src="/Style%20Library/Branding/images/CCQNews_10_01_2021_01.jpg" alt="..."></div>
                </div>
                <div class="col-md-8">
                  <div class="card-body d-flex flex-column">
                    <a href="#" class="card-title-link"><h5 class="card-title">CCQ announces the implementation of the second phase of on-campus full attendance</h5></a>
                    <button href="#" class="btn btn-primary align-self-end">Read More</button>
                  </div>
                </div>
              </div>
            </div>

            <div class="card mb-1">
              <div class="row no-gutters">
                <div class="col-md-4">
                  <div class="img-hover-zoom"><img class="img-fluid" src="/Style%20Library/Branding/images/CCQNews_16_11_2021_01.jpg" alt="..."></div>
                </div>
                <div class="col-md-8">
                  <div class="card-body d-flex flex-column">
                    <a href="#" class="card-title-link"><h5 class="card-title">Community College of Qatar honors outstanding students who are on the Dean's List and Honor List</h5></a>
                    <a href="#" class="btn btn-primary align-self-end">Read More</a>
                  </div>
                </div>
              </div>
            </div>

        </div>--%>
<%--        <div class="tab-pane fade" id="pills-news2" role="tabpanel" aria-labelledby="pills-news2-tab">
            <div class="card mb-1">
              <div class="row no-gutters">
                <div class="col-md-4">
                  <div class="img-hover-zoom"><img class="img-fluid" src="/Style%20Library/Branding/images/CCQNews_23_11_2021_01.jpg" alt="..."></div>
                </div>
                <div class="col-md-8">
                  <div class="card-body d-flex flex-column">
                    <a href="#" class="card-title-link"><h5 class="card-title">A delegation from Hamad bin Khalifa visits the Community College of Qatar</h5></a>
                    <button href="#" class="btn btn-primary align-self-end">Read More</button>
                  </div>
                </div>
              </div>
            </div>

            <div class="card mb-1">
              <div class="row no-gutters">
                <div class="col-md-4">
                  <div class="img-hover-zoom"><img class="img-fluid" src="/Style%20Library/Branding/images/CCQNews_21_03_2021_01.jpg" alt="..."></div>
                </div>
                <div class="col-md-8">
                  <div class="card-body d-flex flex-column">
                    <a href="#" class="card-title-link"><h5 class="card-title">CCQ, Doha Institute for Graduate Studies Sign MoU</h5></a>
                    <a href="#" class="btn btn-primary align-self-end">Read More</a>
                  </div>
                </div>
              </div>
            </div>

        </div>
        <div class="tab-pane fade" id="pills-news3" role="tabpanel" aria-labelledby="pills-news3-tab">

            <div class="card mb-1">
              <div class="row no-gutters">
                <div class="col-md-4">
                  <div class="img-hover-zoom"><img class="img-fluid" src="/Style%20Library/Branding/images/CCQNews_29_12_2020_01.jpg" alt="..."></div>
                </div>
                <div class="col-md-8">
                  <div class="card-body d-flex flex-column">
                    <a href="#" class="card-title-link"><h5 class="card-title">Huawei and Community College of Qatar announce partnership to develop local talent through the ICT academy</h5></a>
                    <button href="#" class="btn btn-primary align-self-end">Read More</button>
                  </div>
                </div>
              </div>
            </div>

            <div class="card mb-1">
              <div class="row no-gutters">
                <div class="col-md-4">
                  <div class="img-hover-zoom"><img class="img-fluid" src="/Style%20Library/Branding/images/CCQNews_17_08_2021_01.jpg" alt="..."></div>
                </div>
                <div class="col-md-8">
                  <div class="card-body d-flex flex-column">
                    <a href="#" class="card-title-link"><h5 class="card-title">CCQ Announces Fall 2021 Classes to Take Place Online</h5></a>
                    <a href="#" class="btn btn-primary align-self-end">Read More</a>
                  </div>
                </div>
              </div>
            </div>

        </div>--%>
    </div>

</div>
<script>
    var newsSiteUrl = _spPageContextInfo.siteAbsoluteUrl + '/MediaCenter';
    var language = lang;
    var newsMasterListTitle = "CCQNewsMaster";
    var ID = "";
    var newsMasterArr = [];
    var newsTabArr = [];
    var methodUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/getNews";

    function getApiNews() {
        $.ajax({

            contentType: "application/json; charset=utf-8",

            data: {},

            dataType: "json",

            type: "POST",

            url: methodUrl,
            success: function (result) {
                var output = result.d;
                console.log(output);
              
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
        //getNewsMaster();
    });
   /// url: newsSiteUrl + "/_api/web/lists/GetByTitle('" + newsListTitle + "')/items?$select=Title,TitleEn,TitleAr,DescriptionEn,ImageEn,ImageAr,DescriptionAr,NewsType/TitleEn,NewsType/TitleAr,NewsType/isHide&$expand=NewsType&$orderby=NewsType/SortOrder,NewsSortOrder",

    function getNewsDetails() {

        jQuery.ajax({
            url: newsSiteUrl + "/_api/web/lists/GetByTitle('CCQNews')/items?$select=Title,TitleEn,TitleAr,DescriptionEn,ImageEn,ImageAr,DescriptionAr,NewsType/TitleEn,NewsType/TitleAr&$expand=NewsType&$orderby=NewsType/SortOrder,NewsSortOrder&$filter=isHide eq 0",
            type: "GET",
            headers: { "Accept": "application/json; odata=verbose" },
            success: doSuccessNewsdetails,
            error: doErrorNewsdetails
        });
    }

    function getNewsMaster() {

        jQuery.ajax({
            url: newsSiteUrl + "/_api/web/lists/getbytitle('CCQNewsMaster')/Items?$filter=isHide eq 0",
            type: "GET",
            headers: { "Accept": "application/json; odata=verbose" },

        }).done(function (data) {
            $.each(data.d.results, function (index, item) {

                var objNewsTabbedMaster = new Object();
                objNewsTabbedMaster["TitleEn"] = item.TitleEn;
                objNewsTabbedMaster["TitleAr"] = item.TitleAr;
                objNewsTabbedMaster["Title"] = item.Title;
                newsMasterArr.push(objNewsTabbedMaster);
            });
            getNewsDetails();
        }).fail(function (err) {

        });
        

        

    }
        function doSuccessNewsdetails(data) {

            var mainNewsTabHtml = "";
            var navtabsHtml = "";
            var newsDetailHtml = "";
            var dataResultsLength = data.d.results.length - 1;
            $.each(data.d.results, function (index, item) {
                var imageUrl = "";
                if (item.NewsType.TitleEn != null && item.NewsType.TitleEn != "" && item.NewsType.TitleEn != "undefined")
                    var NewsType = item.NewsType.TitleEn;
                var imageEn = $($(item.ImageEn)[0]).find("img").attr("src");
                var imageAr = $($(item.ImageAr)[0]).find("img").attr("src");
                var NewsTypeJSON = {
                    "NewsType": item.NewsType.TitleEn,
                    "TitleEn": item.TitleEn,
                    "TitleAr": item.TitleAr,
                    "ImageEn": imageEn,
                    "ImageAr": imageAr

                };
                var result = newsTabArr.filter(x => x.NewsType === item.NewsType.TitleEn);
                if (language == "en-us") {



                    if (result.length == 0) {
                        if (index == 0) {

                            navtabsHtml = '<li class="nav-item text-center" role="presentation"><a class="nav-link active" id="pills-' + item.NewsType.TitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.NewsType.TitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.NewsType.TitleEn.replace(" ", "") + '" aria-selected="true">' + item.NewsType.TitleEn + '</a></li>';

                        }
                        else {
                           
                            navtabsHtml += '<li class="nav-item text-center" role="presentation"><a class="nav-link" id="pills-' + item.NewsType.TitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.NewsType.TitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.NewsType.TitleEn.replace(" ", "") + '" aria-selected="true">' + item.NewsType.TitleEn + '</a></li>';
                          
                            if (newsTabArr.length == 1) {
                                mainNewsTabHtml = '<div class="tab-pane fade show active" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '-tab">' + newsDetailHtml+'</div>';
                            }
                            else {
                                mainNewsTabHtml += '<div class="tab-pane fade show" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '-tab">' + newsDetailHtml + '</div>';

                            }
                           
                        }
                        newsTabArr.push(NewsTypeJSON);
                       
                        newsDetailHtml = "";
                        newsDetailHtml = '<div class="card mb-1">'
                        newsDetailHtml += '<div class="row no-gutters">'
                        newsDetailHtml += '<div class="col-md-4">'
                        newsDetailHtml += '<div class="img-hover-zoom"><img class="img-fluid" src=' + newsTabArr[newsTabArr.length - 1].ImageEn + '></div>',
                        newsDetailHtml += '</div>',
                        newsDetailHtml+= ' <div class="col-md-8">',
                        newsDetailHtml += '<div class="card-body d-flex flex-column">'
                        newsDetailHtml += '<a href="#" class="card-title-link"><h5 class="card-title">' + newsTabArr[newsTabArr.length - 1].TitleEn + '</h5></a>'
                        newsDetailHtml+= '<button href="#" class="btn btn-primary align-self-end">Read More</button>'
                        newsDetailHtml+= '</div></div></div></div>';
                                        
                                           
                            
                    }
                    else {
                        
                        newsDetailHtml = '<div class="card mb-1">'
                        newsDetailHtml += '<div class="row no-gutters">'
                        newsDetailHtml += '<div class="col-md-4">'
                        newsDetailHtml += '<div class="img-hover-zoom"><img class="img-fluid" src=' + imageEn + '></div>',
                            newsDetailHtml += '</div>',
                            newsDetailHtml += ' <div class="col-md-8">',
                            newsDetailHtml += '<div class="card-body d-flex flex-column">'
                        newsDetailHtml += '<a href="#" class="card-title-link"><h5 class="card-title">' + item.TitleEn + '</h5></a>'
                        newsDetailHtml += '<button href="#" class="btn btn-primary align-self-end">Read More</button>'
                        newsDetailHtml += '</div></div></div></div>';

                       // newsDetailHtml += '<div class="tab-pane fade show active" id="pills-' + item.NewsType.TitleEn + '" role="tabpanel" aria-labelledby="pills-' + item.NewsType.TitleEn + '-tab"></div>';

                    }


                    if (index == dataResultsLength && newsTabArr.length > 1) {
                        mainNewsTabHtml += '<div class="tab-pane fade show" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType + '-tab">' + newsDetailHtml + '</div>';

                    }
                    else {
                        mainNewsTabHtml += '<div class="tab-pane fade show active" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType + '-tab">' + newsDetailHtml + '</div>';

                    }
                }

                else {



                    if (result.length == 0) {
                        if (index == 0) {

                            navtabsHtml = '<li class="nav-item text-center" role="presentation"><a class="nav-link active" id="pills-' + item.NewsType.TitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.NewsType.TitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.NewsType.TitleEn.replace(" ", "") + '" aria-selected="true">' + item.NewsType.TitleAr + '</a></li>';

                        }
                        else {

                            navtabsHtml += '<li class="nav-item text-center" role="presentation"><a class="nav-link" id="pills-' + item.NewsType.TitleEn.replace(" ", "") + '-tab" data-toggle="pill" href="#pills-' + item.NewsType.TitleEn.replace(" ", "") + '" role="tab" aria-controls="pills-' + item.NewsType.TitleEn.replace(" ", "") + '" aria-selected="true">' + item.NewsType.TitleAr + '</a></li>';

                            if (newsTabArr.length == 1) {
                                mainNewsTabHtml = '<div class="tab-pane fade show active" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '-tab">' + newsDetailHtml + '</div>';
                            }
                            else {
                                mainNewsTabHtml += '<div class="tab-pane fade show" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '-tab">' + newsDetailHtml + '</div>';

                            }

                        }
                        newsTabArr.push(NewsTypeJSON);

                        newsDetailHtml = "";
                        newsDetailHtml = '<div class="card mb-1">'
                        newsDetailHtml += '<div class="row no-gutters">'
                        newsDetailHtml += '<div class="col-md-4">'
                        newsDetailHtml += '<div class="img-hover-zoom"><img class="img-fluid" src=' + newsTabArr[newsTabArr.length - 1].ImageAr + '></div>',
                         newsDetailHtml += '</div>',
                            newsDetailHtml += ' <div class="col-md-8">',
                            newsDetailHtml += '<div class="card-body d-flex flex-column">'
                        newsDetailHtml += '<a href="#" class="card-title-link"><h5 class="card-title">' + newsTabArr[newsTabArr.length - 1].TitleAr + '</h5></a>'
                        newsDetailHtml += '<button href="#" class="btn btn-primary align-self-end">Read More</button>'
                        newsDetailHtml += '</div></div></div></div>';



                    }
                    else {

                        newsDetailHtml = '<div class="card mb-1">'
                        newsDetailHtml += '<div class="row no-gutters">'
                        newsDetailHtml += '<div class="col-md-4">'
                        newsDetailHtml += '<div class="img-hover-zoom"><img class="img-fluid" src=' + imageAr + '></div>',
                            newsDetailHtml += '</div>',
                            newsDetailHtml += ' <div class="col-md-8">',
                            newsDetailHtml += '<div class="card-body d-flex flex-column">'
                        newsDetailHtml += '<a href="#" class="card-title-link"><h5 class="card-title">' + item.TitleAr + '</h5></a>'
                        newsDetailHtml += '<button href="#" class="btn btn-primary align-self-end">Read More</button>'
                        newsDetailHtml += '</div></div></div></div>';

                        // newsDetailHtml += '<div class="tab-pane fade show active" id="pills-' + item.NewsType.TitleEn + '" role="tabpanel" aria-labelledby="pills-' + item.NewsType.TitleEn + '-tab"></div>';

                    }


                    if (index == dataResultsLength && newsTabArr.length > 1) {
                        mainNewsTabHtml += '<div class="tab-pane fade show" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType + '-tab">' + newsDetailHtml + '</div>';

                    }
                    else {
                        mainNewsTabHtml += '<div class="tab-pane fade show active" id="pills-' + newsTabArr[newsTabArr.length - 1].NewsType.replace(" ", "") + '" role="tabpanel" aria-labelledby="pills-' + newsTabArr[newsTabArr.length - 1].NewsType + '-tab">' + newsDetailHtml + '</div>';

                    }
                }
               

            });

            $("#pills-news").html(navtabsHtml);
            $("#pills-newsContent").html(mainNewsTabHtml);
        }

    

    function doErrorNewsdetails(err) {
        alert(JSON.stringify(err));
    }

</script>