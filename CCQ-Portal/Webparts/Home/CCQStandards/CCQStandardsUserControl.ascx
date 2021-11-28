<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQStandardsUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.CCQStandards.CCQStandardsUserControl" %>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<style>

nav > .nav.nav-tabs{

  border: none;
    color:#fff;
    background:#272e38;
    border-radius:0;

}
nav > div a.nav-item.nav-link,
nav > div a.nav-item.nav-link.active
{
  border: none;
    padding: 18px 25px;
    color:#fff;
    background:#00008B;
    border-radius:0;
}

nav > div a.nav-item.nav-link.active:after
 {
  content: "";
  position: relative;
  bottom: -60px;
  left: -10%;
  border: 15px solid transparent;
  border-top-color: #e74c3c ;
}
.tab-content{
  background: #fdfdfd;
    line-height: 25px;
    border: 1px solid #ddd;
    border-top:5px solid #e74c3c;
    border-bottom:5px solid #e74c3c;
    padding:30px 25px;
}

nav > div a.nav-item.nav-link:hover,
nav > div a.nav-item.nav-link:focus
{
  border: none;
    background: #e74c3c;
    color:#fff;
    border-radius:0;
    transition:background 0.20s linear;
}
</style>

<!------ Include the above in your HEAD tag ---------->

 <div  style="width:800px">
              <div class="row">
                <div class="col-xs-12 ">
                  <nav>
                    <div class="nav nav-tabs nav-fill Goals-Tab" id="nav-tab" role="tablist">
                    
                    </div>
                  </nav>
                  <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">

                  </div>
                
                </div>
              </div>
        </div>
  

<script>
    var siteEventUrl = '';
    var language = lang;
    var GoalsTitle = "CCQ Goals";
    var ID = "";
    var goalTabArr = [];
   
   
    $(document).ready(function () {
        getGoals();
      });


    function getGoals() {
        var Filter = "";
        var Select = "";
        var orderBy = "GoalType_x003a_TabbedSortOrder,SortOrder";
        var top = "";
        var restWeb = new RESTApiHelper.Web(siteEventUrl);
        var myList = new restWeb.List(GoalsTitle);
        var items = new myList.Items();
        
        jQuery.ajax({
            url: _spPageContextInfo.siteAbsoluteUrl + "/_api/web/lists/GetByTitle('" + GoalsTitle + "')/items?$select=Title,TitleEn,TitleAr,DescriptionEn,DescriptionAr,GoalType/TitleEn,GoalType/TitleAr&$expand=GoalType&$orderby=GoalType/TabbedSortOrder,SortOrder",
            type: "GET",
            headers: { "Accept": "application/json; odata=verbose" },
            success: doSuccessGoals,
            error: doErrorGoals
        });

        function doSuccessGoals(data) {
            var dataResultsLength = data.d.results.length-1;
            var goalsTabHtml = "";
            var navtabsHtml = "";
            var accordionHtml = "";

            $.each(data.d.results, function (index, item) {

                if (language == "en-us") {
                    if (item.GoalType.TitleEn != null && item.GoalType.TitleEn != "" && item.GoalType.TitleEn != "undefined")
                        var goalType = item.GoalType.TitleEn;
                    var goalTypeJSON = {
                        "GoalType": item.GoalType.TitleEn
                    };

                    //if (index == 0) {
                    //    navtabsHtml += '<div class="tab-pane fade show active" id="nav-' + item.GoalType.TitleEn + '" role="tabpanel" aria-labelledby="nav-' + item.GoalType.TitleEn + '-tab">' + item.GoalType.TitleEn + '</div>';
                    //}
                    //else {
                    //    navtabsHtml += '<div class="tab-pane fade" id="nav-' + item.GoalType.TitleEn + '" role="tabpanel" aria-labelledby="nav-' + item.GoalType.TitleEn + '-tab">' + item.GoalType.TitleEn + '</div>';

                    //}

                    var result = goalTabArr.filter(x => x.GoalType === item.GoalType.TitleEn);
                    if (result.length == 0) {
                        if (index == 0) {
                            goalsTabHtml = '<a class="nav-item nav-link active" id="nav-' + item.GoalType.TitleEn + '-tab" data-toggle="tab" href="#nav-' + item.GoalType.TitleEn + '" role="tab" aria-controls="nav-' + item.GoalType.TitleEn + '" aria-selected="true"><img alt="Qries" src="http://portal-01t.tccq.edu.qa/Style%20Library/Images/Vision.jfif" width = 150" height="70"/></a>';

                        }
                        else {
                            goalsTabHtml += '<a class="nav-item nav-link" id="nav-' + item.GoalType.TitleEn + '-tab" data-toggle="tab" href="#nav-' + item.GoalType.TitleEn + '" role="tab" aria-controls="nav-' + item.GoalType.TitleEn + '" aria-selected="true">' + item.GoalType.TitleEn + '<img alt="Qries" src="http://portal-01t.tccq.edu.qa/Style%20Library/Images/Vision.jpg" width = 150" height="70"/></a>';

                            if (goalTabArr.length == 1) {
                                navtabsHtml += '<div class="tab-pane fade show active" id="nav-' + goalTabArr[goalTabArr.length - 1].GoalType + '" role="tabpanel" aria-labelledby="nav-' + goalTabArr[goalTabArr.length - 1].GoalType + '-tab"><div class="m-4"><div class="accordion" id="myAccordion' + index + '">' + accordionHtml + '</div></div></div>';

                            }
                            else {
                                navtabsHtml += '<div class="tab-pane fade" id="nav-' + item.GoalType.TitleEn + '" role="tabpanel" aria-labelledby="nav-' + item.GoalType.TitleEn + '-tab"><div class="m-4"><div class="accordion" id="myAccordion">' + accordionHtml + '</div></div></div>';
                            }
                        }
                        goalTabArr.push(goalTypeJSON);
                        accordionHtml = "";
                        accordionHtml = '<div class="accordion-item"><h2 class="accordion-header" id="heading' + index + '"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#collapse' + index + '" aria-expanded="false">' + item.TitleEn + '</button></h2><div id="collapse' + index + '" class="accordion-collapse collapse" data-bs-parent="#myAccordion"> <div class="card-body"><p>' + item.DescriptionEn + '</p></div></div></div>';

                    }
                    else {
                        accordionHtml += '<div class="accordion-item"><h2 class="accordion-header" id="heading' + index + '"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#collapse' + index + '" aria-expanded="false">' + item.TitleEn + '</button></h2><div id="collapse' + index + '" class="accordion-collapse collapse" data-bs-parent="#myAccordion"> <div class="card-body"><p>' + item.DescriptionEn + '</p></div></div></div>';

                    }

                }
                if (index == dataResultsLength)
                {
                    navtabsHtml += '<div class="tab-pane fade" id="nav-' + item.GoalType.TitleEn + '" role="tabpanel" aria-labelledby="nav-' + item.GoalType.TitleEn + '-tab"><div class="m-4"><div class="accordion" id="myAccordion">' + accordionHtml + '</div></div></div>';

                }

                    
                    //if (result.length == 1) {
                    //    accordionHtml = "";
                    //    accordionHtml += '<div class="m-4"><div class="accordion-item"><h2 class="accordion-header" id="heading' + index + '"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#collapse' + index + '">' + item.TitleEn + '</button></h2><div id="collapse' + index + '" class="accordion-collapse collapse" data-bs-parent="#myAccordion"> <div class="card-body"><p>' + item.DescriptionEn + '</p></div></div></div></div>';

                    //    if (index == 0) {
                    //        goalsTabHtml += '<a class="nav-item nav-link active" id="nav-' + item.GoalType.TitleEn + '-tab" data-toggle="tab" href="#nav-' + item.GoalType.TitleEn + '" role="tab" aria-controls="nav-' + item.GoalType.TitleEn + '" aria-selected="true">' + item.GoalType.TitleEn + '</a>';
                    //        navtabsHtml += '<div class="tab-pane fade show active" id="nav-' + item.GoalType.TitleEn + '" role="tabpanel" aria-labelledby="nav-' + item.GoalType.TitleEn + '-tab">' + accordionHtml + '</div>';

                    //    }
                    //    else {
                    //        goalsTabHtml += '<a class="nav-item nav-link" id="nav-' + item.GoalType.TitleEn + '-tab" data-toggle="tab" href="#nav-' + item.GoalType.TitleEn + '" role="tab" aria-controls="nav-' + item.GoalType.TitleEn + '" aria-selected="true">' + item.GoalType.TitleEn + '</a>';

                    //    }
                    //}
                    //else {
                    //    navtabsHtml += '<div class="tab-pane fade show" id="nav-' + item.GoalType.TitleEn + '" role="tabpanel" aria-labelledby="nav-' + item.GoalType.TitleEn + '-tab">' + item.GoalType.TitleEn + '</div>';

                    //}
                
                else {
                   
                }

            });

           $(".Goals-Tab").html(goalsTabHtml);
           $("#nav-tabContent").html(navtabsHtml);

        }
      
    }

    function doErrorGoals(err) {
        alert(JSON.stringify(err));
    }

   


 
</script>

<%--<div class="m-4">
    <div class="accordion" id="myAccordion">
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingOne">
                <button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#collapseOne">1. What is HTML?</button>									
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#myAccordion">
                <div class="card-body">
                    <p>HTML stands for HyperText Markup Language. HTML is the standard markup language for describing the structure of web pages. <a href="https://www.tutorialrepublic.com/html-tutorial/" target="_blank">Learn more.</a></p>
                </div>
            </div>
        </div>
    
    </div>
</div>

<div class="m-4">
   <div class="accordion" id="myAccordion1">
      <div class="accordion-item">
         <h2 class="accordion-header" id="heading0"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#collapse0" aria-expanded="false"> Human Capital Excellence</button></h2>
         <div id="collapse0" class="accordion-collapse collapse" data-bs-parent="#myAccordion">
            <div class="card-body">
               <p>To enhance human capital attraction, development and retention of distinguished, skilled professionals, while providing a reliable working environment&ZeroWidthSpace;.</p>
            </div>
         </div>
      </div>
   </div>
</div>--%>