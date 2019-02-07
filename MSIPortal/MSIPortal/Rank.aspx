<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Rank.aspx.cs" Inherits="MSIPortal.Rank" %>

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
                    Posts by Country-City-Category
                </HeaderTemplate>
                <ContentTemplate>
                    <div class="well">
                         
                        <div class="control-group">
                            <label class="control-label" for="inputFname1">
                            </label>
                            <div class="controls">
                                <asp:RadioButton ID="rdoProduct" runat="server" GroupName="SaleService" Checked="True" />
                                <asp:Label ID="lblRadio" runat="server" Text="Sales" class="radio inline"></asp:Label>
                                &nbsp;
                                <asp:RadioButton ID="rdoService" runat="server" GroupName="SaleService" />
                                <asp:Label ID="Label2" runat="server" Text="Services" class="radio inline" GroupName="SaleService"></asp:Label>
                            </div>
                        </div>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="control-group">
                                    <label class="control-label" for="inputPassword1">
                                        Country <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:DropDownList ID="ddlCountry" runat="server" AutoPostBack="True" onblur="ClearValidationMark()"
                                            OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:Label ID="vmCountry" runat="server" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        City <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:DropDownList ID="ddlCity" runat="server" onblur="ClearValidationMark()">
                                        </asp:DropDownList>
                                     <asp:Label ID="vmCity" runat="server" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <div class="control-group">
                            <label class="control-label" for="inputPassword1">
                                Category <sup>*</sup></label>
                            <div class="controls">
                                <asp:DropDownList ID="ddlSearchCategory" runat="server" onblur="ClearValidationMark()">
                                </asp:DropDownList>
                                <asp:Label ID="vmCategory" runat="server" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <input type="hidden" name="email_create" value="1">
                                <input type="hidden" name="is_new_customer" value="1">
                                <asp:Button runat="server" class="btn btn-primary" type="submit" Text="Go" ID="btnSearch"
                                    OnClientClick="return ValidateForm()" OnClick="btnSearch_Click" />

                            </div>
                        </div>
                        <asp:Panel ID="SearchMessagePanel" runat="server" Visible="False">
                            <div class="control-group">
                            <label class="control-label" for="inputFname1">
                            </label>
                            <div class="controls">
                              
                                <asp:Label ID="lblSearchMessage" runat="server" ForeColor="Red"></asp:Label>
                              
                              
                            </div>
                        </div>
                        </asp:Panel>
                       

                        <asp:GridView ID="GridView1" runat="server" CssClass="gridview" GridLines="None"
                            AutoGenerateColumns="False" AllowPaging="True" 
                            OnPageIndexChanging="GridView1_PageIndexChanging" 
                            OnRowCommand="GridView1_RowCommand">
                            <AlternatingRowStyle CssClass="even" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hiddenPostId" runat="Server" Value='<%#Eval("PostID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Image">
                                <HeaderStyle HorizontalAlign="Left" /> 
                                    <ItemTemplate>
                                        <%--<asp:Image ID="Image1" runat="server"  ImageUrl='<%# Eval("ImageUrl") +"?id="+ Eval("PostID") %>'  ControlStyle-CssClass="image"/>--%>
                                        <asp:Image ID="Image2" runat="server" ImageUrl='<%# GetImageUrl(Convert.ToString(Eval("ImageUrl")))+"?id="+ Eval("PostID") %>'
                                            ControlStyle-CssClass="image" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PostTitle" HeaderText="Title" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EditDate" DataFormatString="{0:MMMM d, yyyy}" ReadOnly="True" HeaderText="Date">
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                  <asp:TemplateField HeaderText="Rank">
                                    <HeaderStyle HorizontalAlign="Left" /> 
                                    <ItemTemplate>
                                         
                                        <asp:Label ID="lbl" runat="server" Text='<%# Convert.ToInt32(Eval("Rank"))==999? "Not Ranked":Convert.ToString(Eval("Rank"))  %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="Edit">
                                <HeaderStyle HorizontalAlign="Left" /> 
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" CommandName="Modify" CommandArgument='<%# Eval("PostID") %>'
                                            runat="server" Text="Edit" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:TabPanel>
            <asp:TabPanel ID="TabPanelEditRank" runat="server" HeaderText="TabPanel4">
                <HeaderTemplate>
                    Edit Rank
                </HeaderTemplate>
                <ContentTemplate>
                    <div class="well">
                        <h5>
                            Product / Service Details</h5>
                        <div class="control-group">
                            <label class="control-label">
                                Rank <sup></sup>
                            </label>
                            <div class="controls">
                                <asp:HiddenField ID="hiddenPostId" runat="server" />
                                <asp:DropDownList ID="ddlRank" runat="server">
                                    <asp:ListItem Value="999">Select One</asp:ListItem>
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                    <asp:ListItem Value="4">4</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="6">6</asp:ListItem>
                                    <asp:ListItem Value="7">7</asp:ListItem>
                                    <asp:ListItem Value="8">8</asp:ListItem>
                                    <asp:ListItem Value="9">9</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    Country* <sup></sup>
                                </label>
                                <div class="controls">
                                    <asp:DropDownList ID="ddlCommonCountry" runat="server" AutoPostBack="True" onblur="ClearValidationMark();"
                                        OnSelectedIndexChanged="ddlCommonCountry_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblCountryValidation" runat="server" ForeColor="Red"></asp:Label></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    City* <sup></sup>
                                </label>
                                <div class="controls">
                                    <asp:DropDownList ID="ddlCommonCity" runat="server" onblur="ClearValidationMark() ;">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblCityValidation" runat="server" ForeColor="Red"></asp:Label></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    Cateogry <sup>*</sup></label>
                                <div class="controls">
                                    <asp:DropDownList ID="ddlCommonCategory" runat="server" onblur="ClearValidationMark() ;">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblCategoryValidation" runat="server" ForeColor="Red"></asp:Label></div>
                            </div>
                            <asp:Panel ID="CommonPanel" runat="server">
                                <div class="control-group">
                                    <label class="control-label" for="inputFname1">
                                    </label>
                                    <div class="controls">
                                        <asp:RadioButton ID="rdoCommonSales" runat="server" GroupName="CommonSaleService" /><asp:Label
                                            ID="Label5" runat="server" Text="Sales" class="radio inline"></asp:Label>&#160;&nbsp;<asp:RadioButton
                                                ID="rdoCommonService" GroupName="CommonSaleService" runat="server" /><asp:Label ID="Label6"
                                                    runat="server" Text="Services" class="radio inline"></asp:Label></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input_email">
                                        Provider First Name <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtCommonProviderFirstName" placeholder="Provider First Name" onblur="ClearValidationMark()"
                                            runat="server"></asp:TextBox><asp:Label ID="lblProviderFirstNameValidation" runat="server"
                                                ForeColor="Red"></asp:Label></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input_email">
                                        Provider Last Name <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtCommonProviderLastName" placeholder="Provider Last Name" runat="server"
                                            onblur="ClearValidationMark()"></asp:TextBox><asp:Label ID="lblProviderLastNameValidation"
                                                runat="server" ForeColor="Red"></asp:Label></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input_email">
                                        Provider Address <sup></sup>
                                    </label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtCommonProviderAddress" placeholder="Provider Address" runat="server"
                                            MaxLength="45"></asp:TextBox></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input_email">
                                        Provider Email <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtCommonProviderEmil" placeholder="Provider Email" runat="server"
                                            onblur="ClearValidationMark();" MaxLength="45"></asp:TextBox><asp:Label ID="lblValidateEmail"
                                                runat="server" ForeColor="Red"></asp:Label></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input_email">
                                        Provider Phone <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtCommonProviderPhone" placeholder="Provider Phone" runat="server"
                                            onblur="ClearValidationMark()" MaxLength="45"></asp:TextBox><asp:Label ID="lblProviderPhoneValidation"
                                                runat="server" ForeColor="Red"></asp:Label></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input_email">
                                        Posting Title <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtCommonPostingTitle" placeholder="Title of Your Post" runat="server"
                                            onblur="ClearValidationMark()" MaxLength="45"></asp:TextBox><asp:Label ID="txtCommonPostingTitleValidation"
                                                runat="server" ForeColor="Red"></asp:Label></div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="input_email">
                                        Posting Description <sup>*</sup></label>
                                    <div class="controls">
                                        <asp:TextBox ID="txtCommonPostingDescription" placeholder="Description" TextMode="MultiLine"
                                            onblur="ClearValidationMark()" runat="server" MaxLength="250"></asp:TextBox><asp:Label
                                                ID="txtCommonPostingDescriptionValidation" runat="server" ForeColor="Red"></asp:Label></div>
                                </div>
                            </asp:Panel>
                            <h5>
                                Image</h5>
                            <div class="control-group">
                                <label class="control-label">
                                    Upload Image <sup></sup>
                                </label>
                                <div class="controls">
                                    <asp:FileUpload ID="commonImageUpload" runat="server" /></div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    <sup></sup>
                                </label>
                                <div class="controls">
                                    <asp:Image ID="PSImage" runat="server" Style="border: 1px solid black; width: 200px;" /></div>
                            </div>
                            <div class="control-group">
                                <div class="controls">
                                    <input type="hidden" name="email_create" value="1">
                                    <input type="hidden" name="is_new_customer" value="1">
                                    <asp:Button class="btn btn-large btn-success" ID="btnUpdate" OnClientClick="return ValidateForm();"
                                        runat="server" Text="Update Rank" OnClick="btnUpdate_Click" />
                                </div>
                            </div>
                            <div style="width: 100%; height: 10px;">
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                </label>
                                <asp:Panel ID="MessagePanel" runat="server">
                                    &#160;&#160;&#160;&#160;&#160;
                                    <asp:Label ID="lblSuccessMessage" runat="server"></asp:Label><asp:Label ID="lblErrorMessage"
                                        runat="server" ForeColor="Red"></asp:Label></asp:Panel>
                            </div>
                        </div>
                        <script type="text/javascript">

                            function IsNumeric(evt) {
                                var charCode = (evt.which) ? evt.which : event.keyCode;
                                return (charCode <= 31 || charCode == 46 || (charCode >= 48 && charCode <= 57));
                            }

                            function ValidateForm() {

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



                                if (document.getElementById('<%=ddlCommonCategory.ClientID%>').value == "0") {
                                    document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "City required";
                                    document.getElementById('<%=lblCategoryValidation.ClientID%>').innerHTML = "*";
                                    document.getElementById('<%=ddlCommonCategory.ClientID%>').focus();
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



                                if (document.getElementById('<%=txtCommonProviderEmil.ClientID%>').value == "") {
                                    document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Provider email required";
                                    document.getElementById('<%=lblValidateEmail.ClientID%>').innerHTML = "*";
                                    document.getElementById('<%=txtCommonProviderEmil.ClientID%>').focus();
                                    return false;
                                }


                                if (document.getElementById('<%=txtCommonProviderEmil.ClientID%>') != "") {
                                    var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
                                    var emailField = document.getElementById('<%=txtCommonProviderEmil.ClientID%>');
                                    if (reg.test(emailField.value) == false) {

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






                            }


                            function ClearValidationMark() {

                                if (document.getElementById('<%=txtCommonProviderEmil.ClientID%>').value != "") {
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

                                if (document.getElementById('<%=ddlCommonCategory.ClientID%>').value != "0") {
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




                            }


                        </script>
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
    <script type="text/javascript">


        function ValidateForm() {



            if (document.getElementById('<%=ddlCountry.ClientID%>').value == "0") {
                //document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Country required";
                document.getElementById('<%=vmCountry.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCountry.ClientID%>').focus();
                return false;
            }


            if (document.getElementById('<%=ddlCity.ClientID%>').value == "0") {
               // document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "City required";
                document.getElementById('<%=vmCity.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCountry.ClientID%>').focus();
                return false;
            }



            if (document.getElementById('<%=ddlSearchCategory.ClientID%>').value == "0") {
                //document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Category required";
                document.getElementById('<%=vmCategory.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlSearchCategory.ClientID%>').focus();
                return false;
            }



        }


        function ClearValidationMark() {

            if (document.getElementById('<%=ddlCountry.ClientID%>').value != "0") {
                document.getElementById('<%=vmCountry.ClientID%>').innerHTML = "";
                //document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlCity.ClientID%>').value != "0") {
                document.getElementById('<%=vmCity.ClientID%>').innerHTML = "";
                //document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }

            if (document.getElementById('<%=ddlSearchCategory.ClientID%>').value != "0") {
                document.getElementById('<%=vmCategory.ClientID%>').innerHTML = "";
                //document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }


        }


    </script>
</asp:Content>
