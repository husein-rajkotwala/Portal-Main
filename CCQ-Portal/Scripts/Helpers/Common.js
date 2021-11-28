var lang = {

};
var userOURole = {

};

lang = getCookie("lang");

checkUserRole();


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