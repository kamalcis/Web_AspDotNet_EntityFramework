<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="MSIPortal.ForgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div class="well">
       <%-- <form id="Form1" class="form-horizontal" runat="server">--%>
        <h4>
            Password recovery</h4>
       
        <div class="control-group">
            <label class="control-label" for="inputPassword1">
                Email</label>
            <div class="controls">
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtEmail" runat="server" ErrorMessage="Email required" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
        </div>
       

        <div class="control-group">
            <div class="controls">
                <input type="hidden" name="email_create" value="1">
                <input type="hidden" name="is_new_customer" value="1">
                <asp:Button runat="server" class="btn btn-primary" type="submit" Text="Submit"  OnClientClick="ValidateForm()"
                    ID="btnSave" onclick="btnSave_Click"   />
            </div>
        </div>


         <div style="width:100%;height:10px;">
        
        </div>

        <div class="control-group">
              
              <label class="control-label">
                </label>

              <asp:Panel ID="MessagePanel"  Visible="true" runat="server">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblSuccessMessage" runat="server" ></asp:Label>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" ></asp:Label>
            </asp:Panel>
        </div>
       <%-- </form>--%>
    </div>

     <script type="text/javascript">


         function ValidateForm() {

             document.getElementById('<%=lblSuccessMessage.ClientID%>').innerHTML = "";

         }

        </script>

</asp:Content>

