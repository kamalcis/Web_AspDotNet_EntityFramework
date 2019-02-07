<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServerErrorPage.aspx.cs" Inherits="MSIPortal.ServerErrorPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin-top:100px;">
     
     <div style="margin:0 auto; width:600px; ">       
     <div>
        
        <div style="width:80px;  float:left;"> <img src="Styles/images/dialog_warning.png" /> </div> 
        <div style="width:301px; margin-top:20px;  float:left;">Server Error detected.</div>
         
             
    </div>
    
     <div style="margin-top:80px;margin-left:100px; ">
    
    
    <asp:ImageButton ID="ImageButtonUser" runat="server" 
        ImageUrl="~/Styles/images/AngryHorse.png" Width="250px"/>
  

</div>

     <div style="margin-top:40px;">
    
         Application error detected on the particular operation .
         <br />
             Please contact to service provider.
    </div>
    </div>
    </div>
    </form>
</body>
</html>
