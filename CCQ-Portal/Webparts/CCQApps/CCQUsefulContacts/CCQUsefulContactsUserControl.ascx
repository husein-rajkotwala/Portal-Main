<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQUsefulContactsUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.CCQApps.CCQUsefulContacts.CCQUsefulContactsUserControl" %>
<link rel="stylesheet" type="text/css" href="/Style%20Library/Branding/css/jquery.dataTables.css" />
<script type="text/javascript" charset="utf8" src="/Style%20Library/Branding/js/jquery.dataTables.min.js"></script>    


​​
<div class="card border-ccq"> 
   <div class="card-header border-ccq"> 
      <i class="far fa-envelope"></i><%=GetLocalResourceObject("UsefulContacts")%> </div> 
   <div class="card-body"> 
      <div class="table-responsive"> 

          <table class="table table-striped table-hover" id="tblUseFulContacts">
                        <thead>
                        <tr>
                        
                          
                            <th><%=GetLocalResourceObject("Email")%></th>
                            <th><%=GetLocalResourceObject("Phone")%></th>
                            <th><%=GetLocalResourceObject("Department")%></th>

                        </tr>
                        </thead>

                    </table>
         
      </div> 
   </div> 
</div>
<script>
    var usefulContactArr = [];


    $(document).ready(function () {
        getUsefulContacts();
    });
    function getUsefulContacts() {
        var usefulContactUrl = _spPageContextInfo.siteAbsoluteUrl;
        var usefulContactsTitle = "CCQUsefulContacts";

        jQuery.ajax({
            url: usefulContactUrl + "/_api/web/lists/GetByTitle('" + usefulContactsTitle + "')/items?$select=Title,NameAr,EmailAdress,Phone,Department/TitleEn,Department/TitleAr&$expand=Department&$filter=isHide eq 0",
            type: "GET",
            headers: { "Accept": "application/json; odata=verbose" },
            success: doSuccessUsefulContacts,
            error: doErrorUsefulContacts
        });

    }
    function doSuccessUsefulContacts(data) {

      
    
        $.each(data.d.results, function (index, item) {


            if (lang == "en-us") {

                var jsonObject = {};
                jsonObject = {
                   
                    "Email": item.EmailAdress,
                    "Phone": item.Phone,
                    "Department": item.Department.TitleEn
                };


                usefulContactArr.push(jsonObject);


            }


            else {
                var jsonObject = {};
                jsonObject = {
                   
                    "Email": item.EmailAdress,
                    "Phone": item.Phone,
                    "Department": item.Department.TitleAr
                };
                usefulContactArr.push(jsonObject);

            }

        });


        $('#tblUseFulContacts').DataTable({
            //"pagingType": "simple", // "simple" option for 'Previous' and 'Next' buttons only
            data: usefulContactArr,
            columns: [
             
                { data: 'Email' },
                { data: 'Phone' },

                { data: 'Department' },

            ],
            "paging": false,
            

        });
      //  $('.dataTables_length').addClass('bs-select');

    }
    function doErrorUsefulContacts(err) {
        alert(JSON.stringify(err));
    }
</script>