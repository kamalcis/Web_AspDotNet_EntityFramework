using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MSIPortal
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) 
            {
                txtPassword.Attributes["type"] = "password";
               
            
            }
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {

                
                var user = from u in ctx.tbl_User
                           join p in ctx.tbl_UserPassword on u.UserID equals p.UserID
                           where u.LoginName == txtUserName.Text.Trim() && p.Password == txtPassword.Text.Trim()
                           select u;

                List<tbl_User> userList = user.ToList<tbl_User>();

                if (userList.Count > 0)
                {
                    tbl_User singleUser = userList.FirstOrDefault<tbl_User>();
                    if (singleUser.RoleID.Trim() == "001") // Admin User
                    {
                        
                        Session.Add("User", singleUser);                       
                        Response.Redirect("AdminPanel.aspx");

                    }
                    else
                    {
                       
                        Session.Add("User", singleUser);
                        Response.Redirect("UserLoggedinHome.aspx");
                     
                    }

                }
                else
                {

                    lblMessage.Text = "Incorrect UserName/Password.";
                    MessagePanel.Visible = true;
                }

            }
            
            
        }
    }
}