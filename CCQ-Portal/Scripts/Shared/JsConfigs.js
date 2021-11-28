/*
 Start ---- General code for calling API from client side.
 */

class SPSharedApiSettings {
    static HEADERTOKEN = "basic MjA1MDMzNDYwMTgwMDAyOjMzODJmYTYyMGNkYWUwMzAxNWIxNTAxNTM1ZTU4MTUy";
    //static apiHeaders = {
    //    'AuthToken': 'basic MjA1MDMzNDYwMTgwMDAyOjMzODJmYTYyMGNkYWUwMzAxNWIxNTAxNTM1ZTU4MTUy'
    //};
}

class SPConstants {
    // Employee directory
    static EMPLOYEEDIRECTORYAPPNAME = "EmployeeDirectory";
    static EMPLOYEEDIRECTORYBASEURL = "#/";
    static EMPLOYEEDIRECTORYSEARCHURL = "#Search";
    static EMPLOYEEDIRECTORYDEFAULTURL = SPConstants.EMPLOYEEDIRECTORYBASEURL;
    static EMPLOYEEDIRETORYPROFILEURL = "#Profile/"; // append staff no


}

class SPSharedApiUrls {

    /****API Urls*****/

    static lang = "en";
    static APIBASEURL = `http://localhost:5555/${this.lang}/api`;
    // ********************************************************* //
    // Business Unit 
    // ********************************************************* //
    /* GET: */
    static AllDIRECTORATESAPI = `${this.APIBASEURL}/businessunit/directorates`;
    /* GET:
     *  Append DirectorateId as optional. full url will be like
     *  <baseUrl>/businessunit/departments OR
     *  <baseUrl>/businessunit/departments/<DirectorateId>
     */
    static ALLDEPARTMENTSAPI = `${this.APIBASEURL}/businessunit/departments`;
    /* GET:
     *  Append DirectorateId AND/OR DepartmentId. both are optional params. full url will be like
     *  <baseUrl>/businessunit/sections OR
     *  <baseUrl>/businessunit/sections/<DirectorateId> OR
     *  <baseUrl>/businessunit/sections?DepartmentId=<DepartmentId> OR
     *  <baseUrl>/businessunit/sections/<DirectorateId>
     */
    static ALLSECTIONSAPI = `${this.APIBASEURL}/businessunit/sections`;
    // ********************************************************* //
    // Employee
    // ********************************************************* //
    /* POST: */
    static SEARCHEMPLOYEE = `${this.APIBASEURL}/employee/Search`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/compensationinfo/<StaffNo>
     */
    static EMPLOYEECOMPENSATIONINFO = `${this.APIBASEURL}/employee/compensationinfo/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/image/<StaffNo>
     */
    static EMPLOYEEIMAGE = `${this.APIBASEURL}/employee/image/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/staffdetails/<username>/<StaffNo>/<email>
     *  Pass atleast one param to this api
     *  <baseUrl>/employee/staffdetails?username=<username?>&staffNo=<staffNo?>&email=<email?>
     */
    static EMPLOYEESTAFFDETAILS = `${this.APIBASEURL}/employee/staffdetails`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/employeeofmonth/<StaffNo>
     */
    static EMPLOYEEOFTHEMONTH = `${this.APIBASEURL}/employee/employeeofmonth/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/generalInfo/<StaffNo>
     */
    static EMPLOYEEGENERALINFO = `${this.APIBASEURL}/employee/generalInfo/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/assets/<StaffNo>
     */
    static EMPLOYEEASSETS = `${this.APIBASEURL}/employee/assets/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/personalinfo/<StaffNo>
     */
    static EMPLOYEEPERSONALINFO = `${this.APIBASEURL}/employee/personalinfo/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/miscellaneousinfo/<StaffNo>
     */
    static EMPLOYEEMISCELLANEOUSINFO = `${this.APIBASEURL}/employee/miscellaneousinfo/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/leaveyears/<StaffNo>
     */
    static EMPLOYEELEAVEYEARS = `${this.APIBASEURL}/employee/leaveyears/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/officialtripyears/<StaffNo>
     */
    static EMPLOYEEOFFICIALTRIPYEARS = `${this.APIBASEURL}/employee/officialtripyears/`;
    /* GET:
     *  Append staff no and year. full url will be like
     *  <baseUrl>/employee/leavesdetail/<StaffNo>/<Year>
     */
    static EMPLOYEELEAVESDETAIL = `${this.APIBASEURL}/employee/leavesdetail/`;
    /* GET:
     *  Append staff no and year. full url will be like
     *  <baseUrl>/employee/leavesdetail/<StaffNo>/<Year>
     */
    static EMPLOYEEOFFICIALTRIPS = `${this.APIBASEURL}/employee/officialtrips/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/educationdetails/<StaffNo>
     */
    static EMPLOYEEEDUCATIONDETAILS = `${this.APIBASEURL}/employee/educationdetails/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/experiencedetails/<StaffNo>
     */
    static EMPLOYEEEXPERIENCEDETAILS = `${this.APIBASEURL}/employee/experiencedetails/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/delegationinfo/<StaffNo>
     */
    static EMPLOYEEDELEGATIONINFO = `${this.APIBASEURL}/employee/delegationinfo/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/namebystaffno/<StaffNo>
     */
    static EMPLOYEENAMEBYSTAFFNO = `${this.APIBASEURL}/employee/namebystaffno/`;
    /* GET:
     *  Append staff no. full url will be like
     *  <baseUrl>/employee/deletemanagernote/<StaffNo>
     */
    static EMPLOYEEDELETEEMPLOYEEMANAGERNOTE = `${this.APIBASEURL}/employee/deletemanagernote/`;

    /* POST: */
    static EMPLOYEEINSERTDELEGATION = `${this.APIBASEURL}/employee/insertdelegation`;
    static EMPLOYEEINSERTEMPLOYEEMANAGERNOTE = `${this.APIBASEURL}/employee/insertmanagernote`;

    //User
    /*
        append username or staffno and application name
        identity/{userName?}/{staffNo?}/{appName?}
     */
    static USERIDENTITY = `${this.APIBASEURL}/user/identity`;
    /*
        append username or loggedInStaffNo, staffno and application name
        authenticate/{userName?}/{loggedInStaffNo?}/{staffNo?}/{appName?}
     */
    static AUTHENTICATEUSER = `${this.APIBASEURL}/user/authenticate`;

    // ********************************************************* //
    // Common OR Shared API
    // ********************************************************* //
    /* GET: */
    static DELEGATIONREASONS = `${this.APIBASEURL}/shared/delegationreasons`;

    constructor() {

        SPSharedApiUrls.lang = this.getCookie("lang");
        // Get API base url from server config list
        var filter = "Title eq 'SharedAPI' or Title eq 'SharedApiToken'";
        this.getSPConfigurationValue(filter, function (data) {
            $.each(data.d.results, function (index, item) {
                if (item.Title === 'SharedAPI') {
                    SPSharedApiUrls.APIBASEURL = item.Value.replace('{lang}', SPSharedApiUrls.lang);

                    // Business Unit 
                    SPSharedApiUrls.AllDIRECTORATESAPI = `${SPSharedApiUrls.APIBASEURL}/businessunit/directorates`;
                    SPSharedApiUrls.ALLDEPARTMENTSAPI = `${SPSharedApiUrls.APIBASEURL}/businessunit/departments`;
                    SPSharedApiUrls.ALLSECTIONSAPI = `${SPSharedApiUrls.APIBASEURL}/businessunit/sections`;

                    // Employee
                    SPSharedApiUrls.EMPLOYEEIMAGE = `${SPSharedApiUrls.APIBASEURL}/employee/image/`;
                    SPSharedApiUrls.EMPLOYEESTAFFDETAILS = `${SPSharedApiUrls.APIBASEURL}/employee/staffdetails`;
                    SPSharedApiUrls.EMPLOYEEOFTHEMONTH = `${SPSharedApiUrls.APIBASEURL}/employee/employeeofmonth/`;
                    SPSharedApiUrls.SEARCHEMPLOYEE = `${SPSharedApiUrls.APIBASEURL}/employee/Search`;
                    SPSharedApiUrls.EMPLOYEECOMPENSATIONINFO = `${SPSharedApiUrls.APIBASEURL}/employee/compensationinfo/`;
                    SPSharedApiUrls.EMPLOYEEGENERALINFO = `${SPSharedApiUrls.APIBASEURL}/employee/generalInfo/`;
                    SPSharedApiUrls.EMPLOYEEASSETS = `${SPSharedApiUrls.APIBASEURL}/employee/assets/`;
                    SPSharedApiUrls.EMPLOYEEPERSONALINFO = `${SPSharedApiUrls.APIBASEURL}/employee/personalinfo/`;
                    SPSharedApiUrls.EMPLOYEELEAVEYEARS = `${SPSharedApiUrls.APIBASEURL}/employee/leaveyears/`;
                    SPSharedApiUrls.EMPLOYEELEAVESDETAIL = `${SPSharedApiUrls.APIBASEURL}/employee/leavesdetail/`;
                    SPSharedApiUrls.EMPLOYEEEDUCATIONDETAILS = `${SPSharedApiUrls.APIBASEURL}/employee/educationdetails/`;
                    SPSharedApiUrls.EMPLOYEEEXPERIENCEDETAILS = `${SPSharedApiUrls.APIBASEURL}/employee/experiencedetails/`;
                    SPSharedApiUrls.EMPLOYEEDELEGATIONINFO = `${SPSharedApiUrls.APIBASEURL}/employee/delegationinfo/`;
                    SPSharedApiUrls.EMPLOYEENAMEBYSTAFFNO = `${SPSharedApiUrls.APIBASEURL}/employee/namebystaffno/`;
                    SPSharedApiUrls.EMPLOYEEINSERTDELEGATION = `${SPSharedApiUrls.APIBASEURL}/employee/insertdelegation`;
                    SPSharedApiUrls.EMPLOYEEOFFICIALTRIPS = `${SPSharedApiUrls.APIBASEURL}/employee/officialtrips/`;
                    SPSharedApiUrls.EMPLOYEEOFFICIALTRIPYEARS = `${SPSharedApiUrls.APIBASEURL}/employee/officialtripyears/`;
                    SPSharedApiUrls.EMPLOYEEMISCELLANEOUSINFO = `${SPSharedApiUrls.APIBASEURL}/employee/miscellaneousinfo/`;
                    SPSharedApiUrls.EMPLOYEEINSERTEMPLOYEEMANAGERNOTE = `${SPSharedApiUrls.APIBASEURL}/employee/insertmanagernote`;
                    SPSharedApiUrls.EMPLOYEEDELETEEMPLOYEEMANAGERNOTE = `${SPSharedApiUrls.APIBASEURL}/employee/deletemanagernote/`;

                    //User
                    SPSharedApiUrls.USERIDENTITY = `${SPSharedApiUrls.APIBASEURL}/user/identity`;
                    SPSharedApiUrls.AUTHENTICATEUSER = `${SPSharedApiUrls.APIBASEURL}/user/authenticate`;

                    // Common OR Shared API
                    SPSharedApiUrls.DELEGATIONREASONS = `${SPSharedApiUrls.APIBASEURL}/shared/delegationreasons`;


                    // Get Current user
                    // SPSharedApiUrls.getCurrentUser();
                    /*  if (SP.ClientContext != null) {
                              SP.SOD.executeOrDelayUntilScriptLoaded(SPSharedApiUrls.getCurrentUser, 'SP.js');
                      } else {
                              SP.SOD.executeFunc('sp.js', null, SPSharedApiUrls.getCurrentUser);
                      }*/
                }
                else if (item.Title === 'SharedApiToken') {
                    SPSharedApiSettings.HEADERTOKEN = `basic ${item.Value}`;
                    //SPSharedApiSettings.apiHeaders['AuthToken'] = `basic ${item.Value}`;
                    $.ajaxSetup({
                        beforeSend: function (jqXHR) {
                            jqXHR.setRequestHeader("AuthToken", SPSharedApiSettings.HEADERTOKEN);
                            var staffNo = getCookie('staffNo');
                            jqXHR.setRequestHeader("LoggedInStaffNo", staffNo);
                            // headers = {'AuthToken': SPSharedApiSettings.HEADERTOKEN};
                            return true;
                        }
                        //headers: SPSharedApiSettings.apiHeaders
                    });
                }
            });
        }, function () {
            alert(JSON.stringify(err));
        });





    }

    getSPConfigurationValue = function (filter, onSuccess, onError) {
        var getSiteUrl = _spPageContextInfo.siteAbsoluteUrl;
        var Title = "Configurations";
        var ID = "";
        var Select = "";
        var orderBy = "";
        var top = "";
        var restWeb = new RESTApiHelper.Web(getSiteUrl + "");
        var myList = new restWeb.List(Title);
        var items = new myList.Items();

        items.GetItems(Select, filter, orderBy, top, onSuccess, onError);
    };

    getCookie(cname) {
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
    };




    /*
     
     */
    static SetupHeaders() {
        $.ajaxSetup({
            beforeSend: function (jqXHR) {
                jqXHR.setRequestHeader("AuthToken", SPSharedApiSettings.HEADERTOKEN);
                //var isExecuted = false;
                //var currentUser = getCookie('currentUser');
                //  jqXHR.setRequestHeader("CurrentUser", currentUser);
                var staffNo = getCookie('staffNo');
                jqXHR.setRequestHeader("LoggedInStaffNo", staffNo);
                return true;
            }
        });
    }

    static getActiveUser = function (appName, callback) {

        var staffNo = getCookie('staffNo');
        if (staffNo == null || staffNo == undefined || staffNo == "") {
            var currentUser;
            if (SP.ClientContext != null) {
                SP.SOD.executeOrDelayUntilScriptLoaded(SPSharedApiUrls.getCurrentUser(appName, callback), 'SP.js');
            } else {
                SP.SOD.executeFunc('sp.js', null, SPSharedApiUrls.getCurrentUser(appName, callback));
            }
        } else {
            SPSharedApiUrls.fetchUserIdenity(staffNo, "", appName, callback);
        }
    }


    static getCurrentUser = function (appName, callback) {
        context = new SP.ClientContext.get_current();
        web = context.get_web();
        currentUser = web.get_currentUser();
        context.load(currentUser);
        context.executeQueryAsync(SPSharedApiUrls.onSuccessMethod(args = callback), SPSharedApiUrls.onRequestFail);
    }

    static onSuccessMethod = function (sender, args) {
        var userID = currentUser.get_id();
        var userLoginName = currentUser.get_loginName();
        var userName = currentUser.get_title();
        currentUserAccount = userLoginName.substring(userLoginName.indexOf("\\") + 1);

        SPSharedApiUrls.fetchUserIdenity("", currentUserAccount, appName, args);

    }

    static onRequestFail = function (sender, args) {
        alert('request failed' + args.get_message());
    }

    static fetchUserIdenity = function (staffNo, userName, appName, callback) {

        var userIdentityUrl = `${SPSharedApiUrls.USERIDENTITY}?userName=${userName}&staffNo=${staffNo}&appName=${appName}`;
        $.getJSON(userIdentityUrl, function (result) {
            if (result == null || result == undefined)
                return;
            // console.log(result);
            if (result.HasError)
                return;
            //setCookie("currentUser", result.Data.User);
            setCookie("staffNo", result.Data.StaffNo);
            if (callback)
                callback(result.Data);
        });
    }

    static AuthenticateUser(userName, staffNo, appName, callback) {
        var loggedInStaffNo = getCookie('staffNo');
        var userIdentityUrl = `${SPSharedApiUrls.AUTHENTICATEUSER}?userName=${userName}&loggedInStaffNo=${loggedInStaffNo}&staffNo=${staffNo}&appName=${appName}`;
        $.getJSON(userIdentityUrl, function (result) {
            if (result == null || result == undefined)
                return;
            // console.log(result);
            if (result.HasError || result.Data == null || result.Data == undefined)
                return;
            //setCookie("currentUser", result.Data.User);
            //setCookie("staffNo", result.Data.StaffNo);
            if (callback)
                callback(result.Data, loggedInStaffNo);
        });
    }

    static APIGet(url, data, onSuccessCallback) {
        SPSharedApiUrls.SetupHeaders();
        $.getJSON(url, data, function (result) {
            if (result == null || result == undefined)
                return;
            if (!result.HasError)
                //local.Leaves(result.Data);
                if (onSuccessCallback)
                    onSuccessCallback(result.Data);
        });
    }
}
var obj = new SPSharedApiUrls();

/*
 End ---- General code for calling API from client side.
 */
