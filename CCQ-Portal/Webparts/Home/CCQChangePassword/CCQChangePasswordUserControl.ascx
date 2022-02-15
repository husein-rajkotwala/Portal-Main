<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQChangePasswordUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.CCQChangePassword.CCQChangePasswordUserControl" %>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

                    <form>
                        <div class="form-row">
                            <div class="col-md-12"><div class="alert alert-success" role="alert">This is a success alert—check it out!</div></div>
                            <div class="col-md-12"><div class="alert alert-danger" role="alert">  <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtconfirm_password"
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,10}"
    ErrorMessage="Password must contain: Minimum 8 and Maximum 10 characters atleast 1 UpperCase Alphabet, 1 LowerCase Alphabet, 1 Number and 1 Special Character"
ForeColor="Red" />

<asp:CompareValidator ID="CompareValidator1" runat="server" 
	ControlToCompare="txtconfirm_password" ControlToValidate="txtnew_password" 
	ErrorMessage="Password does not match."></asp:CompareValidator>

                                                   </div></div>
                            <div class="form-group col-md-12">
                                <label for="new_password">New Password</label>
                                <div class="input-group show_hide_password">
                                  <asp:TextBox class="form-control" id="txtnew_password" runat="server" TextMode="Password" ></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="Regex1" runat="server" ControlToValidate="txtnew_password"
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,10}"
    ErrorMessage="Password must contain: Minimum 8 and Maximum 10 characters atleast 1 UpperCase Alphabet, 1 LowerCase Alphabet, 1 Number and 1 Special Character"
ForeColor="Red" />
                             
                                    <div class="input-group-append">
                                        <div class="input-group-text"><a href="#"><i class="fa fa-eye-slash" aria-hidden="true"></i></a></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="confirm_password">Confirm Password</label>
                                <div class="input-group show_hide_password">
                                    <asp:TextBox ID="txtconfirm_password" runat="server" TextMode="Password"  class="form-control"></asp:TextBox>
                                                       
                       
                                    <div class="input-group-append">
                                        <div class="input-group-text"><a href="#"><i class="fa fa-eye-slash" aria-hidden="true"></i></a></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <button type="submit" class="btn btn-primary">Save</button>
                            </div>
                        </div>
                    </form>
<asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />

<script>


    // Ensure that the SP.UserProfiles.js file is loaded before the custom code runs.
    SP.SOD.executeOrDelayUntilScriptLoaded(getUserProperties, 'SP.UserProfiles.js');
    var personProperties;
    function getUserProperties() {

        // Replace the placeholder value with the target user's credentials.
        var targetUser = "tccq\\nithin.prem";

        // Get the current client context and PeopleManager instance.
        var clientContext = new SP.ClientContext.get_current();
        var peopleManager = new SP.UserProfiles.PeopleManager(clientContext);

        // Get user properties for the target user.
        // To get the PersonProperties object for the current user, use the
        // getMyProperties method.
        personProperties = peopleManager.getPropertiesFor(targetUser);

        // Load the PersonProperties object and send the request.
        clientContext.load(personProperties);
        clientContext.executeQueryAsync(onRequestSuccess, onRequestFail);
    }

    // This function runs if the executeQueryAsync call succeeds.
    function onRequestSuccess() {

        debugger;
    }

    // This function runs if the executeQueryAsync call fails.
    function onRequestFail(sender, args) {
        $get("results").innerHTML = "Error: " + args.get_message();
    }
  
</script>