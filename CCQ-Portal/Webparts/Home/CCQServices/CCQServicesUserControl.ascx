<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQServicesUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.CCQServices.CCQServicesUserControl" %>
<link rel="stylesheet" type="text/css" href="/Style%20Library/Branding/css/jquery.dataTables.css" />
<script type="text/javascript" charset="utf8" src="/Style%20Library/Branding/js/jquery.dataTables.min.js"></script>

<style>

    #e-services .fa-pencil-ruler{ 
    color: #00235d;
}

#e-services .p-1{
    color: #00235d;
    font-size: 19px;
    font-weight: 600;
    margin-top: 10px;
}

</style>
<div class="container-fluid">
<div class="row">
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-light-blue">
        <a href="#" class="text-white" data-toggle="modal" data-target="#e-services">
            <i class="fas fa-cog fa-4x"></i>
            <h5 class="text-uppercase pt-2">
    <asp:Label ID="lblEservices" runat="server" ><%=GetLocalResourceObject("Eservices")%></asp:Label></h5>
        </a>
    </div>
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-dark-blue">
        <a href="#" class="text-white" data-toggle="modal" data-target="#useful_contacts">
            <i class="far fa-envelope fa-4x"></i>
     <h5 class="text-uppercase pt-2">
    <asp:Label ID="lblUsefulServices" runat="server" ><%=GetLocalResourceObject("UsefulContacts")%></asp:Label></h5>        </a>
    </div>
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-dark-blue">
        <a href="#" class="text-white">
            <i class="fas fa-users fa-4x"></i>
            <h5 class="text-uppercase pt-2"> <asp:Label ID="lblStaffDirectory" runat="server" ><%=GetLocalResourceObject("UseFulLinks")%></asp:Label></h5>
        </a>
    </div>
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-light-blue">
        <a href="#" class="text-white" data-toggle="modal" data-target="#feedback">
            <i class="far fa-comments fa-4x"></i>
            <h5 class="text-uppercase pt-2"><asp:Label ID="lblFeedback" runat="server" ><%=GetLocalResourceObject("FeedBack")%></asp:Label></h5>
        </a>
    </div>


<!-- Useful Contacts Modal -->
<div class="modal fade" id="useful_contacts" tabindex="-1" aria-labelledby="Useful_Contacts_M" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="Useful_Contacts_M"><%=GetLocalResourceObject("UsefulContacts")%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
      <table class="display table table-striped table-hover" id="tblUseFulContacts" style="width:100% !important">
                        <thead class="thead-dark">
                        <tr>
                        
                            <th scope="col"><%=GetLocalResourceObject("Name")%></th>
                            <th scope="col"><%=GetLocalResourceObject("Email")%></th>
                            <th scope="col"><%=GetLocalResourceObject("Phone")%></th>
                            <th scope="col"><%=GetLocalResourceObject("Department")%></th>

                        </tr>
                        </thead>

                    </table>
                   
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End of Useful Contacts Modal -->
    <!-- E-Services Modal --> 
                    <div class="modal fade" id="e-services" tabindex="-1" aria-labelledby="e-services_M" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-scrollable modal-sm">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="e-services_M"><%=GetLocalResourceObject("Eservices")%></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body text-center">
                                    <i class="fas fa-pencil-ruler fa-5x"></i>
                                    <p class="text-uppercase p-1"><%=GetLocalResourceObject("WorkInProgress")%></p>
                                </div>
                            </div>
                        </div>
                    </div>
   <!-- End of E-Services Modal -->

<!-- Feedback Modal -->
<div class="modal fade" id="feedback" tabindex="-1" aria-labelledby="Feedback_M" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="Feedback_M"><%=GetLocalResourceObject("FeedBack")%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
               
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="full_name"><%=GetLocalResourceObject("Name")%></label>
                             <asp:TextBox ID="txtName" runat="server" class="form-control" name="full_name"></asp:TextBox>  
                            
                        </div>
                        <div class="form-group col-md-6">
                            <label for="email"><%=GetLocalResourceObject("Email")%></label>
                        
                             <asp:TextBox ID="txtEmail" runat="server"  class="form-control" name="email"></asp:TextBox>  
                        </div>
                        <div class="form-group col-md-6">
                            <label for="phone"><%=GetLocalResourceObject("Phone")%></label>
                      
                             <asp:TextBox ID="txtPhone" runat="server"  class="form-control" name="phone"></asp:TextBox>  
                        </div>
                        <div class="form-group col-md-6">
                            <label for="category"><%=GetLocalResourceObject("Category")%></label>
                            <select id="category" class="form-control" name="category">
                              
                            </select>

                        </div>
                        <div class="form-group col-md-12">
                            <label for="comment">Comment</label>
                                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" class="form-control"  name="comment"></asp:TextBox> 
                             <div class="alert alert-danger" role="alert" id="dvComments" style="display:none">
                <asp:Label ID="lblValidationComments" runat="server" ><%=GetLocalResourceObject("ValidationComments")%></asp:Label>    
                        </div>
                        <div class="form-group col-md-12">
                          <asp:Button ID="btnSubmit" runat="server" class="btn btn-primary"  type="submit" Text='<%$ resources:Submit%>' />
                        </div>
                    </div>
              </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<script>
    var usefulContactArr = [];

        var language = lang;
        function hideLoader() {
            $("#dvImageLoader").hide();
            $("#dvFeedback").show();
        }
        function ShowLoader() {
            $("#dvImageLoader").show();
            $("#dvFeedback").hide();
        }
        function AddFeedBack() {

            var feedBackMethodUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/AddFeedBackInfo";
            
            var feedBackArr = new Array();

                var FeedBack = new Object();

                    FeedBack["Title"] = $(<%= txtName.ClientID %>).val();

                    FeedBack["Name"] = $(<%= txtName.ClientID %>).val();

                    FeedBack["Email"] = $(<%= txtEmail.ClientID %>).val();

                    FeedBack["Phone"] = $(<%= txtPhone.ClientID %>).val();


                    FeedBack["Comments"] = $(<%= txtComments.ClientID %>).val();
            FeedBack["CategoryId"] = $("select[id='category']").val();

            feedBackArr.push(FeedBack);

            /* Create a data transfer object (DTO) with the  

            remember DTO  Parameter and Web Sevice Parameter name are same.

          */

            var DTO = { 'FeedBack': feedBackArr };
            var test = JSON.stringify(DTO);
            console.log(test);
            $.ajax({

                contentType: "application/json; charset=utf-8",

                data: JSON.stringify(DTO),

                dataType: "json",

                type: "POST",

                url: feedBackMethodUrl,
                success: function (result) {
                   
                    var output = result.d;
                   
                    $("#dvSuccess").show();
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
        function getUserProfileDetails() {
            if (Name != "" && Name != null) {
                $("input[id*='txtName']").val(Name);
            }
            if (Email != "" && Email != null) {
                $("input[id*='txtEmail']").val(Email);
            }
            if (Phone != "" && Phone != null) {
                $("input[id*='txtPhone']").val(Phone);
            }
        }
        function getCCQDepartment() {
            var DepartmentSiteUrl = _spPageContextInfo.siteAbsoluteUrl;
            var Title = "Department master";
            var ID = "";
            var Filter = "";


            var Select = "";
            var orderBy = "";
            var top = "";
            var restWeb = new RESTApiHelper.Web(DepartmentSiteUrl);
            var myList = new restWeb.List(Title);
            var items = new myList.Items();
            if (ID != '')
                items.GetItemByID(ID, doSuccess, doError);
            else
                items.GetItems(Select, Filter, orderBy, top, doSuccessCCQDepartment, doErrorCCQDepartment);
        }
        function doSuccessCCQDepartment(data) {
      
            $("select[id='category']").empty();
            $.each(data.d.results, function (index, item) {
             
              
                if (language == "en-us") {


                    $("select[id='category']").append($('<option>', {
                        value: item.ID,
                        text: item.TitleEn
                    }));


                }


                else {

                    $("select[id='category']").append($('<option>', {
                        value: item.ID,
                        text: item.TitleAr
                    }));
                }
               
            });
            

  

        }


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


            if (language == "en-us") {

                var jsonObject = {};
                jsonObject = {
                    "Name": item.Title,
                    "Email": item.EmailAdress,
                    "Phone": item.Phone,
                    "Department": item.Department.TitleEn
                };


                usefulContactArr.push(jsonObject);


            }


            else {
                var jsonObject = {};
                jsonObject = {
                    "Name": item.NameAr,
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
                { data: 'Name' },
                { data: 'Email' },
                { data: 'Phone' },

                { data: 'Department' },

            ],
            "paging": false

        });
        $('.dataTables_length').addClass('bs-select');

    }
    function doErrorUsefulContacts(err) {
        alert(JSON.stringify(err));
    }
        function doErrorCCQDepartment(err) {
            alert(JSON.stringify(err));
        }
        $(document).ready(function () {
          getUserProfileDetails();
            getCCQDepartment();
            getUsefulContacts();
         
       
           

  $(<%= btnSubmit.ClientID %>).click(function () {
             
                $("#dvCategory").hide();
             
                $("#dvComments").hide();
      if ($(<%= txtComments.ClientID %>).val() != "" && $("select[id='category']").val() != "") {
          AddFeedBack();
          return true;
                }
      else if ($("select[id='category']").val() == "") {
                 
                    $("#dvCategory").show();
                    return false;
                }
             
                else if ($(<%= txtComments.ClientID %>).val() == "") {
                   
                    $("#dvComments").show();
                    return false;
                  }
              
                return false;
            });

        });
</script>