﻿<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCLanguageSwitcher.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCLanguageSwitcher" %>


<script type="text/javascript" src="https://unpkg.com/@popperjs/core@2.11.2/dist/umd/popper.min.js"></script>

<script>
$(function(){
    $('[data-toggle="tooltip"]').tooltip();
});

</script>                          
                                <li class="nav-item px-md-2">
                                 <asp:LinkButton ID="lbarabic" runat="server"  class="nav-link menu-item"  OnClick="lbarabic_Click" data-toggle="tooltip" data-placement="left" title="عربي" data-original-title="عربي"><i class="fas fa-globe"></i></asp:LinkButton>

<asp:LinkButton ID="lbEnglish" runat="server" class="nav-link menu-item"  OnClick="lbEnglish_Click" data-toggle="tooltip" data-placement="left" title="English" data-original-title="English"><i class="fas fa-globe"></i></asp:LinkButton>
                                </li>
