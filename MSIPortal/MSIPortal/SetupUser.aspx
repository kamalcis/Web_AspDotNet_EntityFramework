<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="SetupUser.aspx.cs" Inherits="MSIPortal.SetupUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="well">
        <%-- <form id="Form1" class="form-horizontal" runat="server">--%>
        <input type="hidden" name="is_new_customer" value="1">
        <input type="hidden" name="email_create" value="1">
        <h4>
            User Setup</h4>
        <div class="control-group">
            <label class="control-label" for="inputPassword1">
                Email</label>
            <div class="controls">
                <asp:TextBox ID="txtEmail" runat="server" onblur="ClearValidationMark()"></asp:TextBox>
                <asp:Label ID="vmEmail" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                Password</label>
            <div class="controls">
                <asp:TextBox ID="txtPassword" runat="server" onblur="ClearValidationMark()"></asp:TextBox>
                <asp:Label ID="vmPassword" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                Confirm Password</label>
            <div class="controls">
                <asp:TextBox ID="txtConfirmPassword" runat="server" onblur="ClearValidationMark()"></asp:TextBox>
                <asp:Label ID="vmConfirmPassword" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                First Name</label>
            <div class="controls">
                <asp:TextBox ID="txtFirstName" runat="server" onblur="ClearValidationMark()"></asp:TextBox>
                <asp:Label ID="vmFirstName" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                Last Name</label>
            <div class="controls">
                <asp:TextBox ID="txtLastName" runat="server" onblur="ClearValidationMark()"></asp:TextBox>
                <asp:Label ID="vmLastName" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                User Role</label>
            <div class="controls">
                <asp:DropDownList ID="ddlUserType" runat="server" onblur="ClearValidationMark()">
                    <asp:ListItem Value="0">Select One</asp:ListItem>
                    <asp:ListItem Value="001">Admin</asp:ListItem>
                    <asp:ListItem Value="002">Ordinary</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="vmUserRole" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                City</label>
            <div class="controls">
                <asp:DropDownList ID="ddlCity" runat="server" onblur="ClearValidationMark()">
                </asp:DropDownList>
                <asp:Label ID="vmCity" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <input type="hidden" name="email_create" value="1">
                <input type="hidden" name="is_new_customer" value="1">
                <asp:Button runat="server" class="btn btn-primary" type="submit" Text="Save" ID="btnSave"
                    OnClick="btnSave_Click" OnClientClick="return ValidateForm()" />
            </div>
        </div>
        <div style="width: 100%; height: 10px;">
        </div>
        <div class="control-group">
            <label class="control-label">
            </label>
            <asp:Panel ID="MessagePanel" Visible="true" runat="server">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblSuccessMessage" runat="server"></asp:Label>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
            </asp:Panel>
        </div>
        <%-- </form>--%>
    </div>
    <script type="text/javascript">


        function ValidateForm() {

            document.getElementById('<%=lblSuccessMessage.ClientID%>').innerHTML = ""; // Make sure there is no success message

            if (document.getElementById('<%=txtEmail.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Email required";
                document.getElementById('<%=vmEmail.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtEmail.ClientID%>').focus();
                return false;
            }


            if (document.getElementById('<%=txtEmail.ClientID%>') != "") {
                var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
                var emailField = document.getElementById('<%=txtEmail.ClientID%>');
                if (reg.test(emailField.value) == false) {

                    document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Invalid email address";
                    document.getElementById('<%=vmEmail.ClientID%>').innerHTML = "*";
                    document.getElementById('<%=txtEmail.ClientID%>').focus();
                    return false;
                }

            }



            if (document.getElementById('<%=txtPassword.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Password required";
                document.getElementById('<%=vmPassword.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtPassword.ClientID%>').focus();
                return false;
            }



            if (document.getElementById('<%=txtConfirmPassword.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Confirm password required";
                document.getElementById('<%=vmConfirmPassword.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtFirstName.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "First name required";
                document.getElementById('<%=vmFirstName.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtFirstName.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtLastName.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Last name required";
                document.getElementById('<%=vmLastName.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtLastName.ClientID%>').focus();
                return false;
            }



            if (document.getElementById('<%=ddlUserType.ClientID%>').value == "0") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "User role required";
                document.getElementById('<%=vmUserRole.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlUserType.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlCity.ClientID%>').value == "0") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "City required";
                document.getElementById('<%=vmCity.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCity.ClientID%>').focus();
                return false;
            }


        }


        function ClearValidationMark() {

            if (document.getElementById('<%=vmEmail.ClientID%>').value != "") {
                document.getElementById('<%=vmEmail.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtPassword.ClientID%>').value != "") {
                document.getElementById('<%=vmPassword.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtConfirmPassword.ClientID%>').value != "") {
                document.getElementById('<%=vmConfirmPassword.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtFirstName.ClientID%>').value != "") {
                document.getElementById('<%=vmFirstName.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtLastName.ClientID%>').value != "") {
                document.getElementById('<%=vmLastName.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlUserType.ClientID%>').value != "0") {
                document.getElementById('<%=vmUserRole.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlCity.ClientID%>').value != "0") {
                document.getElementById('<%=vmCity.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }



        }


    </script>
</asp:Content>
