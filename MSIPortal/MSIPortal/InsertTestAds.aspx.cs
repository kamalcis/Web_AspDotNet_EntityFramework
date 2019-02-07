using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace MSIPortal
{
    public partial class InsertTestAds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            MSIPortalContext ctx = new MSIPortalContext();
            tbl_Post ads = new tbl_Post();
            ads.PostTitle = this.txtTitle.Text;
            ads.PostDescription = this.txtDescription.Text;
            //ads.AdImage = FileUpload1.FileBytes;
            ads.CategoryID = "1";            
            ctx.tbl_Post.Add(ads);
            ctx.SaveChanges();
             
            
        }
    }
}