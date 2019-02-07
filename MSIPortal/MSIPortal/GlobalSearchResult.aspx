<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="GlobalSearchResult.aspx.cs" Inherits="MSIPortal.GlobalSearchResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="well">
                <div style="height: 30px;">
                    <strong>
                        <asp:Label ID="lblRecordCount" runat="server" Font-Size="Medium"></asp:Label>
                        &#8658;
                        <asp:Label ID="lblRecordText" Text="Records found." runat="server"></asp:Label>
                    </strong>
                </div>
                <%--   <form id="form1" runat="server">--%>

                <asp:GridView ID="GridView1" runat="server" CssClass="gridview" GridLines="None"
                    ShowHeader="false" AlternatingRowStyle-CssClass="even" AutoGenerateColumns="false"
                    AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>
                        <%--   <asp:ImageField DataImageUrlField="ImageUrl"  ControlStyle-CssClass="image" />--%>
                        <%--  <asp:Image ID="Image1" runat="server"  ImageUrl='<%# Eval("ImageUrl") +"?id="+ Eval("PostID") %>'  ControlStyle-CssClass="image"/> --%>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <%--<asp:Image ID="Image1" runat="server"  ImageUrl='<%# Eval("ImageUrl") +"?id="+ Eval("PostID") %>'  ControlStyle-CssClass="image"/>--%>
                                <asp:Image ID="Image2" runat="server" ImageUrl='<%# GetImageUrl(Convert.ToString(Eval("ImageUrl")))+"?id="+ Eval("PostID") %>'
                                    ControlStyle-CssClass="image" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--  <asp:TemplateField>
         
            <ItemTemplate>
                <img src='data:image/jpg;base64,<%# Eval("AdImage") != System.DBNull.Value ? Convert.ToBase64String((byte[])Eval("AdImage")) : string.Empty %>' alt="AdImage" height="80" width="150"/>
            </ItemTemplate>
        </asp:TemplateField>--%>
                        <asp:BoundField DataField="PostTitle" ReadOnly="true" />
                        <asp:BoundField DataField="EditDate" DataFormatString="{0:MMMM d, yyyy}" ReadOnly="true" />
                        <%--  <asp:BoundField DataField="Price"  ReadOnly="true" />--%>
                        <asp:HyperLinkField Text="Show Detail" DataNavigateUrlFormatString="ViewDetails.aspx?ID={0}"
                            DataNavigateUrlFields="PostID" />
                    </Columns>
                </asp:GridView>
                <%--    </form>--%>
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
                        background: #7AC142;
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
