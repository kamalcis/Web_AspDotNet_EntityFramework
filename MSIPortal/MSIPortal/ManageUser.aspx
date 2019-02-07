<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageUser.aspx.cs" Inherits="MSIPortal.ManageUser" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    </head>
    <div>
        <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="2" Width="100%"
            CssClass="MyTabStyle">
            <asp:TabPanel ID="TabPanelCreateUser" runat="server" HeaderText="TabPanel4">
                <HeaderTemplate>
                    Create New User</HeaderTemplate>
                <ContentTemplate>
                    <div class="well">
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
                                <asp:Button runat="server" class="btn btn-primary" type="submit" Text="Save" ID="Button1"
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
                </ContentTemplate>
            </asp:TabPanel>
            <asp:TabPanel ID="TabPanelUserList" runat="server" HeaderText="TabPanel3">
                <HeaderTemplate>
                    User List</HeaderTemplate>
                <ContentTemplate>
                    <div class="well">
                        <asp:GridView ID="GridView1" runat="server" CssClass="gridview" GridLines="None"
                            AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging"
                            OnRowEditing="GridView1_RowEditing" 
                            OnRowDataBound="GridView1_RowDataBound" onrowupdating="GridView1_RowUpdating">
                            <AlternatingRowStyle CssClass="even" />
                            <Columns>
                                <asp:BoundField HeaderText="User Name" DataField="LoginName" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="First Name" DataField="FirstName" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Last Name" DataField="LastName" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                
                                <asp:BoundField HeaderText="City" DataField="cityName" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Creation Date" DataField="EditDate" DataFormatString="{0:MMMM d, yyyy}"
                                    ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Role" >
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownListRole" runat="server" Width="80px" Height="25px">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator Width="10px" ID="RequiredFieldValidator1" runat="server" ControlToValidate= "DropDownListRole" InitialValue="0" ForeColor="Red"  ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblRole" runat="server" Text='<%# Convert.ToInt32(Eval("RoleID"))==1? "Admin":"Ordinary"  %>' /></ItemTemplate>
                                </asp:TemplateField>

                                
                                <asp:TemplateField HeaderText="Edit">
                                    
                                    <EditItemTemplate>
                                        <div style="margin-bottom:10px;">
                                        <asp:Button ID="btnUpdate" CommandName="Update" CommandArgument='<%# Eval("LoginName") %>'
                                            runat="server" Text="Update" />
                                         </div>
                                        </EditItemTemplate>
                                            
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" CommandName="Edit" CommandArgument='<%# Eval("LoginName") %>'
                                            runat="server" Text="Edit" /></ItemTemplate>
                                </asp:TemplateField>
                               

                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:TabPanel>
            
            <asp:TabPanel ID="TabPanelChangePassword" runat="server" HeaderText="TabPanel4">
                <HeaderTemplate>
                    Change Password</HeaderTemplate>
                <ContentTemplate>
                    <div class="well">

                        <div class="control-group">
                            <label class="control-label" for="input_email">
                                &nbsp;</label>
                            <div class="controls">
                                <input id="chkShow" type="checkbox" onclick="OnCheckBoxClick()"/>
                                <asp:Label ID="Label1" runat="server" Text="Show Password" ForeColor="Black"></asp:Label></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input_email">
                                Existing Password <sup>*</sup></label>
                            <div class="controls">
                                <asp:TextBox ID="txtExistingPassword" placeholder="Existing Password" onblur="ClearChangePassword()"
                                    runat="server" TextMode="Password"></asp:TextBox><asp:Label ID="vmExistingPassword" runat="server" ForeColor="Red"></asp:Label></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input_email">
                                New Password <sup>*</sup></label>
                            <div class="controls">
                                <asp:TextBox ID="txtNewPassword" placeholder="New Password" runat="server" 
                                    onblur="ClearChangePassword()" TextMode="Password"></asp:TextBox><asp:Label
                                    ID="vmNewPassword" runat="server" ForeColor="Red"></asp:Label></div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="input_email">
                                Confirm New Password <sup>*</sup></label>
                            <div class="controls">
                                <asp:TextBox ID="txtConfirmNewPassword" placeholder="Confirm New Password" onblur="ClearChangePassword()"
                                    runat="server" TextMode="Password"></asp:TextBox><asp:Label ID="vmConfirmNewPassword" runat="server"
                                        ForeColor="Red"></asp:Label></div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <input type="hidden" name="email_create" value="1">
                                <input type="hidden" name="is_new_customer" value="1">
                                <asp:Button class="btn btn-large btn-success" ID="btnUpdatePassword" runat="server"
                                    OnClientClick="javascript: return ValidateChangePassword();" Text="Update" OnClick="btnUpdatePassword_Click"></asp:Button>


                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                            </label>
                            <asp:Panel ID="Panel1" runat="server">
                                &#160;&#160;&#160;&#160;&#160;
                                <asp:Label ID="cpSuccessMessage" runat="server"></asp:Label><asp:Label ID="cpErrorMessage"
                                    runat="server" ForeColor="Red"></asp:Label></asp:Panel>
                        </div>
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
    <script type="text/javascript">
        //===========For Change Password
        function ValidateChangePassword() {

            document.getElementById('<%=cpSuccessMessage.ClientID%>').innerHTML = "";
            document.getElementById('<%=cpErrorMessage.ClientID%>').innerHTML = "";

            if (document.getElementById('<%=txtExistingPassword.ClientID%>').value == "") {
                document.getElementById('<%=cpErrorMessage.ClientID%>').innerHTML = "Existing password required";
                document.getElementById('<%=vmExistingPassword.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtExistingPassword.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtNewPassword.ClientID%>').value == "") {
                document.getElementById('<%=cpErrorMessage.ClientID%>').innerHTML = "Existing password required";
                document.getElementById('<%=vmNewPassword.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtNewPassword.ClientID%>').focus();
                return false;
            }


            if (document.getElementById('<%=txtConfirmNewPassword.ClientID%>').value == "") {
                document.getElementById('<%=cpErrorMessage.ClientID%>').innerHTML = "Existing password required";
                document.getElementById('<%=vmConfirmNewPassword.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtConfirmNewPassword.ClientID%>').focus();
                return false;
            }


        }



        function ClearChangePassword() {

            if (document.getElementById('<%=txtExistingPassword.ClientID%>').value != "") {
                document.getElementById('<%=vmExistingPassword.ClientID%>').innerHTML = "";
                document.getElementById('<%=cpErrorMessage.ClientID%>').innerHTML = "";
            }


            if (document.getElementById('<%=txtNewPassword.ClientID%>').value != "") {
                document.getElementById('<%=vmNewPassword.ClientID%>').innerHTML = "";
                document.getElementById('<%=cpErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtConfirmNewPassword.ClientID%>').value != "") {
                document.getElementById('<%=vmConfirmNewPassword.ClientID%>').innerHTML = "";
                document.getElementById('<%=cpErrorMessage.ClientID%>').innerHTML = "";
            }

        }


    
    </script>
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

        function OnCheckBoxClick()
         {
             var check = document.getElementById('chkShow').checked;
             var ex = document.getElementById('<%=txtExistingPassword.ClientID%>');
             
             var nw = document.getElementById('<%=txtNewPassword.ClientID%>');
             var cn = document.getElementById('<%=txtConfirmNewPassword.ClientID%>');
            if (check == true)
            {
                ex.type = 'text';
                nw.type = 'text';
                cn.type = 'text';
            } 
            else
            {

                ex.type = 'password';
                nw.type = 'password';
                cn.type = 'password';
            }
        
        }

     
    </script>
</asp:Content>
