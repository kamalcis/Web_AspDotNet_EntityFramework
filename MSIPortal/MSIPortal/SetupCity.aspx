<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SetupCity.aspx.cs" Inherits="MSIPortal.SetupCity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <div class="well">
       <%-- <form id="Form1" class="form-horizontal" runat="server">--%>
        <h4>
            City Setup</h4>
       
        
         <div class="control-group">
            <label class="control-label" for="inputPassword1">
                Country Name</label>
            <div class="controls">
                <asp:DropDownList ID="ddlCountry" runat="server">
                    
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlCountry" runat="server" ForeColor="Red" InitialValue="0" ErrorMessage="Country name required"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="inputPassword1">
                City Name</label>
            <div class="controls">
                <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtCity" runat="server" ForeColor="Red" ErrorMessage="City name required"></asp:RequiredFieldValidator>
            </div>
        </div>
        
        <div class="control-group">
            <div class="controls">
                <input type="hidden" name="email_create" value="1">
                <input type="hidden" name="is_new_customer" value="1">
                <asp:Button runat="server" class="btn btn-primary" type="submit" Text="Save" OnClientClick="ValidateForm()"
                    ID="btnSave" onclick="btnSave_Click"  />
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

      <%--  </form>--%>
    </div>


    <script type="text/javascript">


        function ValidateForm() {

            document.getElementById('<%=lblSuccessMessage.ClientID%>').innerHTML = "";

        }

        </script>

</asp:Content>
