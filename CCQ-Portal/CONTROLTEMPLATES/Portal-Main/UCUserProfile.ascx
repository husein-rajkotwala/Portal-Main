<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCUserProfile.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCUserProfile" %>

<div class="modal fade" id="profile_modal" tabindex="-1" aria-labelledby="profile_modal_M" aria-hidden="true"> 
        <div class="modal-dialog modal-dialog-scrollable modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="profile_modal_M"><%=GetLocalResourceObject("MyProfile")%></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                          <div class="col-md-12"><div class="alert alert-success" role="alert" id="dvProfileSucess"><%=GetLocalResourceObject("SucessMsg")%></div></div>
                               <div class="col-md-12"><div class="alert alert-danger" role="alert" id="dvProfileEmptyError" style="display:none">
                                   <asp:Label ID="lblProfileErrorMsg" runat="server" Text=""></asp:Label></div>
                                                                 <div class="col-md-12"><div class="alert alert-danger" role="alert" id="dvProfileGeneralError" style="display:none" ><%=GetLocalResourceObject("ErrorProfileMsg")%></div></div>


                               </div>
                        <div class="form-row">
                            <div class="form-group col-2">
                              <label for="mobile"><%=GetLocalResourceObject("Mobile")%></label>
                              <input type="text" class="form-control" id="country_code" name="country_code" value="+974" readonly="true">
                            </div>
                            <div class="form-group col-10">
                                <label class="mobile_lbl" style="height:25px"></label>
                                <input type="text" class="form-control" id="txtmobile" name="mobile">
                            </div>
                            <div class="form-group col-md-12">
                                <label for="alt_email"><%=GetLocalResourceObject("AlternateEmail")%></label>
                                <input type="text" class="form-control" id="txtalt_email" name="alt_email">
                            </div>
                            <div class="form-group col-md-12">
                                  <input id="btnProfileEdit" type="button" value="Edit"  class="btn btn-primary"/>
                               <input id="btnProfileSubmit" type="button" value="Save"  style="display:none" class="btn btn-primary"/>

                                <button type="submit" class="btn btn-primary" runat="server"><%=GetLocalResourceObject("Cancel")%></button>
                           
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
        </div>
    </div>

  <script>
        var language = lang;
      
        function UpdateUserProfile() {
            //latest

           
            var methodUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/ChangeUserProfile";
            

            var userProfileArr = new Array();

       

            var userProfile = new Object();

              

            userProfile["CCQMobileNumber"] = $("#txtmobile").val()

            userProfile["CCQAlternateEmail"] = $("#txtalt_email").val()
            userProfile["currentUser"] = userSamAccountName;


                    
            userProfileArr.push(userProfile);

            

            /* Create a data transfer object (DTO) with the  

            remember DTO  Parameter and Web Sevice Parameter name are same.

          */

            var DTO = { 'UserProfile': userProfileArr };
           
            $.ajax({

                contentType: "application/json; charset=utf-8",

                data: JSON.stringify(DTO),

                dataType: "json",

                type: "POST",

                url: methodUrl,
                success: function (result) {
                   
                    var output = result.d;
                    if (output == true) {
                        $("#dvProfileSucess").show();
                    }
                    else {
                        $("#dvProfileGeneralError").show();
                    }
                    setTimeout(ClosePopup, 3000);
                  
                },
                error: function (jqXHR, textStatus, errorThrown) {
                 
                    if (jqXHR.status == 500) {
                        console.log('Internal error: ' + jqXHR.responseText);
                    } else {
                        console.log('Unexpected error.');
                    }
                }

            });
        }

      function ClosePopup() {
          $("#profile_modal").modal('hide');
          location.reload();
      }
    
      function isValidateMobileNumber(ccqMobile) {
          var filter = /^\d*(?:\.\d{1,2})?$/;

          if (filter.test(ccqMobile) && ccqMobile.length==8) { return true; }
          else {


             return false;
          }
      }
        
      function isEmail(email) {
          var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
          return regex.test(email);
      }
      $(document).ready(function () {
          $("#txtalt_email").prop("disabled", true);
          $("#txtmobile").prop("disabled", true);
          $("#btnProfileEdit").show();
            $(<%= lblProfileErrorMsg.ClientID %>).text("");
            $("#dvProfileEmptyError").hide();
          $("#dvProfileSucess").hide();
          $("#btnProfileSubmit").hide();

          $('#profile_modal').on('shown.bs.modal', function (e) {
              $("#txtalt_email").prop("disabled", true);
              $("#txtmobile").prop("disabled", true);
              $("#btnProfileEdit").show();
              $(<%= lblProfileErrorMsg.ClientID %>).text("");
              $("#dvProfileEmptyError").hide();
              $("#dvProfileSucess").hide();
              $("#dvProfileEmptyError").hide();
              $("#btnProfileSubmit").hide();
              });
          $("#btnProfileEdit").click(function () {
              $("#btnProfileSubmit").show();
              $("#txtalt_email").prop("disabled", false);
              $("#txtmobile").prop("disabled", false);
              $("#btnProfileEdit").hide();
           

          });



          $("#btnProfileSubmit").click(function () {
            
           
                var altEmail = $("#txtalt_email").val()
                var ccqMobile = $("#txtmobile").val()
                $(<%= lblProfileErrorMsg.ClientID %>).text("");
                $("#dvProfileEmptyError").hide();
                $("#dvProfileSucess").hide();
                   if ($("#txtmobile").val() == "") {
                    $("#dvProfileEmptyError").show();
                    if (lang == "en-us") {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("Please Enter CCQ Mobile");
                    }
                    else {
                          $(<%= lblProfileErrorMsg.ClientID %>).text("الرجاء إدخال CCQ Mobile");
                      }
                      return false;


                  }
               else if ($("#txtalt_email").val() == "") {
                    $("#dvProfileEmptyError").show();
                    if (lang == "en-us") {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("Please Enter Alternate Email");
                    }
                    else {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("الرجاء إدخال البريد الإلكتروني البديل");
                    }
                    return false;
                }
                else if ($("#txtmobile").val() == "") {
                    $("#dvProfileEmptyError").show();
                    if (lang == "en-us") {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("Please Enter CCQ Mobile");
                    }
                    else {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("الرجاء إدخال CCQ Mobile");
                    }
                    return false;


                }
                else if (!isEmail(altEmail))
                {
                    $("#dvProfileEmptyError").show();
                    if (lang == "en-us") {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("Please Enter Valid Email");
                    }
                    else {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("الرجاء إدخال بريد إلكتروني صحيح");
                    }
                    return false;

                }
             
                else if (!isValidateMobileNumber(ccqMobile))
                {
                    $("#dvProfileEmptyError").show();
                    if (lang == "en-us") {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("Not a valid Phone Number");
                    }
                    else {
                        $(<%= lblProfileErrorMsg.ClientID %>).text("رقم هاتف غير صالح");
                    }
                    return false;


                }
                else {

                    UpdateUserProfile();

                }


            });
        });
  </script>