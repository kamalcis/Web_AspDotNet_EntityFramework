<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ApprovePost.aspx.cs" Inherits="MSIPortal.ApprovePost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Styles/PaggingButton.css" rel="stylesheet" type="text/css" />
    <div class="well">
        <h5>
            Pending Approval List</h5>
    </div>
    <div class="well">
        <%--  <form id="form1" runat="server">--%>
        <asp:Label ID="lblNoRecordMessage" runat="server" Visible="false" ForeColor="Green"></asp:Label>
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview" GridLines="None"
            ShowHeader="true" AlternatingRowStyle-CssClass="even" AutoGenerateColumns="false"
            AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="hiddenPostId" runat="Server" Value='<%#Eval("PostID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- <asp:ImageField DataImageUrlField="ImageUrl" ControlStyle-CssClass="image" />--%>
                
                  <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <%--<asp:Image ID="Image1" runat="server"  ImageUrl='<%# Eval("ImageUrl") +"?id="+ Eval("PostID") %>'  ControlStyle-CssClass="image"/>--%>
                         <asp:Image ID="Image2" runat="server"  ImageUrl='<%# GetImageUrl(Convert.ToString(Eval("ImageUrl")))+"?id="+ Eval("PostID") %>'  ControlStyle-CssClass="image"/>    
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField DataField="PostTitle" HeaderText="Title" HeaderStyle-HorizontalAlign="Left"
                    ReadOnly="true" />
                <asp:BoundField DataField="EditDate" DataFormatString="{0:MMMM d, yyyy}" ReadOnly="true" />
                <asp:BoundField DataField="Rank" HeaderText="Rank" HeaderStyle-HorizontalAlign="Left" ReadOnly="true" />
                <asp:HyperLinkField Text="Show Detail" DataNavigateUrlFormatString="ViewEditApproval.aspx?ID={0}"
                    DataNavigateUrlFields="PostID" />
                <asp:TemplateField>
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkCheckAll" OnCheckedChanged="SelectAll_CheckChanged" AutoPostBack="true"
                            runat="server" />
                        Select All
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkItem" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div style="height: 10px">
        </div>
        <div id="GridFooter">
            <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Right">
                <%--  <asp:Button ID="btnFirst" class="btn btn-page" runat="server" Text="First" />
                   <asp:Button ID="btnNext" class="btn btn-page" runat="server" Text="Next" />
                    <asp:Label ID="Label2" Width="70px"  runat="server" Text="1/10" style="text-align: center;"></asp:Label>
                   <asp:Button ID="btnPrevious" class="btn btn-page" runat="server" Text="Prev" />
                   <asp:Button ID="btnLast" class="btn btn-page" runat="server" Text="Last" />--%>
                <asp:Button ID="btnApprove" class="btn btn-primary" runat="server" Text="Approve"
                    OnClick="btnApprove_Click" />
            </asp:Panel>
        </div>
        <%-- </form>--%>
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
</asp:Content>
