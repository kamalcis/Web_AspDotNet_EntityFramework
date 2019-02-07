<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Post.aspx.cs" Inherits="MSIPortal.Post"%>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>

</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
     <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release" EnablePageMethods="true" 
    EnablePartialRendering="true" >
        </asp:ScriptManager>

    <div id="divGVE" class="well" >
        <%--        <form id="Form1" class="form-horizontal" runat="server">--%>
       
   
       
   <%--     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>--%>
               
                     <div class="control-group">
                    <label class="control-label">
                    </label>
                    <asp:Panel ID="MessagePanel" Visible="true" runat="server">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lblSuccessMessage" runat="server"></asp:Label>
                         <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
                    </asp:Panel>
                   
                </div>
                    <h5> Product / Service Details</h5>
               
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                   <ContentTemplate>

                  
               

              

                      <div class="control-group">
                    <label class="control-label">
                        Country* <sup></sup>
                    </label>
                    <div class="controls">
                        <asp:DropDownList ID="ddlCommonCountry" runat="server" AutoPostBack="True" onblur="ClearValidationMark();" OnSelectedIndexChanged="ddlCommonCountry_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label ID="lblCountryValidation" runat="server" ForeColor="Red"></asp:Label>
                        
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        City* <sup></sup>
                    </label>
                    <div class="controls">
                        <asp:DropDownList ID="ddlCommonCity" runat="server" onblur="ClearValidationMark() ;">
                        </asp:DropDownList>    
                        <asp:Label ID="lblCityValidation" runat="server" ForeColor="Red"></asp:Label>                    
                    </div>
                </div>
                   
                   </ContentTemplate>

                </asp:UpdatePanel>

                
                <div class="control-group">
                    <label class="control-label">
                        Cateogry <sup>*</sup></label>
                    <div class="controls">
                        <asp:DropDownList ID="ddlCategory" runat="server" onblur="ClearValidationMark() ;">
                            <%--<asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">--%>
                        </asp:DropDownList>
                        <asp:Label ID="lblCategoryValidation" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>
                <%--<asp:Panel ID="CarPanel" runat="server" Visible="False">
            <div class="control-group">
                <label class="control-label" for="inputFname1">
                </label>
                <div class="controls">
                    <asp:RadioButton ID="RadioButton1" runat="server" />
                    <asp:Label ID="Label1" runat="server" Text="Sale" class="radio inline"></asp:Label>
                    &nbsp;
                    <asp:RadioButton ID="RadioButton2" runat="server" />
                    <asp:Label ID="Label2" runat="server" Text="Wanted" class="radio inline"></asp:Label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputLnam">
                    Brand, Model & Year <sup>*</sup></label>
                <div class="controls">
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="100px">
                    </asp:DropDownList>
                    &nbsp;
                    <asp:TextBox ID="TextBox1" runat="server" Width="100px" placeholder="Model"></asp:TextBox>
                    &nbsp;
                    <asp:TextBox ID="TextBox2" runat="server" Width="100px" placeholder="Year"></asp:TextBox>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="input_email">
                    Registration Year <sup>*</sup></label>
                <div class="controls">
                    <asp:TextBox ID="txtRegistrationYear" placeholder="Registration Year" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputPassword1">
                    Body Type <sup>*</sup></label>
                <div class="controls">
                    <asp:DropDownList ID="ddlBodyType" runat="server">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Condition <sup>*</sup></label>
                <div class="controls">
                    <asp:DropDownList ID="ddlCondition" runat="server">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Transmission <sup>*</sup></label>
                <div class="controls">
                    <asp:DropDownList ID="ddlTransmission" runat="server">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Fuel Type <sup>*</sup></label>
                <div class="controls">
                    <asp:DropDownList ID="ddlFuelType" runat="server">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Engine Capacity <sup>*</sup></label>
                <div class="controls">
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    &nbsp;
                    <asp:Label ID="Label3" runat="server" Text="Label"> cc </asp:Label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Milage <sup>*</sup></label>
                <div class="controls">
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                    &nbsp;
                    <asp:Label ID="Label4" runat="server" Text="Label">km</asp:Label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Description <sup>*</sup></label>
                <div class="controls">
                    <asp:TextBox ID="TextBox5" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Price <sup>*</sup></label>
                <div class="controls">
                    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                    &nbsp;
                    <asp:DropDownList ID="DropDownList2" runat="server" Width="100px">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">
                    Upload Image <sup>*</sup></label>
                <div class="controls">
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </div>
            </div>
        </asp:Panel>--%>
                <asp:Panel ID="CommonPanel" runat="server" Visible="true">
                    <div class="control-group">
                        <label class="control-label" for="inputFname1">
                        </label>
                        <div class="controls">
                            <asp:RadioButton ID="rdoCommonSales" runat="server" GroupName="CommonSaleService" />
                            <asp:Label ID="Label5" runat="server" Text="Sales" class="radio inline"></asp:Label>
                            &nbsp;
                            <asp:RadioButton ID="rdoCommonService" GroupName="CommonSaleService" runat="server" />
                            <asp:Label ID="Label6" runat="server" Text="Services" class="radio inline"></asp:Label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">
                            Provider First Name <sup>*</sup></label>
                        <div class="controls">
                            <asp:TextBox ID="txtCommonProviderFirstName" placeholder="Provider First Name" onblur="ClearValidationMark()" runat="server"></asp:TextBox>
                            <asp:Label ID="lblProviderFirstNameValidation" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">
                            Provider Last Name <sup>*</sup></label>
                        <div class="controls">
                            <asp:TextBox ID="txtCommonProviderLastName" placeholder="Provider Last Name" runat="server" onblur="ClearValidationMark()"></asp:TextBox>
                            <asp:Label ID="lblProviderLastNameValidation" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">
                            Provider Address <sup></sup>
                        </label>
                        <div class="controls">
                            <asp:TextBox ID="txtCommonProviderAddress" placeholder="Provider Address" runat="server"
                                MaxLength="45"></asp:TextBox>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">
                            Provider Email <sup>*</sup></label>
                        <div class="controls">
                            <asp:TextBox ID="txtCommonProviderEmil" placeholder="Provider Email" runat="server" onblur="ClearValidationMark();"
                                MaxLength="45"></asp:TextBox>
                            <asp:Label ID="lblValidateEmail" runat="server" ForeColor="Red"></asp:Label>
                          
                            
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">
                            Provider Phone <sup>*</sup></label>
                        <div class="controls">
                            <asp:TextBox ID="txtCommonProviderPhone" placeholder="Provider Phone" 
                                runat="server" onblur="ClearValidationMark()"
                                MaxLength="20"></asp:TextBox>
                                 <asp:Label ID="lblProviderPhoneValidation" runat="server" ForeColor="Red"></asp:Label>
                            
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">
                            Posting Title <sup>*</sup></label>
                        <div class="controls">
                            <asp:TextBox ID="txtCommonPostingTitle" placeholder="Title of Your Post" runat="server" onblur="ClearValidationMark()"
                                MaxLength="45"></asp:TextBox>
                                 <asp:Label ID="txtCommonPostingTitleValidation" runat="server" ForeColor="Red"></asp:Label>
                            
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">
                            Posting Description <sup>*</sup></label>
                        <div class="controls">
                            <asp:TextBox ID="txtCommonPostingDescription" placeholder="Description" 
                                TextMode="MultiLine" onblur="ClearValidationMark()"
                                runat="server" MaxLength="250" Height="70px" Width="299px"></asp:TextBox>

                          <asp:Label ID="txtCommonPostingDescriptionValidation" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                </asp:Panel>


                 
                <asp:Panel ID="PanelAboutYou" runat="server" Visible="false">
                
                <h5>
                    About You</h5>
                     
                 
                                  <div class="control-group">
                    <label class="control-label" for="inputFname">
                        Email <sup>*</sup></label>
                    <div class="controls">
                        <asp:TextBox ID="txtUserEmail" placeholder="Email" runat="server" onblur="ClearValidationMark()"></asp:TextBox>
                        <asp:Label ID="lblUserEmailValidation" runat="server" ForeColor="Red"></asp:Label>
                        
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputFname">
                        Password <sup>*</sup></label>
                    <div class="controls">
                        <asp:TextBox ID="txtPassword"  placeholder="Password"  runat="server" 
                            onblur="FillUserData()" MaxLength="45"></asp:TextBox>

                            <asp:Label ID="lblPasswordValidation" runat="server" ForeColor="Red"></asp:Label>
                        
                    </div>
                </div>

                  <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>

                <div class="control-group">
                    <label class="control-label" for="inputLname">
                        Confirm Password <sup>*</sup></label>
                    <div class="controls">
                        <asp:TextBox ID="txtConfirmPassword" placeholder="Confirm Password" runat="server" onblur="ClearValidationMark()"
                            MaxLength="45"></asp:TextBox>

                            <asp:Label ID="lblConfirmPasswordValidation" runat="server" ForeColor="Red"></asp:Label>
                       
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="company">
                        First Name<sup>*</sup></label>
                    <div class="controls">
                        <asp:TextBox ID="txtUserFirstlName" placeholder="Full Name" runat="server" MaxLength="45" onblur="ClearValidationMark()"></asp:TextBox>
                       <asp:Label ID="lblFirstNameValidation" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="company">
                        Last Name<sup>*</sup></label>
                    <div class="controls">
                        <asp:TextBox ID="txtUserLastName" placeholder="Full Name" runat="server" MaxLength="45" onblur="ClearValidationMark()"></asp:TextBox>
                        <asp:Label ID="lblLastNameValidation" runat="server" ForeColor="Red"></asp:Label>
                       
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="state">
                        Location<sup>*</sup></label>
                    <div class="controls">
                        <asp:DropDownList ID="ddlUserLocation" runat="server" onblur="ClearValidationMark()">
                        </asp:DropDownList>
                       <asp:Label ID="lblUserLocationValidation" runat="server" ForeColor="Red" ></asp:Label>
                    </div>
                </div>
                        
                </ContentTemplate>
                    </asp:UpdatePanel>

                </asp:Panel>
                

                <h5>
                    Image</h5>
                <div class="control-group">
                    <label class="control-label">
                        Upload Image <sup></sup>
                    </label>
                    <div class="controls">
                        <asp:FileUpload ID="commonImageUpload" runat="server" />
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <input type="hidden" name="email_create" value="1">
                        <input type="hidden" name="is_new_customer" value="1">
                        <asp:Button class="btn btn-large btn-success" ID="btnPost" OnClientClick="return ValidateForm();" runat="server" Text="Post"
                            OnClick="btnPost_Click" />
                    </div>
                </div>
               
          <%-- </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnPost" />
              
            </Triggers>
        </asp:UpdatePanel>--%>
        <%--</form>--%>
    </div>
    <script type="text/javascript">

        function IsNumeric(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            return (charCode <= 31 || charCode == 46 || (charCode >= 48 && charCode <= 57));
        }

        function ValidateForm() 
        {

            document.getElementById('<%=lblSuccessMessage.ClientID%>').innerHTML = ""; // Make sure there is no success message
            
            if (document.getElementById('<%=ddlCommonCountry.ClientID%>').value == "0") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Country required";
                document.getElementById('<%=lblCountryValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCommonCountry.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlCommonCity.ClientID%>').value == "0") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "City required";
                document.getElementById('<%=lblCityValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCommonCity.ClientID%>').focus();
                return false;
            }



            if (document.getElementById('<%=ddlCategory.ClientID%>').value == "0") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "City required";
                document.getElementById('<%=lblCategoryValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCategory.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtCommonProviderFirstName.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Provider first name required";
                document.getElementById('<%=lblProviderFirstNameValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtCommonProviderFirstName.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtCommonProviderLastName.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Provider last name required";
                document.getElementById('<%=lblProviderLastNameValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtCommonProviderLastName.ClientID%>').focus();
                return false;
            }
            
            
            
            if (document.getElementById('<%=txtCommonProviderEmil.ClientID%>').value == "") 
            {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Provider email required";
                document.getElementById('<%=lblValidateEmail.ClientID%>').innerHTML = "*";                
                document.getElementById('<%=txtCommonProviderEmil.ClientID%>').focus();                
                return false;
            }

            
            if (document.getElementById('<%=txtCommonProviderEmil.ClientID%>') != "")             
            {                
                var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
                var emailField = document.getElementById('<%=txtCommonProviderEmil.ClientID%>');
                if (reg.test(emailField.value) == false) 
                {

                    document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Invalid email address";
                    document.getElementById('<%=lblValidateEmail.ClientID%>').innerHTML = "*";                
                    document.getElementById('<%=txtCommonProviderEmil.ClientID%>').focus();           
                    return false;
                }

            }


            if (document.getElementById('<%=txtCommonProviderPhone.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Password required";
                document.getElementById('<%=lblProviderPhoneValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtCommonProviderPhone.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtCommonPostingTitle.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Posting title required";
                document.getElementById('<%=txtCommonPostingTitleValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtCommonPostingTitle.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtCommonPostingDescription.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Posting description required";
                document.getElementById('<%=txtCommonPostingDescriptionValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtCommonPostingDescription.ClientID%>').focus();
                return false;
            }
            //============About You section

            if (document.getElementById('<%=txtUserEmail.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "User email required";
                document.getElementById('<%=lblUserEmailValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtUserEmail.ClientID%>').focus();
                return false;
            }


            if (document.getElementById('<%=txtUserEmail.ClientID%>') != "") {
                var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
                var emailField = document.getElementById('<%=txtUserEmail.ClientID%>');
                if (reg.test(emailField.value) == false) {

                    document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Invalid user email address";
                    document.getElementById('<%=lblUserEmailValidation.ClientID%>').innerHTML = "*";
                    document.getElementById('<%=txtUserEmail.ClientID%>').focus();
                    return false;
                }

            }

            if (document.getElementById('<%=txtPassword.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Password required";
                document.getElementById('<%=lblPasswordValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtPassword.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtPassword.ClientID%>').value != "")
            {

                if (document.getElementById('<%=txtPassword.ClientID%>').value.length < 4) {

                    document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Password lenth should be atleast 4 digit";
                    document.getElementById('<%=lblPasswordValidation.ClientID%>').innerHTML = "*";
                    document.getElementById('<%=txtPassword.ClientID%>').focus();
                    return false;
                
                } 
                
            }

            if (document.getElementById('<%=txtConfirmPassword.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "User email required";
                document.getElementById('<%=lblConfirmPasswordValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtConfirmPassword.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtConfirmPassword.ClientID%>').value != "") 
            {

                if (document.getElementById('<%=txtPassword.ClientID%>').value != document.getElementById('<%=txtConfirmPassword.ClientID%>').value) {

                    document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Password miss match";
                    document.getElementById('<%=lblConfirmPasswordValidation.ClientID%>').innerHTML = "*";
                    document.getElementById('<%=txtConfirmPassword.ClientID%>').focus();
                    return false;                
                }
                
            }

            if (document.getElementById('<%=txtUserFirstlName.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "First name required";
                document.getElementById('<%=lblFirstNameValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtUserFirstlName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtUserLastName.ClientID%>').value == "") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Last name required";
                document.getElementById('<%=lblLastNameValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=txtUserLastName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlUserLocation.ClientID%>').value == "0") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "User location required";
                document.getElementById('<%=lblUserLocationValidation.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlUserLocation.ClientID%>').focus();
                return false;
            }


           

        }


        function ClearValidationMark() 
        {

            document.getElementById('<%=lblSuccessMessage.ClientID%>').innerHTML = "";

            if (document.getElementById('<%=txtCommonProviderEmil.ClientID%>').value != "")
            {
                document.getElementById('<%=lblValidateEmail.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlCommonCountry.ClientID%>').value != "0") {
                document.getElementById('<%=lblCountryValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlCommonCity.ClientID%>').value != "0") {
                document.getElementById('<%=lblCityValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlCategory.ClientID%>').value != "0") {
                document.getElementById('<%=lblCategoryValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtCommonProviderFirstName.ClientID%>').value != "") {
                document.getElementById('<%=lblProviderFirstNameValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtCommonProviderLastName.ClientID%>').value != "") {
                document.getElementById('<%=lblProviderLastNameValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtCommonProviderPhone.ClientID%>').value != "") {
                document.getElementById('<%=lblProviderPhoneValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtCommonPostingTitle.ClientID%>').value != "") {
                document.getElementById('<%=txtCommonPostingTitleValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtCommonPostingDescription.ClientID%>').value != "") {
                document.getElementById('<%=txtCommonPostingDescriptionValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtUserEmail.ClientID%>').value != "") {
                document.getElementById('<%=lblUserEmailValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            //===About You Section

            if (document.getElementById('<%=txtPassword.ClientID%>').value != "") {
                document.getElementById('<%=lblPasswordValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtConfirmPassword.ClientID%>').value != "") {
                document.getElementById('<%=lblConfirmPasswordValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=txtUserFirstlName.ClientID%>').value != "") {
                document.getElementById('<%=lblFirstNameValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }


            if (document.getElementById('<%=txtUserLastName.ClientID%>').value != "") {
                document.getElementById('<%=lblLastNameValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlUserLocation.ClientID%>').value != "0") {
                document.getElementById('<%=lblUserLocationValidation.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

           

        }


      

    </script>  

    
  

   <script type = "text/javascript">
       function FillUserData() {

           var email = document.getElementById('<%=txtUserEmail.ClientID %>').value;
           var password = document.getElementById('<%=txtPassword.ClientID %>').value;

           var confirmPassword = document.getElementById('<%=txtConfirmPassword.ClientID %>');
           var firstName = document.getElementById('<%=txtUserFirstlName.ClientID %>');
           var lastName = document.getElementById('<%=txtUserLastName.ClientID %>');
           var ddlLocation = document.getElementById('<%=ddlUserLocation.ClientID %>');
           var imageUp = document.getElementById('<%=commonImageUpload.ClientID %>');

           


           PageMethods.ReturnUserData(email, password, onSucess, onError);
        
           function onSucess(result) {
           
               if (result != null) {
                   // Set Value
                   var confirmPass = result[0];
                   var fname = result[1];
                   var lname = result[2];
                   var loc = result[3];                   
                   confirmPassword.value = confirmPass;
                   firstName.value = fname;
                   lastName.value = lname;
                   setSelectedIndex(ddlLocation, loc)

                   // Disable Field
                   confirmPassword.disabled= true;
                   firstName.disabled = true;
                   lastName.disabled = true;
                   ddlLocation.disabled = true;
                   imageUp.focus();

                  
               }
               else {
                   confirmPassword.disabled = false;
                   firstName.disabled = false;
                   lastName.disabled = false;
                   ddlLocation.disabled = false;

                   confirmPassword.value="";
                   firstName.value = "";
                   lastName.value = "";
                   ddlLocation.selectedIndex = 0;
                   confirmPassword.focus();
                  
               }
           }

           function onError(result) {
               alert('Something wrong.');
           }

       }


       function setSelectedIndex(ddlloc, val) {

           for (var i = 0; i < ddlloc.options.length; i++)
           {

            
               if (Number(ddlloc.options[i].value) == val) 
               {
                   ddlloc.selectedIndex = i;
                   return;
               }      
               
           }
       }
//       function ShowCurrentTime() {
//           $.ajax({
//               type: "POST",
//               url: "Post.aspx/GetCurrentTime",
//               data: '{name: "' + $("#<%=txtPassword.ClientID%>")[0].value + '" }',
//               contentType: "application/json; charset=utf-8",
//               dataType: "json",
//               success: OnSuccess,
//               failure: function (response) {
//                   alert(response.d);
//               }
//           });
//       }
//       function OnSuccess(response) {
//           alert(response.d);
//       }
 </script>
       
</asp:Content>
