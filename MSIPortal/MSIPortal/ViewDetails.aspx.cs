using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net.Mail;
using System.Net;

namespace MSIPortal
{
    public partial class ViewDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    string id = Request.QueryString["ID"];
                    var posting = from post in ctx.tbl_Post where post.PostID == new Guid(id) select post;
                    tbl_Post postingDetail = posting.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();

                    lblTitle.Text = postingDetail.PostTitle.Trim();
                    lblName.Text = postingDetail.ProviderFirstName + " " + postingDetail.ProviderLastName;
                    lblAddress.Text = postingDetail.ProviderAddress;
                    lblDescription.Text = postingDetail.PostDescription;
                    lblEmail.Text = postingDetail.ProviderEmail;
                    lblPhone.Text = postingDetail.ProviderPhoneNo;
                    if (File.Exists(Server.MapPath(postingDetail.ImageUrl)))
                    {

                        itemImage.ImageUrl = postingDetail.ImageUrl;
                    }
                    else 
                    {

                        itemImage.ImageUrl = "/Styles/images/image_not_found.jpg";
                    }
                    

                }

            }
        }

       

        protected void btnEmail_Click(object sender, EventArgs e)
        {
            PanelPhoneNo.Visible = false;
            PanelEmail.Visible = true;
            txtSubject.Focus();
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (txtSubject.Text.Trim() == string.Empty) 
            {
                lblMessage.Text = "Subject required";
                return;
            }

            if (txtBody.Text.Trim() == string.Empty) 
            {
                lblMessage.Text = "Email body required";
                return;
            
            }

            
            try
            {

                var client = new SmtpClient("smtp.gmail.com", 587)               
                {
                    Credentials = new NetworkCredential("posting.microcomp@gmail.com", "posting2014"),
                    EnableSsl = true
                };
                client.Send("posting.microcomp@gmail.com", lblEmail.Text.Trim(), txtSubject.Text.Trim(), txtBody.Text.Trim());
                lblMessage.Text = "Your message has been sent successfully.";
                txtSubject.Text = "";
                txtBody.Text = "";
                PanelEmail.Visible = false;

            }
            catch (Exception ex) 
            {

                lblMessage.Text = "Failed to send the message.";
            }
            
        }

        protected void txtBody_TextChanged(object sender, EventArgs e)
        {
            
        }


       
       

       
    }
}