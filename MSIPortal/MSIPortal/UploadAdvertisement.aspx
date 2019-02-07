<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UploadAdvertisement.aspx.cs" Inherits="MSIPortal.UploadAdvertisement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    </head>
    <div>
        <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Width="100%"
            CssClass="MyTabStyle">
            <asp:TabPanel runat="server" HeaderText="TabPanelPostsByCategory" ID="TabPanelPostDetail">
                <HeaderTemplate>
                    Left Slider</HeaderTemplate>
                <ContentTemplate>
                    <div class="well">
                        <div class="control-group">
                            <label class="control-label" for="inputPassword1">
                                Image File</label>
                            <div class="controls">
                                <asp:FileUpload ID="fileUploadLeft" runat="server" /><asp:Label ID="vmEmail" runat="server"
                                    ForeColor="Red"></asp:Label></div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <input type="hidden" name="email_create" value="1">
                                <input type="hidden" name="is_new_customer" value="1">
                                <asp:Button class="btn btn-large btn-success" ID="btnLeftUpload" runat="server" Text="Upload"
                                    OnClick="btnLeftUpload_Click" />
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="inputPassword1">
                               </label>
                            <div class="controls">
                               <asp:Label ID="StatusLabel" runat="server"
                                    ForeColor="Red"></asp:Label></div>
                        </div>

                        <asp:GridView ID="GridView1" runat="server" CssClass="gridview" GridLines="None"
                            AutoGenerateColumns="False" AllowPaging="True" OnRowCommand="GridView1_RowCommand">
                            <AlternatingRowStyle CssClass="even" />
                            <Columns>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:Image ID="imageLeft" runat="server" ImageUrl="<%#Container.DataItem.ToString()%>"
                                            Height="90px" Width="120px"   /></ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Image Url">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUrl" runat="server" Text="<%#Container.DataItem.ToString()%>" /></ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" Text="Delete" CommandArgument="<%#Container.DataItem.ToString()%>" /></ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:TabPanel>
            <asp:TabPanel ID="TabPanelEditRank" runat="server" HeaderText="TabPanel4">
                <HeaderTemplate>
                    Right Slider</HeaderTemplate>
                <ContentTemplate>
                    <div class="well">
                        <div class="control-group">
                            <label class="control-label" for="inputPassword1">
                                Image File</label>
                            <div class="controls">
                                <asp:FileUpload ID="fileUploadRight" runat="server" /><asp:Label ID="Label1" runat="server"
                                    ForeColor="Red"></asp:Label></div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <asp:Button class="btn btn-large btn-success" ID="btnRightUpload" runat="server"
                                    Text="Upload" OnClick="btnRightUpload_Click" /></div>
                        </div>

                         <div class="control-group">
                            <label class="control-label" for="inputPassword1">
                               </label>
                            <div class="controls">
                               <asp:Label ID="StatusLabelRight" runat="server"
                                    ForeColor="Red"></asp:Label></div>
                        </div>
                      

                        <asp:GridView ID="GridView2" runat="server" CssClass="gridview" GridLines="None"
                            AutoGenerateColumns="False" AllowPaging="True" 
                            OnRowCommand="GridView2_RowCommand">
                            <AlternatingRowStyle CssClass="even" />
                            <Columns>
                                <asp:TemplateField HeaderText="Edit">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Image ID="imageRight" runat="server" ImageUrl="<%#Container.DataItem.ToString()%>"
                                            Height="90px" Width="120px"     /></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Image Url">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRight" runat="server" Text="<%#Container.DataItem.ToString()%>" /></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Button ID="btnRightEdit" runat="server" CommandArgument="<%#Container.DataItem.ToString()%>" Text="Delete" /></ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
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
            background: #FAFAFA;
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
    <style type="text/css">
        .imageBox
        {
            width: 400px;
            height: 400px;
            border: 1px solid gray;
            border-radius: 7px;
            box-shadow: 4px 4px 3px #888888;
        }
    </style>
<%--    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script language="javascript">

        $(document).ready(function () {
            $('img').hover(function () {
                $(this).css("cursor", "pointer");
                $(this).toggle({
                    effect: "scale",
                    percent: "90%"
                }, 200);
            }, function () {
                $(this).toggle({
                    effect: "scale",
                    percent: "80%"
                }, 200);

            });
        }); 


    </script>--%>
</asp:Content>
