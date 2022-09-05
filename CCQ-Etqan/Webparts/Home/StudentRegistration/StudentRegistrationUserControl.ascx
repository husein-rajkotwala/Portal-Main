<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StudentRegistrationUserControl.ascx.cs" Inherits="CCQ_Etqan.Webparts.Home.StudentRegistration.StudentRegistrationUserControl" %>
<script type="text/javascript">

    $(document).ready(function () {
        $('#ddlWorkshop').on('change', function () {
            var workshopDetails = searchWorkshop($(this).val());

            $("#txtStartDate").val(workshopDetails.StartDate);
            $("#txtEndDate").val(workshopDetails.EndDate);

        });
        $("#btnSubmit").click(function () {
            debugger;
            isStudentRegister();
        });

    });
    function searchWorkshop(Id) {
        var result = worshopArray.filter(function (item) {
            return item.ID === parseInt(Id);
        });
        return result[0];
    }
    function checkWorkshopISO(ISOValue, Id) {
        var isExist = false;

        for (var i = 0; i < worshopArray.length; i++) {
            if (worshopArray[i].ID != parseInt(Id)) {
                if (worshopArray[i].ISOStartDate == ISOValue) {
                    isExist = true;
                    return isExist;
                }
            }

        }

        return isExist;
       
    }
    function isStudentRegister() {
        var collStudenRegisterListItem;
        var currentUserEmail = _spPageContextInfo.userLoginName;
        var clientContext = new SP.ClientContext.get_current();
        var StudentRegistrationList = clientContext.get_web().get_lists().getByTitle('StudentRegistration');
        var camlQueryStudentRegister = new SP.CamlQuery();
        camlQueryStudentRegister.set_viewXml("<View><ViewFields><FieldRef Name='WorkShopName' /><FieldRef Name='WorkShopName_x003a_StartDate' /><FieldRef Name='Email' /><FieldRef Name='ID' /><FieldRef Name='Title' /><FieldRef Name='WorkShopName_x003a_ID' /></ViewFields><Query><Where><And><Eq><FieldRef Name='WorkShopName_x003a_ID' /><Value Type='Counter'>" + $("#ddlWorkshop").val() + "</Value></Eq><Eq><FieldRef Name='Email' /><Value Type='Text'>" + currentUserEmail + "</Value></Eq></And></Where><OrderBy><FieldRef Name='WorkShopStartDate' /></OrderBy></Query></View>");

        collStudenRegisterListItem = StudentRegistrationList.getItems(camlQueryStudentRegister);

        clientContext.load(collStudenRegisterListItem);

        clientContext.executeQueryAsync(function () {
            var selectWorkshopISODate = $("select[id='ddlWorkshop'] option:selected").attr("ISOString");
            var isTimingSame = checkWorkshopISO(selectWorkshopISODate, $("#ddlWorkshop").val());

            if (collStudenRegisterListItem.get_count() == 0 && isTimingSame==false) {
                RegisterStudent();
            }


            //$("#carouselItems").html(imageSliderHTML);

        }, function (sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        });
    }
    function checkExistingCourse() {
        var collStudenRegisterListItem;
        var currentUserEmail = _spPageContextInfo.userLoginName;
        var clientContext = new SP.ClientContext.get_current();
        var StudentRegistrationList = clientContext.get_web().get_lists().getByTitle('StudentRegistration');
        var workshopDetails = searchWorkshop($('#ddlWorkshop').val());
        var startDate = workshopDetails.ISOStartDate;
        var camlQueryCheckExistingCourse = new SP.CamlQuery();
        camlQueryCheckExistingCourse.set_viewXml("<View><ViewFields><FieldRef Name='WorkShopName' /><FieldRef Name='WorkShopName_x003a_StartDate' /><FieldRef Name='Email' /><FieldRef Name='ID' /><FieldRef Name='Title' /><FieldRef Name='WorkShopName_x003a_ID' /></ViewFields><Query><Where><And><Eq><FieldRef Name='WorkShopName_x003a_StartDate' /><Value Type='DateTime'>" + startDate + "</Value></Eq><Eq><FieldRef Name='Email' /><Value Type='Text'>" + currentUserEmail + "</Value></Eq></And></Where><OrderBy><FieldRef Name='WorkShopStartDate' /></OrderBy></Query></View>");
        //camlQuery.set_viewXml("<View><ViewFields><FieldRef Name='WorkShopName' /><FieldRef Name='WorkShopStartDate' /><FieldRef Name='Email' /><FieldRef Name='ID' /><FieldRef Name='Title' /></ViewFields><Query><Where><And><And><Geq><FieldRef Name='WorkShopStartDate' /><Value Type='DateTime'>" + moment().toISOString() + "</Value></Geq><Eq><FieldRef Name='Status' /><Value Type='Choice'>Active</Value></Eq></And><Eq><FieldRef Name='Email' /><Value Type='Text'>" + currentUserEmail + "</Value></Eq></And></Where><OrderBy><FieldRef Name='WorkShopStartDate' /></OrderBy></Query></View>");
        collStudenRegisterListItem = StudentRegistrationList.getItems(camlQueryCheckExistingCourse);
        clientContext.load(collStudenRegisterListItem);
        clientContext.executeQueryAsync(function () {

            if (collStudenRegisterListItem.get_count() == 0) {
                RegisterStudent();
            }


            //$("#carouselItems").html(imageSliderHTML);

        }, function (sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        });
    }

    function RegisterStudent() {
        var methodUrl = _spPageContextInfo.siteAbsoluteUrl + "/_layouts/15/CCQEtqan/EtqanMethods.aspx/AddRegisterStudent";


        var studentArr = new Array();



        var Student = new Object();



        Student["Title"] = $("#txtEmail").val();

        Student["Name"] = $("#txtFullName").val();

        Student["Email"] = $("#txtEmail").val();
        Student["Gender"] = userGender;


        Student["Phone"] = $("#txtPhone").val();

        Student["WorkShopNameId"] = $("#ddlWorkshop").val();

        studentArr.push(Student);

        var DTO = { 'StudentRegistration': studentArr };
        var test = JSON.stringify(DTO);
        console.log(test);
        $.ajax({

            contentType: "application/json; charset=utf-8",

            data: JSON.stringify(DTO),

            dataType: "json",

            type: "POST",

            url: methodUrl,
            success: function (result) {

               
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
</script>
<div class="inner-page" id="dvStudentRegistration">
        <div class="container p-3">
            <div class="row">
                <div class="col-lg-12">
                    
                    
                    <div class="card border-ccq mt-3">
                        <div class="card-header border-ccq">
                        <i class="fas fa-clipboard-list"></i>  التسجيل في الورش
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="workshop">الورشة</label>
                                        <select id="ddlWorkshop" class="form-control" name="workshop">
                                            
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="start_date">تاريخ البدء</label>
                                        <input type="text" class="form-control" id="txtStartDate" name="start_date"  disabled>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="end_date">تاريخ الإنتهاء</label>
                                        <input type="text" class="form-control" id="txtEndDate" name="end_date"  disabled>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="full_name">الاسم</label>
                                        <input type="text" class="form-control" id="txtFullName" name="full_name"  disabled>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="gender">النوع</label>
                                        <input type="text" class="form-control" id="txtGender" name="gender"  disabled>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="email">البريد الإلكتروني</label>
                                        <input type="text" class="form-control" id="txtEmail" name="email"  disabled>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="phone">رقم الهاتف</label>
                                        <input type="text" class="form-control" id="txtPhone" name="phone" disabled>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <input type="button"  class="btn btn-primary" id="btnSubmit" value="تسجيل" />
                                    </div>
                                </div>
                            </form>
                            
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>