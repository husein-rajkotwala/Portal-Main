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
var userQatarId = {

};
var userGender = {

};
var currentUserApplications = "";
var worshopArray = [];

$(document).ready(function () {

    getSailPointInfo()

    // getUserTableInformation();
});

function GetUpcomingWorkshops() {
    var collListItem;
    var clientContext = new SP.ClientContext.get_current();
    var upcomingWorkShopList = clientContext.get_web().get_lists().getByTitle('CCQWorkshops');
    var camlQuery = new SP.CamlQuery();
    camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='StartDate' /><FieldRef Name='EndDate' /><FieldRef Name='Level' /><FieldRef Name='Instructor' /><FieldRef Name='Title' /><FieldRef Name='ID' /><FieldRef Name='Description' /></ViewFields><Query><Where><And><And><Geq><FieldRef Name='StartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Geq><Eq><FieldRef Name='Active' /><Value Type='Boolean'>1</Value></Eq></And><Gt><FieldRef Name='Seatsleft' /><Value Type='Number'>0</Value></Gt></And></Where><OrderBy><FieldRef Name='StartDate' /></OrderBy></Query></View>");
    collUpcomingWorkshopListItem = upcomingWorkShopList.getItems(camlQuery);
    clientContext.load(collUpcomingWorkshopListItem);
    clientContext.executeQueryAsync(function () {
        var listItemEnumerator = collUpcomingWorkshopListItem.getEnumerator();

        $("#ddlWorkshop").empty();
        while (listItemEnumerator.moveNext()) {
            var oListItem = listItemEnumerator.get_current();

            //var startDateMonth = moment(oListItem.get_item("StartDate")).format('MMMM');
            var startDate = moment(oListItem.get_item("StartDate")).format('Do MMMM  YYYY, h:mm a');
            var endDate = moment(oListItem.get_item("EndDate")).format('Do MMMM  YYYY, h:mm a');
            var instructor = oListItem.get_item("Instructor");
            var Id = oListItem.get_item("ID");

            var workShopTitle = oListItem.get_item("Title");
            var workShopDescription = oListItem.get_item("Description");
            var workshopDetails = {
                "Title": workShopTitle,
                "StartDate": startDate,
                "EndDate": endDate,
                "Instructor": instructor,
                "ID": Id

            };
            worshopArray.push(workshopDetails);
            $("#ddlWorkshop").append($("<option></option>").val(Id).html(workShopTitle));
            $("#txtStartDate").val(startDate);
            $("#txtEndDate").val(endDate);
            index++;
        }

        //$("#carouselItems").html(imageSliderHTML);
    }, function (sender, args) {
        console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
    });
}

function bindStudentRegistration() {

    SP.SOD.executeFunc("sp.js", "SP.ClientContext", function () {
        GetUpcomingWorkshops();
    });
}
function doSucessAPIUserApplication() {
    $("#txtFullName").val(userDisplayName);
    $("#txtGender").val(userGender);
    $("#txtEmail").val(_spPageContextInfo.userLoginName);
    $("#txtPhone").val(mobileNumber);
    $("#txtEmail").val(_spPageContextInfo.userLoginName);

    bindStudentRegistration();



}
function doErrorAPIUserApplication() {


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


function getSailPointInfo() {
    var methodUrl = _spPageContextInfo.webAbsoluteUrl + "/_layouts/15/CCQEtqan/EtqanMethods.aspx/getUserApplications";
    // var methodUrl = location.origin + "/_layouts/15/CCQPortal/PortalMethods.aspx/getUserApplications2323232";
    try {

        $.ajax({

            contentType: "application/json; charset=utf-8",

            data: {},

            dataType: "json",

            type: "POST",

            url: methodUrl,

        }).done(function (result) {
            try {
                var output = JSON.parse(result.d);
                if (output.Resources.length > 0) {

                    if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].applications)[0] != "" && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].applications)[0] != null) {
                        currentApplications = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].applications)[0];
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
                    if (output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].genderstatus[0] != null && output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].genderstatus[0] != "") {
                        userGender = output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].genderstatus[0];
                    }
                    if (JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].qatarid)[0] != null && JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].qatarid)[0] != "") {
                        userQatarId = JSON.parse(output.Resources[0]["urn:ietf:params:scim:schemas:sailpoint:1.0:User"].qatarid)[0];
                    }
                    if (output.Resources[0].displayName != "" && output.Resources[0].displayName != null) {

                        userDisplayName = output.Resources[0].displayName;
                    }

                }
                if (userSamAccountName != undefined && userCategory != undefined && currentApplications != undefined && userDisplayName != undefined) {
                    if (userCategory == "Banner Student" || userCategory == "Student") {
                        doSucessAPIUserApplication();
                    }
                }
                else {
                    doFailAPIUserApplication();
                    console.log('Calling UserTable');
                }
            }
            catch (err) {
                doFailAPIUserApplication();
                console.log('Calling UserTable');

            }

        }).fail(function (jqXHR, textStatus, errorThrown) {


            doFailAPIUserApplication();
            console.log('Calling UserTable');


        });
    }
    catch (err) {

        //doFailAPIUserApplication();
        console.log('Calling UserTable');

    }

}
function doFailAPIUserApplication() {

    ///getUserTableInformation();
}




