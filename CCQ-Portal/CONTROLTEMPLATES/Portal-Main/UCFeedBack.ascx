<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCFeedBack.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCFeedBack" %>
<ul class="navbar-nav side-menu">
                    <li class="nav-item px-md-2">
                        <a class="nav-link menu-item" href="#" data-toggle="modal" data-target="#feedback"><i class="fas fa-envelope"></i> <%=GetLocalResourceObject("Feedback")%></a>
                    </li>
                 


    <li class="nav-item px-md-2 bg-light-blue rounded text-center">
                        <a class="nav-link menu-item" href="/Pages/MyApplications.aspx"><i class="fas fa-clipboard-list"></i> <%=GetLocalResourceObject("MyDashboard")%></a>
                    </li>
                    <!--
                    <li class="nav-item px-md-2">
                        <a class="nav-link menu-item" href="arabic/index.html">عربي</a>
                    </li>
                    -->
                </ul>

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
                               <asp:TextBox ID="txtName" runat="server"  class="form-control" ReadOnly="true"></asp:TextBox>
                                    

                        </div>
                        <div class="form-group col-md-6">
                            <label for="email"><%=GetLocalResourceObject("Email")%></label>
                              <asp:TextBox ID="txtEmail" runat="server"  class="form-control" ReadOnly="true"></asp:TextBox>
                               
                        </div>
                        <div class="form-group col-md-6">
                            <label for="phone"><%=GetLocalResourceObject("Phone")%></label>
                      
                             
                                    <asp:TextBox ID="txtPhone" runat="server"  class="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="category"><%=GetLocalResourceObject("Department")%></label>
                            <select id="category" class="form-control" name="category">
                              
                            </select>

                        </div>
                        <div class="form-group col-md-12">
                                <label for="subject"><%=GetLocalResourceObject("Subject")%></label>
                               <asp:TextBox ID="txtSubject" runat="server"  class="form-control"  name="subject"></asp:TextBox> 
                            </div>
                               <div class="alert alert-danger" role="alert" id="dvSubject" style="display:none">
                <asp:Label ID="lblSubject" runat="server"  Text="Please Enter Subject"></asp:Label>    
                        </div>
                        <div class="form-group col-md-12">
                            <label for="comment"><%=GetLocalResourceObject("Comments")%></label>
                                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" class="form-control"  name="comment"></asp:TextBox> 
                             <div class="alert alert-danger" role="alert" id="dvComments" style="display:none">
                <asp:Label ID="lblValidationComments" runat="server" ><%=GetLocalResourceObject("ValidationComments")%></asp:Label>    
                        </div>
                       
                    </div>
                         <div class="form-group col-md-12">
                          <asp:Button ID="btnSubmit" runat="server" class="btn btn-primary"  type="submit" Text='<%$ resources:Submit%>' />
                            <button type="button" class="btn btn-primary" id="reset" data-dismiss="modal">Cancel</button>

                        </div>
              </div>
            </div>
        </div>
    </div>
    
</div>
<script>
    function getUserProfileDetails() {
        if (userDisplayName != "" && userDisplayName != null && userDisplayName != undefined) {
            $(<%= txtName.ClientID %>).val(userDisplayName);
        }
        else {
            $(<%= txtName.ClientID %>).val(_spPageContextInfo.userDisplayName);
        }
            if (mobileNumber != "" && mobileNumber != null) {
                $(<%= txtPhone.ClientID %>).val(mobileNumber);
            }
            $(<%= txtEmail.ClientID %>).val(_spPageContextInfo.userLoginName);
    }
    function AddFeedBack() {

        var feedBackMethodUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/AddFeedBackInfo";

        var feedBackArr = new Array();

        var FeedBack = new Object();

        FeedBack["Title"] = $(<%= txtName.ClientID %>).val();

        FeedBack["Name"] = $(<%= txtName.ClientID %>).val();

        FeedBack["Email"] = $(<%= txtEmail.ClientID %>).val();

                   FeedBack["Phone"] = $(<%= txtPhone.ClientID %>).val();
                 FeedBack["Subject"] = $(<%= txtSubject.ClientID %>).val();


                FeedBack["Comments"] = $(<%= txtComments.ClientID %>).val();
                FeedBack["CategoryId"] = $("select[id='category']").val();
        FeedBack["DepartmentEmail"] = $("select[id='category'] option:selected").attr("email");
        FeedBack["DepartmentName"] = $("select[id='category'] option:selected").text();

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
        function getCCQDepartment() {
            var DepartmentSiteUrl = _spPageContextInfo.siteAbsoluteUrl;
            var Title = "Department master";
            var ID = "";
         

            var Filter = "Display eq 'All' or Display eq 'Feedback' and Active eq 'Yes'";


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
             
              
                if (lang == "en-us") {
          
                    $("select[id='category']").append($('<option Email=' + item.EmailAddress + ' value=' + item.ID + '>' + item.TitleEn+'</option>'));
                   
                }


                else {

                    $("select[id='category']").append($('<option>', {
                        value: item.ID,
                        text: item.TitleAr
                    }));
                }
               
            });
            

  

    }
    function ClosePopup() {
        $(<%= txtComments.ClientID %>).val("");
        $(<%= txtSubject.ClientID %>).val("");
        $("#feedback").modal('hide');
        location.reload();
    }
    function doErrorCCQDepartment(err) {
        alert(JSON.stringify(err));
    }
    $(document).ready(function () {
        getCCQDepartment();
        $("#dvSubject").hide();

        $('#feedback').on('shown.bs.modal', function (e) {
            $(<%= txtComments.ClientID %>).val("");
            $(<%= txtSubject.ClientID %>).val("");
            });
    

        $(<%= btnSubmit.ClientID %>).click(function () {

                    $("#dvCategory").hide();
            $("#dvSubject").hide();
                    $("#dvComments").hide();
                    if ($(<%= txtComments.ClientID %>).val() != "" && $("select[id='category']").val() != "") {
                        AddFeedBack();
                        ClosePopup();
                }
      else if ($("select[id='category']").val() == "") {
                 
                    $("#dvCategory").show();
                    return false;
                    }
                    else if ($(<%= txtSubject.ClientID %>).val() == "") {

                        $("#dvSubject").show();
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