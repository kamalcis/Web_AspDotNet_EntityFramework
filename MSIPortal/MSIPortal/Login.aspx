<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="MSIPortal.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <%--<form runat="server">--%>
       <asp:Panel ID="MessagePanel" runat="server" Visible="false">
       <div style="margin-left:180px; ">
           
       </div>        
       </asp:Panel>
        <div id="loginModal" class="modal show" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-center">
                           <%-- <i class="icon icon-lock"></i>--%>
                            <img src="Styles/images/lock-icon.png" />
                            
                           <span class="text">Login</span></h2>
                    </div>
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnLogin" Height="130px" 
                        Width="398px">
                    <div class="modal-body">
                        <div class="form col-md-12 center-block">

                        <div class="form-group">
                            
                            <asp:TextBox ID="txtUserName" runat="server" class="form-control input-lg" placeholder="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtPassword" runat="server" class="form-control input-lg" placeholder="Password"></asp:TextBox>
                        </div>
                            
                            
                        <div class="form-group">
                            <asp:Button ID="btnLogin" class="btn btn-success" runat="server" Text="Login" 
                                onclick="btnLogin_Click" />
                            
                            <span class="pull-right"></span><span>&nbsp;&nbsp;&nbsp;<a href="ForgetPassword.aspx">Forget password?</a></span>
                        </div>
                      
                        </div>
                    </div>
                      </asp:Panel>                 

                </div>
                 
            </div>
            
        </div>
        </br>
        <div style="margin-left:300px; width:300px;">
           <asp:Label ID="lblMessage" runat="server"  ForeColor="Red"></asp:Label>
        </div>
        
  <%--  </form>--%>
</asp:Content>
