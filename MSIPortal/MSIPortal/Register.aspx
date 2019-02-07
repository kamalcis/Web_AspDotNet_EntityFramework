<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MSIPortal.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
 <div style="height:100px"> </div>
<div style="width:50%;  margin:0 auto; border:1px solid gray;">
      <table border="0" width="100%" cellpadding="5" cellspacing="0">
          <tr>
             <td><b>Register User</b></td>
             <td>
                 <b></b>
              </td>
          </tr>

          <tr>
             <td>Email Addrss</td>
             <td>
                 <asp:TextBox ID="TextBox3" runat="server" Width="172px"></asp:TextBox>
              </td>
          </tr>

          <tr>
             <td>Password</td>
             <td>
                 <asp:TextBox ID="TextBox2" runat="server" Width="173px"></asp:TextBox>
              </td>
          </tr>

          <tr>
             <td>Full Name</td>
             <td>
                 <asp:TextBox ID="TextBox1" runat="server" Width="173px"></asp:TextBox>
              </td>
          </tr>

          <tr>
             <td>Company / Organisation</td>
             <td>
                 <asp:DropDownList ID="ddlCountry0" runat="server" Height="16px" Width="175px">
                 </asp:DropDownList>
              </td>
          </tr>

          <tr>
             <td>Country</td>
             <td>
                 <asp:DropDownList ID="ddlCountry" runat="server" Height="16px" Width="175px">
                 </asp:DropDownList>
              </td>
          </tr>

            <tr>
             <td>City</td>
             <td>
                 <asp:DropDownList ID="ddlCity" runat="server" Height="16px" Width="175px">
                 </asp:DropDownList>
              </td>
          </tr>

           <tr>
             <td>Contact Mobile No</td>
             <td>
                 <asp:TextBox ID="TextBox4" runat="server" Width="173px"></asp:TextBox>
              </td>
          </tr>

         

          <tr>
             <td>&nbsp;</td>
             <td>&nbsp;</td>
          </tr>

          <tr>
             <td>&nbsp;</td>
             <td>
                 <asp:Button ID="Button1" runat="server" Text="Register" />
              </td>
          </tr>
      </table>              
</div>
<div style="height:100px"> </div>
</asp:Content>
