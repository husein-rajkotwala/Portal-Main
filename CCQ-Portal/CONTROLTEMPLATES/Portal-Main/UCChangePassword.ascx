<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCChangePassword.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCChangePassword" %>
 

<div class="modal fade" id="dvchange_password" tabindex="-1" aria-labelledby="dvchange_password_M" aria-hidden="true"> 
        <div class="modal-dialog modal-dialog-scrollable modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dvchange_password_M"><%=GetLocalResourceObject("ChangePassword")%></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                 
                        <div class="form-row">
                            <div class="col-md-12"><div class="alert alert-success" role="alert" id="dvSucess"><%=GetLocalResourceObject("SucessMsg")%></div></div>
                               <div class="col-md-12"><div class="alert alert-danger" role="alert" id="dvEmptyError" style="display:none">
                                   <asp:Label ID="lblErrorMsg" runat="server" Text=""></asp:Label></div></div>
                              <div class="col-md-12"><div class="alert alert-danger" role="alert" id="dvGeneralError" style="display:none" ><%=GetLocalResourceObject("ErrorMsg")%></div></div>
                                     <div class="col-md-12"><div class="alert alert-danger" role="alert" id="dvError" style="display:none">  <asp:RegularExpressionValidator ID="RegPassword" runat="server" Style="display:none" ControlToValidate="txtconfirm_password"
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,15}"
    ErrorMessage='<%$ resources:PasswordErrorMsg%>'
 />
                                         <asp:RegularExpressionValidator ID="RegConfirmPassword" runat="server" ControlToValidate="txtnew_password" Style="display:none"
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,15}"
    ErrorMessage='<%$ resources:PasswordErrorMsg%>'
 ></asp:RegularExpressionValidator>

<asp:CompareValidator ID="CompareValidatorPassword" runat="server" 
	ControlToCompare="txtconfirm_password" ControlToValidate="txtnew_password" 
	ErrorMessage='<%$ resources:PasswordCompErrorMsg%>' Style="display:none"></asp:CompareValidator>

                                                   </div></div>

                              <div class="form-group col-md-12">
                                <label for="new_password"><%=GetLocalResourceObject("NewPassword")%></label>
                                <div class="input-group show_hide_password">
                                  <asp:TextBox class="form-control" id="txtnew_password" runat="server" TextMode="Password" ></asp:TextBox>
                                   
                             
                                    <div class="input-group-append">
                                        <div class="input-group-text"><a href="#"><i class="fa fa-eye-slash" id="eyeIconNewPassword" aria-hidden="true"></i></a></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="confirm_password"><%=GetLocalResourceObject("ConfirmPassword")%></label>
                                <div class="input-group show_hide_password">
                                    <asp:TextBox ID="txtconfirm_password" runat="server" TextMode="Password"  class="form-control" ></asp:TextBox>
                                                       
                       
                                    <div class="input-group-append">
                                        <div class="input-group-text"><a href="#"><i class="fa fa-eye-slash" aria-hidden="true" id="eyeIconConfirmPassword"></i></a></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                                                                    <input id="btnSubmit" type="button" value="Save" />
                            </div>
                           
                        </div>
          
                </div>
            </div>
        </div>
    </div>

<script>
   
    $(document).ready(function () {
        $(<%= txtconfirm_password.ClientID %>).val("");
        $(<%= txtnew_password.ClientID %>).val("");
        $("#dvEmptyError").hide();
        $(<%= lblErrorMsg.ClientID %>).text("");

        $(<%= txtnew_password.ClientID %>).change(function () {
            if ($(<%= RegPassword.ClientID %>).css("visibility")=="hidden") {
                $("#dvError").hide();
            }
            if ($(<%= RegConfirmPassword.ClientID %>).css("visibility") == "hidden") {
                $("#dvError").hide();
            }
            if ($(<%= CompareValidatorPassword.ClientID %>).css("visibility") == "hidden") {
                $("#dvError").hide();
            }
            
           
        });
        $(<%= txtconfirm_password.ClientID %>).change(function () {

            if ($(<%= RegPassword.ClientID %>).css("visibility") == "hidden") {
                $("#dvError").hide();
            }
            if ($(<%= RegConfirmPassword.ClientID %>).css("visibility") == "hidden") {
                $("#dvError").hide();
            }
            if ($(<%= CompareValidatorPassword.ClientID %>).css("visibility") == "hidden") {
                $("#dvError").hide();
            }
        });
     $("#dvSucess").hide();
    
        $('#dvchange_password').on('shown.bs.modal', function (e) {
            $(<%= txtconfirm_password.ClientID %>).val("");
            $(<%= txtnew_password.ClientID %>).val("");
            $("#dvSucess").hide();
            $("#dvError").hide();
            $("#dvEmptyError").hide();
            $(<%= lblErrorMsg.ClientID %>).text("");
            $("#eyeIconConfirmPassword").attr("class", "fa fa-eye-slash");
            $(<%= txtconfirm_password.ClientID %>).attr("type", "password");
            $("#eyeIconNewPassword").attr("class", "fa fa-eye-slash");
            $(<%= txtnew_password.ClientID %>).attr("type", "password");
        });
        $('#dvchange_password').on('hidden.bs.modal', function () {
            $(<%= txtconfirm_password.ClientID %>).val("");
            $(<%= txtnew_password.ClientID %>).val("");
            $("#dvSucess").hide();
            $("#dvError").hide();
            $("#dvGeneralError").hide();
            $("#dvEmptyError").hide();
            $(<%= lblErrorMsg.ClientID %>).text("");
            $("#eyeIconConfirmPassword").attr("class", "fa fa-eye-slash");
            $(<%= txtconfirm_password.ClientID %>).attr("type", "password");
            $("#eyeIconNewPassword").attr("class", "fa fa-eye-slash");
            $(<%= txtnew_password.ClientID %>).attr("type", "password");
        });
        $("#eyeIconNewPassword").click(function (e) {
            var classAttr = $("#eyeIconNewPassword").attr("class")
            if (classAttr == 'fa fa-eye-slash') {
                $("#eyeIconNewPassword").attr("class", "far fa-eye");
                $(<%= txtnew_password.ClientID %>).attr("type", "text");
            }
            else {
                $("#eyeIconNewPassword").attr("class", "fa fa-eye-slash");
                $(<%= txtnew_password.ClientID %>).attr("type", "password");
            }

        });
        $("#eyeIconConfirmPassword").click(function (e) {

            var classAttr = $("#eyeIconConfirmPassword").attr("class")
            if (classAttr == 'fa fa-eye-slash') {
                $("#eyeIconConfirmPassword").attr("class", "far fa-eye");
                $(<%= txtconfirm_password.ClientID %>).attr("type", "text");
             
            }
            else {
                $("#eyeIconConfirmPassword").attr("class", "fa fa-eye-slash");
                $(<%= txtconfirm_password.ClientID %>).attr("type", "password");
            }
        });
        
      
        $("#btnSubmit").click(function () {
            $("#dvError").hide();
            var regPassword = $(<%= RegPassword.ClientID %>);
            regPassword.hide();
            regPassword.css("visibility", "hidden")
            var regConfirmPassword = $(<%= RegConfirmPassword.ClientID %>);
            regConfirmPassword.hide();
            regConfirmPassword.css("visibility", "hidden")
            var compareValidatorPassword = $(<%= CompareValidatorPassword.ClientID %>);
            compareValidatorPassword.hide();
            $("#dvEmptyError").hide();
            $(<%= lblErrorMsg.ClientID %>).text("");
            compareValidatorPassword.css("visibility", "hidden")
            if ($(<%= txtnew_password.ClientID %>).val() == "") {
                $("#dvEmptyError").show();
                if (lang == "en-us") {
                    $(<%= lblErrorMsg.ClientID %>).text("Please Enter New Password");
                }
                else {
                    $(<%= lblErrorMsg.ClientID %>).text("الرجاء إدخال كلمة مرور جديدة");
                }
            }
            else if ($(<%= txtconfirm_password.ClientID %>).val() == "") {
                $("#dvEmptyError").show();
                if (lang == "en-us") {
                    $(<%= lblErrorMsg.ClientID %>).text("Please Enter Confirm Password");
                }
                else {
                     $(<%= lblErrorMsg.ClientID %>).text("الرجاء إدخال كلمة مرور جديدة");
                 }
            }
          else  if ($(regPassword)[0].isvalid == false) {
                $("#dvError").show();
                regPassword.show();
                regPassword.css("visibility", "visible")
                return false;
            }
            else if ($(regConfirmPassword)[0].isvalid == false) {
                $("#dvError").show();
                $(regConfirmPassword).show();
                regConfirmPassword.css("visibility", "visible");
                return false;
            }
            else if ($(compareValidatorPassword)[0].isvalid == false) {
                $("#dvError").show();
                $(compareValidatorPassword).show();
                compareValidatorPassword.css("visibility", "visible");
                return false;
            }
            else {
               
                changeUserPassword();
                return false;
                //  return true;
            }
           
        });
    });
    function ClosePopup() {
        $(<%= txtconfirm_password.ClientID %>).val("");
        $(<%= txtnew_password.ClientID %>).val("");
        $("#dvSucess").hide();
        $("#dvError").hide();
        $("#dvGeneralError").hide();
        $("#dvchange_password").modal('hide');
        $("#dvEmptyError").hide();
        $(<%= lblErrorMsg.ClientID %>).text("");
    }
    function changeUserPassword() {
        var methodUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/ChangePassword";
        $.ajax({

            contentType: "application/json; charset=utf-8",

            data: JSON.stringify({ Password: $(<%= txtconfirm_password.ClientID %>).val(), UserName: userSamAccountName }),

            dataType: "json",

            type: "POST",

            url: methodUrl,
            success: function (result) {
        
                var output = result.d;
                if (output == true) {
                    $("#dvSucess").show();
                }
                else {
                    $("#dvGeneralError").show();
                }
                setTimeout(ClosePopup, 3000);
               
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert('Error occured');
               
                if (jqXHR.status == 500) {
                    console.log('Internal error: ' + jqXHR.responseText);
                } else {
                    console.log('Unexpected error.');
                }
            }

        });

    }
</script>
