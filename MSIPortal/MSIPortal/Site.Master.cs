using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace MSIPortal
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {

        private bool goPressed = false;
        public string WelcomeUserName
        {
            get
            {
                return lblWelcomeUserName.Text;
            }
            set
            {
                lblWelcomeUserName.Text = value;
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                tbl_User user = (tbl_User)Session["User"];
                int fileLeftSlider = Directory.GetFiles(Server.MapPath("~/ads_left/"), "*.*", SearchOption.TopDirectoryOnly).Length;
                int fileRightSlider = Directory.GetFiles(Server.MapPath("~/ads_right/"), "*.*", SearchOption.TopDirectoryOnly).Length;

                Session["FileCountLeft"] = fileLeftSlider;
                Session["FileCountRight"] = fileRightSlider;
                if (user != null)
                {

                    WelcomeUserName = user.FirstName + " " + user.LastName;
                    btnLoginLogout.Text = "Logout";
                }
                else
                {
                    WelcomeUserName = "Guest";
                    btnLoginLogout.Text = "Login";
                }
                // 

              
            }
            
        }

        protected void btnLoginLogout_Click(object sender, EventArgs e)
        {
            if (btnLoginLogout.Text == "Login")
            {
                Response.Redirect("Login.aspx");
            }
            else 
            {

                Session["User"] = null;
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("Post.aspx");
        }


        protected void btnGlobalSearch_Click(object sender, EventArgs e)
        {
            Session["SearchText"] = txtGlobalSearchText.Text.Trim();
            Response.Redirect("GlobalSearchResult.aspx");
        }





    }
}
