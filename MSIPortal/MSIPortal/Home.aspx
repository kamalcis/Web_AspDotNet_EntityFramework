<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="MSIPortal.Home" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release" EnablePageMethods="true" 
    EnablePartialRendering="true" >
        </asp:ScriptManager>
    <div class="well">
        <%--<form id="Form1" class="form-horizontal" runat="server">--%>
        <h4>
            Search Criteria</h4>
        <div class="control-group">
            <label class="control-label" for="inputFname1">
            </label>
            <div class="controls">
                <asp:RadioButton ID="rdoProduct" runat="server" GroupName="SaleService" Checked="True" />
                <asp:Label ID="Label1" runat="server" Text="Sales" class="radio inline"></asp:Label>
                &nbsp;
                <asp:RadioButton ID="rdoService" runat="server" GroupName="SaleService" />
                <asp:Label ID="Label2" runat="server" Text="Services" class="radio inline" GroupName="SaleService"></asp:Label>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="control-group">
                    <label class="control-label" for="inputPassword1">
                        Country <sup>*</sup></label>
                    <div class="controls">
                        <asp:DropDownList ID="ddlCountry" runat="server" AutoPostBack="True" onblur="ClearValidationMark()"
                            OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" >
                        </asp:DropDownList>
                        <asp:Label ID="vmCountry" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        City <sup>*</sup></label>
                    <div class="controls">
                        <asp:DropDownList ID="ddlCity" runat="server" onblur="ClearValidationMark()" 
                            Enabled="False">
                        </asp:DropDownList>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="control-group">
            <label class="control-label" for="inputPassword1">
                Category <sup>*</sup></label>
            <div class="controls">
                <asp:DropDownList ID="ddlCategory" runat="server" onchange="SelectUnSelectOption()" onblur="ClearValidationMark()">
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
        <div class="control-group">
            <asp:Panel ID="MessagePanel" runat="server">
                <label class="control-label">
                </label>
                <div class="controls">
                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
                </div>
            </asp:Panel>
        </div>
        <%--</form>--%>
    </div>
    <script type="text/javascript">


        function ValidateForm() {



            if (document.getElementById('<%=ddlCountry.ClientID%>').value == "000") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Country required";
                document.getElementById('<%=vmCountry.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCountry.ClientID%>').focus();
                return false;
            }



            if (document.getElementById('<%=ddlCategory.ClientID%>').value == "0") {
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "Category required";
                document.getElementById('<%=vmCategory.ClientID%>').innerHTML = "*";
                document.getElementById('<%=ddlCategory.ClientID%>').focus();
                return false;
            }



        }


        function ClearValidationMark() {

            if (document.getElementById('<%=ddlCountry.ClientID%>').value != "000") {
                document.getElementById('<%=vmCountry.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }


            if (document.getElementById('<%=ddlCategory.ClientID%>').value != "0") {
                document.getElementById('<%=vmCategory.ClientID%>').innerHTML = "";
                document.getElementById('<%=lblErrorMessage.ClientID%>').innerHTML = "";
            }


        }




    </script>


   

   
    <script src="ie-alert-master/theplugin/iealert.js" type="text/javascript"></script>
    <script src="ie-alert-master/theplugin/iealert.min.js" type="text/javascript"></script>
    <link href="ie-alert-master/theplugin/iealert/style.css" rel="stylesheet" type="text/css" />
    <link href="ie-alert-master/theplugin/iealert/style_dev.css" rel="stylesheet" type="text/css" />

    <script language="ecmascript">
        $("body").iealert({
            support: "ie8",
            title: "Your Internet Explorer is older. Please upgrade to latest...!"
        });
    </script>




   <script type = "text/javascript">
       function SelectUnSelectOption() {


           var categoryId = document.getElementById('<%=ddlCategory.ClientID %>').value;          
           var rdoProduct = document.getElementById('<%=rdoProduct.ClientID %>');
           var rdoService = document.getElementById('<%=rdoService.ClientID %>');
           
           PageMethods.ReturnData(categoryId, onSucess, onError);

           function onSucess(result) {
               if (result == "001") {

                   rdoProduct.checked = true;
               } 
               else if(result =="002") 
               {

                   rdoService.checked = true;
               }
              
           }

           function onError(result) 
           {
               alert('Something wrong.');
           }

       }


     
 </script>


</asp:Content>
