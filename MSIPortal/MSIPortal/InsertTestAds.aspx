<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsertTestAds.aspx.cs" Inherits="MSIPortal.InsertTestAds" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


		<div class="well">
		     <form id="Form1" class="form-horizontal" runat="server">
		<h4>Advertisement Details</h4>
		
	
		<h4>About You</h4>
		<div class="control-group">
			<label class="control-label" for="inputFname">Titel <sup>*</sup></label>
			<div class="controls">
                <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
			</div>
		</div>

        <div class="control-group">
			<label class="control-label" for="inputFname">Description <sup>*</sup></label>
			<div class="controls">
			 <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="inputLname">Upload Image <sup>*</sup></label>
			<div class="controls">
			    <asp:FileUpload ID="FileUpload1" runat="server" />
&nbsp;</div>
		</div>
		
		 <div class="control-group">
			<label class="control-label" for="inputFname">Price <sup>*</sup></label>
			<div class="controls">
			 <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
			</div>
		</div>
		
			<div class="control-group">
			<label class="control-label" for="state">Category<sup>*</sup></label>
			<div class="controls">
			  <select id="state" >
				<option value="">-</option>
				<option value="1">Alabama</option></select>
			</div>
		</div>		
		
		
	<p><sup>*</sup>Required field	</p>
	
	<div class="control-group">
			<div class="controls">
				<input type="hidden" name="email_create" value="1">
				<input type="hidden" name="is_new_customer" value="1">
				
                <asp:Button ID="Button1" class="btn btn-large btn-success" runat="server" 
                    Text="Button" onclick="Button1_Click" />
			</div>
		</div>		
	</form>
       </div>


</asp:Content>
