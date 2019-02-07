using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;

namespace MSIPortal
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text.Trim() == string.Empty)
            {
                lblSuccessMessage.Text = "Email required";
                return;
            }          

            string password = string.Empty;

            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {
                var result = from p in ctx.tbl_UserPassword where p.tbl_User.LoginName == txtEmail.Text.Trim() select p;
                tbl_UserPassword tblPassword = result.FirstOrDefault<tbl_UserPassword>();
                if (tblPassword != null)
                {
                    password = tblPassword.Password;
                }
            
            }

            if (password != string.Empty)
            {

                try
                {

                    var client = new SmtpClient("smtp.gmail.com", 587)
                    {
                        Credentials = new NetworkCredential("posting.microcomp@gmail.com", "posting2014"),
                        EnableSsl = true
                    };
                    client.Send("posting.microcomp@gmail.com", txtEmail.Text.Trim(), "Password Recovery", "Your Lost password: " + password);
                    lblSuccessMessage.Text = "Your password has been sent to your email.";
                    txtEmail.Text = string.Empty;
                    txtEmail.Focus();
                    lblErrorMessage.Text = string.Empty;

                }
                catch (Exception ex)
                {

                    lblErrorMessage.Text = "Error occured.";
                    lblSuccessMessage.Text = string.Empty;
                }
            }
            else
            {

                lblErrorMessage.Text = "Email does not exist.";
                lblSuccessMessage.Text = string.Empty;
            }
            

        }
    }
}