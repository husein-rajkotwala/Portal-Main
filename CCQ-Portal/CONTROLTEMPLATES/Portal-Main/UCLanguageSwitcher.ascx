<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCLanguageSwitcher.ascx.cs" Inherits="CCQ_Portal.CONTROLTEMPLATES.Portal_Main.UCLanguageSwitcher" %>




<ul class="navbar-nav side-menu">
                                <li class="nav-item px-md-2 bg-light-blue rounded text-center">
                                    <a class="nav-link menu-item" href="#"><%=GetLocalResourceObject("MyCCQ")%>
                                    </a>
                                </li>
                                <li class="nav-item px-md-2">
                                 <asp:LinkButton ID="lbarabic" runat="server"   Text="عربي" class="nav-link menu-item"  OnClick="lbarabic_Click"></asp:LinkButton>

<asp:LinkButton ID="lbEnglish" runat="server" Text="English" class="nav-link menu-item"  OnClick="lbEnglish_Click"></asp:LinkButton>
                                </li>
                            </ul>