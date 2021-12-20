<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQServicesUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.CCQServices.CCQServicesUserControl" %>
<div class="container-fluid">
<div class="row">
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-light-blue">
        <a href="#" class="text-white">
            <i class="fas fa-cog fa-4x"></i>
            <h5 class="text-uppercase pt-2">E-Services</h5>
        </a>
    </div>
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-dark-blue">
        <a href="#" class="text-white" data-toggle="modal" data-target="#useful_contacts">
            <i class="far fa-envelope fa-4x"></i>
            <h5 class="text-uppercase pt-2">Useful Contacts</h5>
        </a>
    </div>
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-dark-blue">
        <a href="#" class="text-white">
            <i class="fas fa-users fa-4x"></i>
            <h5 class="text-uppercase pt-2">Staff Directory</h5>
        </a>
    </div>
    <div class="col-md-3 col-xl-6 col-sm-6 text-center py-5 bg-light-blue">
        <a href="#" class="text-white" data-toggle="modal" data-target="#feedback">
            <i class="far fa-comments fa-4x"></i>
            <h5 class="text-uppercase pt-2">Feedback</h5>
        </a>
    </div>


<!-- Useful Contacts Modal -->
<div class="modal fade" id="useful_contacts" tabindex="-1" aria-labelledby="Useful_Contacts_M" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="Useful_Contacts_M">Useful Contacts</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th scope="row">1</th>
                            <td>Test Test Test</td>
                            <td>testtest@ccq.edu.qa</td>
                            <td>44445555</td>
                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td>Test Test Test</td>
                            <td>testtest@ccq.edu.qa</td>
                            <td>44445555</td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td>Test Test Test</td>
                            <td>testtest@ccq.edu.qa</td>
                            <td>44445555</td>
                        </tr>
                        </tbody>    
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>
<!-- End of Useful Contacts Modal -->

<!-- Feedback Modal -->
<div class="modal fade" id="feedback" tabindex="-1" aria-labelledby="Feedback_M" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="Feedback_M">Feedback</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="full_name">Full Name</label>
                            <input type="text" class="form-control" id="full_name" name="full_name">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="email">Email</label>
                            <input type="text" class="form-control" id="email" name="email">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="phone">Phone</label>
                            <input type="text" class="form-control" id="phone" name="phone">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="category">Category</label>
                            <select id="category" class="form-control" name="category">
                                <option selected>--Please Select--</option>
                                <option>...</option>
                                <option>...</option>
                                <option>...</option>
                            </select>
                        </div>
                        <div class="form-group col-md-12">
                            <label for="comment">Comment</label>
                            <textarea class="form-control" id="comment" rows="3" name="comment"></textarea>
                        </div>
                        <div class="form-group col-md-12">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</div>