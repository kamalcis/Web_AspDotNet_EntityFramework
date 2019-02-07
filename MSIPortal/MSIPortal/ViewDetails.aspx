<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewDetails.aspx.cs" Inherits="MSIPortal.ViewDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 
		<div class="well">
		<%--<form id="Form1" class="form-horizontal" runat="server" visible="True">--%>
		<h4>
            <asp:Label ID="lblTitle" runat="server" ></asp:Label></h4>
		
		
		<div class="control-group">
						
                <div style="width:400px;height:400px;float:left">

                   <asp:Image ID="itemImage"  runat="server" Height="400px" Width="400px" CssClass="imageBox"/>
                </div>
            
                <div style="width:20px;height:400px; float:left">
                      
                </div>

                <div style="width:220px;height:auto; float:left">
                            
                            
                            <b>Provider Details:</b>
                            </br>
                            Name: 
                                <asp:Label ID="lblName" runat="server" Text="Label"></asp:Label>
                            </br>                            
                            Address:    <asp:Label ID="lblAddress" runat="server" Text="Label"></asp:Label>
                            </br>
                            </br>
                                                        
                            <b>Descriptions:</b>
                            </br>
                                  <asp:Label ID="lblDescription" runat="server" Text="Label"></asp:Label>

                            </br>
                            </br>
                            <b>Contact Information:</b>
                            </br>
                            Email: 
                                    <asp:Label ID="lblEmail" runat="server" Text="Label"></asp:Label>
                            </br>
                            Phone: 
                                  <asp:Label ID="lblPhone" runat="server" Text="Label"></asp:Label>

                </div>
        </div>

       
	
	<div class="control-group">
			<div class="controls">
				<input type="hidden" name="email_create" value="1">
				<input type="hidden" name="is_new_customer" value="1">
				<asp:Button runat="server" class="btn btn-large btn-success" type="submit" 
                    Text="Reply By Email" ID="btnEmail" onclick="btnEmail_Click" />

			</div>
		</div>	
        
        <asp:Panel ID="PanelPhoneNo" runat="server" Visible="False">
             	<div class="control-group">
		        <label class="control-label"></sup></label>
		        <div class="controls">
                    <asp:Label ID="Label2" runat="server" Text="09878787878"></asp:Label>
                </div>
		</div>
            
        </asp:Panel>

         <asp:Panel ID="PanelEmail" runat="server" Visible="False">
          <div class="control-group">
		        <label class="control-label">Subject</sup></label>
		        <div class="controls">
                    <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox>
                </div>
		 </div>

         <div class="control-group">
		        <label class="control-label">Message</sup></label>
		        <div class="controls">
                    <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Height="100px" 
                        Width="400px" ontextchanged="txtBody_TextChanged"></asp:TextBox>
                </div>
		 </div>

         <div class="control-group">
		        <label class="control-label"></label>
		        <div class="controls">
                    <asp:Button runat="server" class="btn btn-large btn-success" type="submit" 
                    Text="Send" ID="btnSend" onclick="btnSend_Click" />
                </div>
		 </div>

                     
        </asp:Panel>
         <div class="control-group">
		        <label class="control-label"></label>
		        <div class="controls">
                    <asp:Label ID="lblMessage" runat="server" ></asp:Label>
                </div>
		 </div>	
        	
	<%--</form>--%>
</div>

 <style type="text/css">
               
                .imageBox
                {
                    width: 400px;
                    height:400px;
                    border:1px solid gray;
                    border-radius: 7px;
                    box-shadow: 4px 4px 3px #888888;
                   
                }


              
            </style>

</asp:Content>
