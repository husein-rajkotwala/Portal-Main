var lang = {

};
var userOURole = {

};
var Name =
{
};
var Email = {

};
var Phone = {

};
var currentApplications = {

};
var mobileNumber = {

};
var userCategory = {

};
var userSamAccountName = {

};
var userAlternativeEmail = {

};
var userDisplayName = {

};
lang = getCookie("lang");
var currentUserApplications = "";
var currentUserAppArray = [];

$(document).ready(function () {

    getSailPointInfo()
});

function getCCQUserProfile() {

    if (mobileNumber != "" && mobileNumber) {

        if (mobileNumber.includes('+974')) {
            mobileNumber = mobileNumber.replace("+974", "");
            $("#txtmobile").val(mobileNumber);
        }
        if (mobileNumber.includes('974')) {
            mobileNumber = mobileNumber.replace("974", "");
            $("#txtmobile").val(mobileNumber);
        }
        else {
            $("#txtmobile").val(mobileNumber);
        }
    }
    else {
        $("#txtmobile").val("");
    }
    if (userAlternativeEmail != "" && userAlternativeEmail) {
        $("#txtalt_email").val(userAlternativeEmail);
    }
    else {
        $("#txtalt_email").val("");
    }

}
function doSucessAPIUserApplication() {
    getTopNavigation();
    bindUserDisplayInformation();
    getUserProfileDetails();
    getCCQUserProfile();

    if ($("#dvApplication").length > 0) {
        getCCQApplcations();
    }
    if ($("#dvUsefulLinks").length > 0) {
        getCCQUsefulLinks();
    }
}
function doErrorAPIUserApplication() {


}
function getCCQUsefulLinks() {
    var Title = "CCQUseFulLinks";
    var ID = "";
    var Filter = "Role eq '" + userCategory + "' or Role eq 'All'and Active eq 1";

    var Select = "";
    var orderBy = "SortOrder";
    var top = "";
    var restWeb = new RESTApiHelper.Web(siteUrl);
    var myList = new restWeb.List(Title);
    var items = new myList.Items();
    if (ID != '')
        items.GetItemByID(ID, doSuccess, doError);
    else
        items.GetItems(Select, Filter, orderBy, top, doSuccessCCQUsefulLinks, doSuccessCCQUsefulLinks);
}
function doSuccessCCQUsefulLinks(data) {
    var usefulLinkHTML = "";


    $.each(data.d.results, function (index, item) {
        var checkIndex = "";
        var applicationTitle = "";
        //var applicationImage = $($(item.ApplicationImage)[0]).find("img").attr("src");
        var applicationUrl = item.ApplicationUrl.Url;

        if (checkIndex != -1) {

            if (lang == "en-us") {
                applicationTitle = item.TitleEn;
            }
            else {
                applicationTitle = item.TitleAr;
            }
            usefulLinkHTML += '<a href=' + applicationUrl + ' target="_blank" ><i class="fas fa-external-link-alt"></i> ' + applicationTitle + '</a><br/>'
        }

    });


    $("#dvUsefulLinks").html(usefulLinkHTML);

}
function doErrorCCQUsefulLinks(err) {

}
function getCCQApplcations() {
    var Title = "CCQApps";
    var ID = "";
   // var Filter = "Role eq '" + userCategory + "' and Active eq 1 or Role eq 'All'";
    var Filter = "Role eq '" + userCategory + "' or Role eq 'All'and Active eq 1";

    var Select = "";
    var orderBy = "";
    var top = "";
    var restWeb = new RESTApiHelper.Web(siteUrl);
    var myList = new restWeb.List(Title);
    var items = new myList.Items();
    if (ID != '')
        items.GetItemByID(ID, doSuccess, doError);
    else
        items.GetItems(Select, Filter, orderBy, top, doSuccessCCQApplcations, doErrorCCQApplcations);
}
function doSuccessCCQApplcations(data) {
    var userApplicationHTML = "";


    $.each(data.d.results, function (index, item) {
        var checkIndex = "";
        var applicationTitle = "";
        var applicationImage = $($(item.ApplicationImage)[0]).find("img").attr("src");
        var applicationUrl = item.ApplicationUrl.Url;
        currentUserAppArray = currentApplications.split(',');
        if (item.Role.results[0] != "All") {
            checkIndex = jQuery.inArray(item.ApplicationType, currentUserAppArray)
        }
        if (checkIndex != -1) {

            if (lang == "en-us") {
                applicationTitle = item.ApplicationTitleEn;
            }
            else {
                applicationTitle = item.ApplicationTitleAr;
            }
            userApplicationHTML += '<div class="col-lg-3 col-sm-6 col-md-4 my-2 px-1 col-xl-3">';
            userApplicationHTML += '<div class="card border-0 card-shadow text-center p-2">';
            userApplicationHTML += '<a class=""  target="_blank" href=' + applicationUrl + '>'
            userApplicationHTML += '<img src=' + applicationImage + '  class="card-img-top">';
            userApplicationHTML += '</a>';
            userApplicationHTML += '<div class="card-body">';
            userApplicationHTML += '<a href=' + applicationUrl + ' class="card-title-link" target="_blank"><p class="card-text"  target="_blank">' + applicationTitle + '</p></a>';
            userApplicationHTML += '</div>';
            userApplicationHTML += '</div>';
            userApplicationHTML += '</div>';
        }

    });


    $("#dvApplication").html(userApplicationHTML);

}
function doErrorCCQApplcations(err) {

}
function getTopNavigation() {
    var siteUrl = _spPageContextInfo.siteAbsoluteUrl;
    var language = lang;
    var Title = "TopNavigation";
    var ID = "";
    var Filter = "Role eq '" + userCategory + "' or Role eq 'All'and Active eq 1";
    var Select = "";
    var orderBy = "SortOrder asc";
    var top = "";
    var restWeb = new RESTApiHelper.Web(siteUrl);
    var myList = new restWeb.List(Title);
    var items = new myList.Items();
    if (ID != '')
        items.GetItemByID(ID, doSuccess, doError);
    else
        items.GetItems(Select, Filter, orderBy, top, doSuccessTopNavigation, doErrorTopNavigation);
}



function doSuccessTopNavigation(data) {
    var htmlTopNav = "";
    var userRoleDetails = userCategory;

    $.each(data.d.results, function (index, item) {
        if (lang == "en-us") {

            htmlTopNav += item.htmlEn;

        }
        else {

            htmlTopNav += item.htmlAr;

        }

    });
    $("#MainNav").html(htmlTopNav);


}
function doErrorTopNavigation(err) {
    alert(JSON.stringify(err));
}
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
function bindUserDisplayInformation() {
    $(".fa-user-circle").append(userDisplayName);
}
function getSailPointInfo() {
    var methodUrl = location.origin + "/_layouts/15/CCQPortal/PortalMethods.aspx/getUserApplications";
    // var methodUrl = location.origin + "/_layouts/15/CCQPortal/PortalMethods.aspx/getUserApplications2323232";

    $.ajax({

        contentType: "application/json; charset=utf-8",

        data: {},

        dataType: "json",

        type: "POST",

        url: methodUrl,

    }).done(function (result) {

        var output = JSON.parse(result.d);
        if (output.Resources.length > 0) {

            if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].currentapplications)[0] != "" && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].currentapplications)[0] != null) {
                currentApplications = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].currentapplications)[0];
            }
            if (output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].category[0] != "" && output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].category[0] != null) {
                userCategory = output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].category[0];
            }
            if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].mobilephone)[0] != "" && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].mobilephone)[0] != null) {
                mobileNumber = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].mobilephone)[0];
            }
            if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].samaccountname)[0] != null && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].samaccountname)[0] != "") {
                userSamAccountName = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].samaccountname)[0];
            }
            if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].alternateemail)[0] != null && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].alternateemail)[0] != "") {
                userAlternativeEmail = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].alternateemail)[0];
            }
            if (output.Resources[0].displayName != "" && output.Resources[0].displayName != null) {

                userDisplayName = output.Resources[0].displayName;
            }
        }
        if (userSamAccountName != undefined && userCategory != undefined && currentApplications != undefined && userDisplayName != undefined) {
            doSucessAPIUserApplication();
        }
        else {
            doFailAPIUserApplication();
            console.log('Calling UserTable');
        }

    }).fail(function (jqXHR, textStatus, errorThrown) {


        doFailAPIUserApplication();
        console.log('Calling UserTable');


    });

}

function doFailAPIUserApplication() {

    getUserTableInformation();
}

function getUserTableInformation() {
    currentUserEmail = _spPageContextInfo.userLoginName;
    var Title = "CCQUserSSO";
    var ID = "";
    var Filter = "EMAILS eq '" + currentUserEmail + "'";
    var Select = "";
    var orderBy = "";
    var top = "";
    var restWeb = new RESTApiHelper.Web(siteUrl);
    var myList = new restWeb.List(Title);
    var items = new myList.Items();
    if (ID != '')
        items.GetItemByID(ID, doSuccess, doError);
    else
        items.GetItems(Select, Filter, orderBy, top, doSuccessUserTableInformation, doErrorUserTableInformation);
}



function doSuccessUserTableInformation(data) {

    $.each(data.d.results, function (index, item) {

        if (item.CURRENTAPPLICATIONS != "" && item.CURRENTAPPLICATIONS != null) {
            currentUserApplications = item.CURRENTAPPLICATIONS;
            // currentUserAppArray = currentUserApplications.split(',');
        }

        if (item.CATEGORY != "" && item.CATEGORY != null) {
            currentUserRole = item.CATEGORY;

        }
        if (item.DISPLAYNAME != "" && item.DISPLAYNAME != null) {
            userDisplayName = item.DISPLAYNAME;

        }
        if (item.SAMACCOUNTNAME != "" && item.SAMACCOUNTNAME != null) {
            userSamAccountName = item.SAMACCOUNTNAME;

        }



    });
    //if (currentUserRole != null && currentUserRole != "")
    {
        userCategory = currentUserRole;

        currentApplications = currentUserApplications;
        bindUserDisplayInformation();
        getTopNavigation();
        getUserProfileDetails();
        getCCQApplcations();
        getCCQUsefulLinks();


    }




}
function doErrorUserTableInformation(err) {

}
function checkUserRole() {
    var userOUDetails = "";
    var userRole = "";
    var url = location.origin + "/_api/sp.userprofiles.peoplemanager/GetMyProperties/?$select=UserProfileProperties";
    $.ajax({
        async: false,
        headers: { "accept": "application/json; odata=verbose" },
        method: "GET",
        url: url,
        success: function (data) {

            if (data != null) {
                if (data.d.UserProfileProperties["results"][44].Value != null) {
                    userOUDetails = data.d.UserProfileProperties["results"][44].Value;
                    Name = data.d.UserProfileProperties["results"][8].Value;
                    if (data.d.UserProfileProperties.results[57].Value != null && data.d.UserProfileProperties.results[57].Value != "") {
                        Email = data.d.UserProfileProperties["results"][57].Value;

                    }
                    if (data.d.UserProfileProperties.results[10].Value != null && data.d.UserProfileProperties.results[10].Value != "") {
                        Phone = data.d.UserProfileProperties["results"][10].Value;

                    }
                    var userOUArray = userOUDetails.split("OU=Students");
                    if (userOUArray.length > 1) {
                        return userOURole = "Student";

                    }
                    userOUArray = userOUDetails.split("OU=President");
                    if (userOUArray.length > 1) {
                        return userOURole = "Staff";

                    }
                    else {
                        return userOURole = "Common";

                    }

                }
            }



        },
        error: function (response) {
            return userRole;
            console.log(response.status);
        },
    });
}