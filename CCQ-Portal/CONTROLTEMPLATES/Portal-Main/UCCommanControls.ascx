﻿<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>


<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCCommanControls.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCCommanControls" %>

  
                          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#dvchange_password"><asp:Label ID="lblChangePassword" runat="server" Text='<%$ resources:ChangePassword%>'></asp:Label></a>
                            <a class="dropdown-item" href="#"  data-toggle="modal" data-target="#profile_modal"><asp:Label ID="lblProfile" runat="server" Text='<%$ resources:Profile%>'></asp:Label></a>
<asp:LinkButton ID="btnLogoutout" runat="server" Text='<%$ resources:Logout%>' OnClick="btnLogoutout_Click"  class="dropdown-item"></asp:LinkButton> 
