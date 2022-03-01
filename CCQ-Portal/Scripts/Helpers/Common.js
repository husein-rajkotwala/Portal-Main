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
lang = getCookie("lang");
$(document).ready(function () {
    getUserApplication();
});

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
function getUserApplication() {
    var methodUrl = location.origin + "/_layouts/15/CCQPortal/PortalMethods.aspx/getUserApplications";
    $.ajax({

        contentType: "application/json; charset=utf-8",

        data: {},

        dataType: "json",

        type: "POST",

        url: methodUrl,
        success: function (result) {

            var output = JSON.parse(result.d);
            if (output.Resources.length > 0) {

                if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].currentapplications)[0] != "" && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].currentapplications)[0]  != null) {
                    currentApplications = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].currentapplications)[0];
                }
                if (output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].category[0] != "" && output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].category[0] != null) {
                    userCategory = output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].category[0];
                }
                if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].mobilephone)[0] != "" && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].mobilephone)[0] != null) {
                    mobileNumber = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].mobilephone)[0];
                }
            }
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
                    if (data.d.UserProfileProperties.results[57].Value != null && data.d.UserProfileProperties.results[57].Value != "")
                    {
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