<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeedBackUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.FeedBack.FeedBackUserControl" %>
<style>
* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #04AA6D;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}


/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
.fill {
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden
}
.fill img {
    flex-shrink: 0;
    min-width: 100%;
    min-height: 100%
}
</style>

<div class="alert alert-success" role="alert" id="dvSuccess" style="display:none">
                <asp:Label ID="lblSuccess" runat="server" Text='<%$ resources:Success%>'></asp:Label>
</div>

<div class="container fill">
    <div id="dvImageLoader">
          <image src="/Style%20Library/Images/Spinner-1s-200px.gif" style="height:700px;width:700px"/>
        </div>
    <div id="dvFeedback" style="display:none">
<div class="row">
     <div class="col-25">
    <label for="Name" class="form-label"><%=GetLocalResourceObject("Name")%>:</label>
         </div>
     <div class="col-75">
    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>  

     </div>
    </div>

    <div class="row">
     <div class="col-25">
 <label for="Email" class="form-label"><%=GetLocalResourceObject("Email")%>:</label>
         </div>
     <div class="col-75">
        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>  

     </div>
    </div>
        <div class="row">
     <div class="col-25">
 <label for="Phone" class="form-label"><%=GetLocalResourceObject("Phone")%>:</label>
         </div>
     <div class="col-75">
        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>  

     </div>
    </div>
     <div class="row">
         <div class="col-25">
 <label for="Phone" class="form-label"><%=GetLocalResourceObject("Category")%>:</label>
         </div>
     <div class="col-75">
          <asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>
          <div class="alert alert-danger" role="alert" id="dvCategory" style="display:none">
                <asp:Label ID="Label1" runat="server" Text='<%$ resources:ValidationCategory%>'></asp:Label>
</div>
     </div>
                    
    </div>

        <div class="row">
     <div class="col-25 form-group required">
 <label for="Subject" class="form-label"><%=GetLocalResourceObject("Subject")%>:</label>
         </div>
     <div class="col-75">
        <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox> 
          <div class="alert alert-danger" role="alert" id="dvSubject" style="display:none">
                <asp:Label ID="lblErrorSubject" runat="server" Text='<%$ resources:ValidationSubject%>'></asp:Label>
</div>
     </div>
           
    </div>
    
 <div class="row">
     <div class="col-25">
 <label for="Comments" class="form-label"><%=GetLocalResourceObject("Comments")%>:</label>
         </div>
     <div class="col-75">
        <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine"></asp:TextBox> 
     <div class="alert alert-danger" role="alert" id="dvComments" style="display:none">
                <asp:Label ID="lblValidationComments" runat="server" Text='<%$ resources:ValidationComments%>'></asp:Label>
</div>
    </div>

  <div class="row">
       <div class="col-50">

                      <asp:Button ID="btnSubmit" runat="server" class="btn btn-primary" Text='<%$ resources:Submit%>' />

     </div>
           <div class="col-50">
                <asp:Button ID="btnReset" runat="server" class="btn btn-primary" Text='<%$ resources:Reset%>' />
              

         </div>

    </div>
 
       
     </div> 
</div>
  </div>
    <script>
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
            //latest

            var fullUrl = _spPageContextInfo.siteAbsoluteUrl + "/_api/web/lists/getbytitle('CCQ Feedback')/items";

            var itemType = "SP.Data.CCQFeedbackListItem";
            var cat = {
                "__metadata": { "type": itemType },
                "Title": $(<%= txtName.ClientID %>).val(),

                "Name": $(<%= txtName.ClientID %>).val(),
                "Email": $(<%= txtEmail.ClientID %>).val(),
                "Phone": $(<%= txtPhone.ClientID %>).val(),
                "CategoryId": $(<%= ddlCategory.ClientID %>).val(),
                "Comments": $(<%= txtComments.ClientID %>).val(),

            };
            var cat1 = {
                "FirstName": $(<%= txtName.ClientID %>).val(),

                    "LastName": $(<%= txtName.ClientID %>).val(),
                

                };
            //$.ajax({
            //    url: fullUrl,
            //    method: "POST",
            //    data: JSON.stringify(cat),
            //    headers: {
            //        "Accept": "application/json;odata=verbose",
            //        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
            //        "Content-Type": "application/json;odata=verbose"
            //    },
            //    success: function (data) {
            //        hideLoader();
            //        var successMsg = "";
            //        $("#dvSuccess").show();


            //    },
            //    error: function (data) {
            //        alert("Failed");

            //    }
            //});
            //var param = {};
            //param.name = "Prashanth";
            //$.ajax({
            //    type: "POST",
            //    url: _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CQPortal/PortalMethods.aspx/CurrentlogInUserName",
            //    data: JSON.stringify(param),
            //    contentType: "application/json;charset=utf-8",
            //    dataType: "json",
            //    async: true,
            //    cache: false,
            //    success: function (msg) {
            //        alert(msg);
            //        return false;
            //    },
            //    error: function (msg) {
            //        debugger;
            //        alert(msg.responseText);
            //        return false;
            //    }
            //});


            var methodUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQPortal/PortalMethods.aspx/AddFeedBackInfo";
            

            var feedBackArr = new Array();

       

                var FeedBack = new Object();

              

                    FeedBack["Title"] = $(<%= txtName.ClientID %>).val();

                    FeedBack["Name"] = $(<%= txtName.ClientID %>).val();

                    FeedBack["Email"] = $(<%= txtEmail.ClientID %>).val();

                    FeedBack["Phone"] = $(<%= txtPhone.ClientID %>).val();

                    FeedBack["CategoryId"] = $(<%= ddlCategory.ClientID %>).val();

            FeedBack["Comments"] = $(<%= txtComments.ClientID %>).val();
            FeedBack["Subject"] = $(<%= txtSubject.ClientID %>).val();


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

                url: methodUrl,
                success: function (result) {
                   
                    var output = result.d;
                    hideLoader();
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
      
            $("select[id*='ddlCategory']").empty();
            $.each(data.d.results, function (index, item) {
             
              
                if (language == "en-us") {


                    $("select[id*='ddlCategory']").append($('<option>', {
                        value: item.ID,
                        text: item.TitleEn
                    }));


                }


                else {

                    $("select[id*='ddlCategory']").append($('<option>', {
                        value: item.ID,
                        text: item.TitleAr
                    }));
                }
                hideLoader();

            });
            

  

        }

    

        function doErrorCCQDepartment(err) {
            alert(JSON.stringify(err));
        }
        $(document).ready(function () {
            getUserProfileDetails();
         getCCQDepartment();

            $(<%= btnSubmit.ClientID %>).click(function () {
                ShowLoader();
                $("#dvCategory").hide();
                $("#dvSubject").hide();
                $("#dvComments").hide();
                if ($(<%= txtComments.ClientID %>).val() != "" && $(<%= txtSubject.ClientID %>).val() != "" && $(<%= ddlCategory.ClientID %>).val() != "") {
                    AddFeedBack();
                    return false;
                }
                else if ($(<%= ddlCategory.ClientID %>).val() == "") {
                    hideLoader();
                    $("#dvCategory").show();
                    return false;
                }
                else if ($(<%= txtSubject.ClientID %>).val() == "") {
                    hideLoader();
                    $("#dvSubject").show();
                    return false;
                }
                else if ($(<%= txtComments.ClientID %>).val() == "") {
                    hideLoader();
                    $("#dvComments").show();
                    return false;
                  }
                hideLoader();
                return false;
            });
            $(<%= btnReset.ClientID %>).click(function () {
                ShowLoader();
                $(<%= txtSubject.ClientID %>).val("");
                $(<%= txtComments.ClientID %>).val("");
                $("#dvCategory").hide();
                $("#dvSubject").hide();
                $("#dvComments").hide();
                $("#dvSuccess").hide();
                hideLoader();
                return false;

            });
        });
    </script>