<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="MSIPortal.AdminPanel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%-- <form id="Form1" runat="server">--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
          <div class="well">
<div style="margin:0 auto; width:350px; ">
    
    
    <asp:ImageButton ID="ImageButtonUser" runat="server" 
        ImageUrl="~/Styles/images/user.png" onclick="ImageButtonUser_Click" />
    &nbsp;&nbsp;&nbsp;
    <asp:ImageButton ID="ImageButtonCountry" runat="server" 
        ImageUrl="~/Styles/images/country.png" 
        onclick="ImageButtonCountry_Click" />
    &nbsp;&nbsp;&nbsp;
    <asp:ImageButton ID="ImageButtonCity" runat="server" 
        ImageUrl="~/Styles/images/city.png" onclick="ImageButtonCity_Click" />
    &nbsp;&nbsp;&nbsp;
   

</div>

<div style="margin:0 auto; width:350px; ">
    <asp:ImageButton ID="ImageButtonCategory" runat="server" 
        ImageUrl="~/Styles/images/category.png" 
        onclick="ImageButtonCategory_Click" />
    &nbsp;&nbsp;&nbsp;
    <asp:ImageButton ID="ImageButtonApprove" runat="server" 
        ImageUrl="~/Styles/images/approve.png" 
        onclick="ImageButtonApprove_Click" />
        &nbsp;&nbsp;&nbsp;
           <asp:ImageButton ID="ImageButtonSearch" runat="server" 
        ImageUrl="~/Styles/images/search.png" 
        onclick="ImageButtonSearch_Click"   />
        &nbsp;&nbsp;&nbsp;
</div>

<div style="margin:0 auto; width:350px; ">
    <asp:ImageButton ID="ImageButtonRank" runat="server" 
        ImageUrl="~/Styles/images/rank.png" 
        onclick="ImageButtonRank_Click" />
    &nbsp;&nbsp;&nbsp;

     <asp:ImageButton ID="ImageButtonAdvertisement" runat="server" 
        ImageUrl="~/Styles/images/Advertisements.png" onclick="ImageButtonAdvertisement_Click" 
         />
    &nbsp;&nbsp;&nbsp;
   
</div>

</div>
    </ContentTemplate>
    </asp:UpdatePanel>
     

<%--</form>--%>
</asp:Content>


