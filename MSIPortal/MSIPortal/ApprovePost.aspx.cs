using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;
using System.IO;




namespace MSIPortal
{
    public partial class ApprovePost : System.Web.UI.Page
    {



        List<string> ListId = new List<string>();
        
        protected string GetImageUrl(string dbImgURL)
        {
            if (File.Exists(Server.MapPath(dbImgURL)))
            {
                return dbImgURL;
            }
            else
            {
                return "/Styles/images/image_not_found.jpg";
            }
        }
        
        
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session.Add("ListId", ListId);
                BinGridData();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            MaintainCheckedId(); // Collect Information Before DataBinding

            GridView1.DataSource = (List<tbl_Post>)Session["ApprovalList"];
            GridView1.DataBind();
            PutCheckBoxtoSavedId(); // Put Check after Data Bind
        }

      
        protected void btnApprove_Click(object sender, EventArgs e)
        {
            MaintainCheckedId();// Put Checked Id to Session
            List<string> approvalList =(List<string>) Session["ListId"];

            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {

                foreach (string id in approvalList) {

                    tbl_Post post = ctx.tbl_Post.Where(p => p.PostID == new Guid(id)).FirstOrDefault<tbl_Post>();
                    post.Approved = true;
                    ctx.Entry(post).State = EntityState.Modified;
                    ctx.SaveChanges();
                }
            }
            BinGridData();
        }


        private void BinGridData()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            var post = from p in ctx.tbl_Post 
                       where p.Approved == false orderby p.EditDate descending
                       select p;

            List<tbl_Post> listPost = post.ToList<tbl_Post>();

            if (listPost.Count > 0)
            {

                List<tbl_Post> approveList =  post.ToList<tbl_Post>();
                GridView1.DataSource = approveList;
                Session["ApprovalList"] = approveList;
                GridView1.DataBind();
            }
            else 
            {

                GridView1.Visible = false;
                btnApprove.Visible = false;
                lblNoRecordMessage.Text = "No Record is pending for approval.";
                lblNoRecordMessage.Visible = true;
            }
        }

        private void MaintainCheckedId()  // This method will be called before databinding
        {

            foreach (GridViewRow row in GridView1.Rows)
            {
                HiddenField hiddenId = (HiddenField)row.FindControl("hiddenPostId");
                CheckBox chkBox = ((CheckBox)row.FindControl("chkItem"));

                if (chkBox.Checked)
                {
                    ListId = (List<string>)Session["ListId"];
                    RemoveItem(ListId, hiddenId.Value);
                    ListId.Add(hiddenId.Value);
                    Session.Add("ListId", ListId);

                }
                else
                { 
                    ListId = (List<string>)Session["ListId"];
                    RemoveItem(ListId, hiddenId.Value);
                    Session.Add("ListId", ListId);
                }

            }

        }


        private void PutCheckBoxtoSavedId() // This Method will be called after databind
        {
            try
            {
                ListId = (List<string>)Session["ListId"];
                if (this.ListId != null)
                {
                    foreach (GridViewRow row in GridView1.Rows)
                    {
                        HiddenField hiddenId = (HiddenField)row.FindControl("hiddenPostId");
                        for (int i = 0; i < ListId.Count; i++)
                        {
                            if (ListId[i] == hiddenId.Value)
                            {
                                ((CheckBox)row.FindControl("chkItem")).Checked = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }





        private void RemoveItem(List<string> list,string id)
        {
            try
            {
                if (list == null)
                {
                    return;
                }
                for (int i = 0; i < list.Count; i++)
                {
                    if (list[i] == id)
                    {
                        list.Remove(id);
                        
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void SelectAll_CheckChanged(object sender, EventArgs e)
        {

            CheckBox ChkBoxHeader = (CheckBox)GridView1.HeaderRow.FindControl("chkCheckAll");
            foreach (GridViewRow row in GridView1.Rows)
            {   
              
                CheckBox chkBox = ((CheckBox)row.FindControl("chkItem"));
                if (ChkBoxHeader.Checked)
                {
                    chkBox.Checked = true;
                }
                else {
                    chkBox.Checked = false;
                }
                
               
            }
        }
        


    }
}