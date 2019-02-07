using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MSIPortal
{
    public partial class HomeSelect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            tbl_User user = (tbl_User)Session["User"];

            if (user != null)
            {
                if (user.RoleID == "001")
                {

                    Server.Transfer("AdminPanel.aspx");
                }
                else 
                {

                    Server.Transfer("UserLoggedinHome.aspx");
                }

            }
            else 
            {

                Response.Redirect("Home.aspx");
            }
        }
    }
}