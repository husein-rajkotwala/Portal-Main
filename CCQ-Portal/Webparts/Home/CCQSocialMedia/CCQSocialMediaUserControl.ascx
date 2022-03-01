<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCQSocialMediaUserControl.ascx.cs" Inherits="CCQ_Portal.Webparts.Home.CCQSocialMedia.CCQSocialMediaUserControl" %>
<style>


#pills-twitter{ 
    height: 400px; 
    overflow-y: auto;
}
</style>
<div class="social-media">
    <ul class="nav nav-pills nav-justified" id="pills-tab2" role="tablist">
        <li class="nav-item text-center" role="presentation">
            <a class="nav-link pill1 active" id="pills-twitter-tab" data-toggle="pill" href="#pills-twitter" role="tab" aria-controls="pills-twitter" aria-selected="true"><i class="fab fa-twitter fa-2x text-white"></i></a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link pill2" id="pills-facebook-tab" data-toggle="pill" href="#pills-facebook" role="tab" aria-controls="pills-facebook" aria-selected="false"><i class="fab fa-facebook-f fa-2x text-white"></i></a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link pill3" id="pills-instagram-tab" data-toggle="pill" href="#pills-instagram" role="tab" aria-controls="pills-instagram" aria-selected="false"><i class="fab fa-instagram fa-2x text-white"></i></a>
        </li>
    </ul>
    <div class="tab-content p-3" id="pills-tab2Content">

        <div class="tab-pane fade show active" id="pills-twitter" role="tabpanel" aria-labelledby="pills-twitter-tab">
              <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

            <a class="twitter-timeline" href="https://twitter.com/CommunityCQ?ref_src=twsrc%5Etfw">Tweets by TwitterDev</a>

        </div>

        <div class="tab-pane fade" id="pills-facebook" role="tabpanel" aria-labelledby="pills-facebook-tab">
          <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v13.0" nonce="oP6LoJnc"></script>
            <div class="fb-page" data-href="https://www.facebook.com/facebook" data-tabs="timeline" data-width="" data-height="" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><blockquote cite="https://www.facebook.com/facebook" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/facebook">Meta</a></blockquote></div>
        </div>

        <div class="tab-pane fade" id="pills-instagram" role="tabpanel" aria-labelledby="pills-instagram-tab">
            <ul class="list-group">
                <li class="list-group-item"><i class="fab fa-instagram fa-1x text-light-red1 pr-2-cust"></i> An item</li>
                <li class="list-group-item"><i class="fab fa-instagram fa-1x text-light-red1 pr-2-cust"></i> A second item</li>
                <li class="list-group-item"><i class="fab fa-instagram fa-1x text-light-red1 pr-2-cust"></i> A third item</li>
                <li class="list-group-item"><i class="fab fa-instagram fa-1x text-light-red1 pr-2-cust"></i> A fourth item</li>
                <li class="list-group-item"><i class="fab fa-instagram fa-1x text-light-red1 pr-2-cust"></i> And a fifth one</li>
                <li class="list-group-item"><i class="fab fa-instagram fa-1x text-light-red1 pr-2-cust"></i> And a fifth one</li>
            </ul>
        </div>

    </div>
</div>
