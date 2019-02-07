<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageCity.aspx.cs" Inherits="MSIPortal.ManageCity" %>



<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    </head>
    <div>
        <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="1" Width="100%"
            CssClass="MyTabStyle">
            <asp:TabPanel ID="TabPanelCreateCity" runat="server" HeaderText="TabPanel2">
                <HeaderTemplate>Create City</HeaderTemplate>
                <ContentTemplate><div class="well"><div class="control-group"><label class="control-label" for="input_email">City Name <sup>*</sup></label> <div class="controls"><asp:TextBox ID="txtCity" placeholder="City Name" runat="server"></asp:TextBox><asp:Label ID="vmCityName" runat="server" ForeColor="Red"></asp:Label></div></div><div class="control-group"><div class="controls"><input type="hidden" name="email_create" value="1">
                                <input type="hidden" name="is_new_customer" value="1">
                                <asp:Button class="btn btn-large btn-success" ID="btnSave" runat="server" OnClientClick="javascript: return ValidateChangePassword();"
                                    Text="Save" OnClick="btnSave_Click"></asp:Button>
                            </div></div><div class="control-group"><label class="control-label"></label><asp:Panel ID="Panel1" runat="server">&#160;&#160;&#160;&#160;&#160; <asp:Label ID="cpSuccessMessage" runat="server"></asp:Label><asp:Label ID="cpErrorMessage" runat="server" ForeColor="Red"></asp:Label></asp:Panel></div></div></ContentTemplate>
            </asp:TabPanel>
            <asp:TabPanel ID="TabPanelCityList" runat="server" HeaderText="TabPanel3">
                <HeaderTemplate>City List</HeaderTemplate>
                <ContentTemplate><div class="well"><asp:GridView ID="GridView1" runat="server" CssClass="gridview" GridLines="None"
                            AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging"
                            OnRowCommand="GridView1_RowCommand" ShowHeader="False"><AlternatingRowStyle CssClass="even" /><Columns><asp:BoundField HeaderText="SL No" DataField="CityId" ReadOnly="True" /><asp:BoundField HeaderText="City Name" DataField="CityName" ReadOnly="True" /><asp:TemplateField HeaderText="Edit"><ItemTemplate><asp:Button ID="btnEdit" CommandName="Modify" CommandArgument='<%# Eval("CityId") %>'
                                            runat="server" Text="Edit" /></ItemTemplate></asp:TemplateField></Columns></asp:GridView></div></ContentTemplate>
            </asp:TabPanel>
            <asp:TabPanel ID="TabPanelEditCity" runat="server" HeaderText="TabPanel4">
                <HeaderTemplate>Edit City</HeaderTemplate>
                <ContentTemplate><div class="well"><h5>City Edit</h5><div class="control-group"><label class="control-label">City* <sup></sup></label><div class="controls"><asp:TextBox ID="txtCityForEdit" runat="server"></asp:TextBox><asp:Label ID="lblCityValidationEdit" runat="server" ForeColor="Red"></asp:Label></div></div><div class="control-group"><div class="controls"><input type="hidden" name="email_create" value="1">
                                <input type="hidden" name="is_new_customer" value="1">
                                <asp:Button class="btn btn-large btn-success" ID="btnUpdate" OnClientClick="return ValidateForm();"
                                    runat="server" Text="Update" OnClick="btnUpdate_Click" />
                            </div></div><div style="width: 100%; height: 10px;"></div><div class="control-group"><label class="control-label"></label><asp:Panel ID="MessagePanel" runat="server">&#160;&#160;&#160;&#160;&#160; <asp:Label ID="lblSuccessMessage" runat="server"></asp:Label><asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label></asp:Panel></div></div><script type="text/javascript">

                        function IsNumeric(evt) {
                            var charCode = (evt.which) ? evt.which : event.keyCode;
                            return (charCode <= 31 || charCode == 46 || (charCode >= 48 && charCode <= 57));
                        }

                        function ValidateForm() {

                            document.getElementById('<%=lblSuccessMessage.ClientID%>').innerHTML = ""; // Make sure there is no success message           

                            if (document.getElementById('<%=txtCityForEdit.ClientID%>').value == "0") {
                                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "City required";
                                document.getElementById('<%=lblCityValidationEdit.ClientID%>').innerHTML = "*";
                                document.getElementById('<%=txtCityForEdit.ClientID%>').focus();
                                return false;
                            }



                        }





                        function ClearValidationMark() {

                            if (document.getElementById('<%=txtCityForEdit.ClientID%>').value != "") {
                                document.getElementById('<%=lblCityValidationEdit.ClientID%>').innerHTML = "";
                                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
                            }




                        }


                      


                    </script></ContentTemplate>
            </asp:TabPanel>
        </asp:TabContainer>
    </div>
    <style type="text/css">
        .gridview
        {
            font-family: "arial";
            background-color: #FFFFFF;
            width: 100%;
            font-size: small;
        }
        .gridview th
        {
            /*background: #7AC142;*/
            background: #f5f5f5;
            padding: 5px;
            font-size: small;
        }
        .gridview th a
        {
            color: #003300;
            text-decoration: none;
        }
        .gridview th a:hover
        {
            color: #003300;
            text-decoration: underline;
        }
        .gridview td
        {
            background: #D9EDC9;
            color: #333333;
            font: small "arial";
            padding: 10px;
        }
        .gridview tr.even td
        {
            background: #FFFFFF;
        }
        .gridview td a
        {
            color: #003300;
            font: bold small "arial";
            padding: 4px;
            text-decoration: none;
        }
        .gridview td a:hover
        {
            color: red;
            font-weight: bold;
            text-decoration: underline;
        }
        .image
        {
            max-width: 120px;
            height: 90px;
            border: 1px solid gray;
            border-radius: 7px;
            box-shadow: 4px 4px 3px #888888;
        }
    </style>
    <style type="text/css">
        .MyTabStyle .ajax__tab_header
        {
            font-family: "Helvetica Neue" , Arial, Sans-Serif;
            font-size: 14px;
            font-weight: bold;
            display: block;
        }
        .MyTabStyle .ajax__tab_header .ajax__tab_outer
        {
            border-color: #222;
            color: #222;
            padding-left: 10px;
            margin-right: 3px;
            border: solid 1px #d7d7d7;
        }
        .MyTabStyle .ajax__tab_header .ajax__tab_inner
        {
            border-color: #666;
            color: #666;
            padding: 3px 10px 2px 0px;
        }
        .MyTabStyle .ajax__tab_hover .ajax__tab_outer
        {
            background-color: #9c3;
        }
        .MyTabStyle .ajax__tab_hover .ajax__tab_inner
        {
            color: #fff;
        }
        .MyTabStyle .ajax__tab_active .ajax__tab_outer
        {
            border-bottom-color: #ffffff; /*background-color: #d7d7d7;*/
            background-color: #f5f5f5; /* background-color:#9c3;*/
        }
        .MyTabStyle .ajax__tab_active .ajax__tab_inner
        {
            color: #000;
            border-color: #333;
        }
        /*
        .MyTabStyle .ajax__tab_body
        {
            font-family: verdana,tahoma,helvetica;
            font-size: 10pt;
            background-color: #fff;
            border-top-width: 0;
            border: solid 1px #d7d7d7;
            border-top-color: #ffffff;
        }*/
    </style>
</asp:Content>