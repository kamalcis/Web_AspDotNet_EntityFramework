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
    public partial class ViewEditApproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
            if (!Page.IsPostBack)
            {


                tbl_Post post = GetPost();
                FillDetails();
                this.FillCommonCountry();// Value Set
                this.FillAllCity(); 
                this.FillCategoryDropDownBox(); // Value Set. 

                this.SetFieldsForUpdate();
                TabContainer1.ActiveTabIndex = 0;
            }



        }


        #region DetailsRegion
        protected void FillDetails() 
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

                    itemImage.ImageUrl = postingDetail.ImageUrl + "?id=" + Guid.NewGuid();
                }
                else
                {

                    itemImage.ImageUrl = "/Styles/images/image_not_found.jpg";
                }

               

            }
        
        }

        private tbl_Post GetPost()
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                string id = Request.QueryString["ID"];
                var posting = from post in ctx.tbl_Post where post.PostID == new Guid(id) select post;
                tbl_Post postingDetail = posting.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();
                return postingDetail;
            }           
        
        }

        protected void btnEmail_Click(object sender, EventArgs e)
        {

            PanelEmail.Visible = true;
        }

        protected void btnSearchResult_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApprovePost.aspx");

        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                string id = Request.QueryString["ID"];
                if (id != string.Empty)
                {
                    var posting = from post in ctx.tbl_Post where post.PostID == new Guid(id) select post;
                    tbl_Post postingDetail = posting.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();

                    postingDetail.Approved = true;
                    ctx.Entry(postingDetail).State = EntityState.Modified;
                    ctx.SaveChanges();
                    Response.Redirect("ApprovePost.aspx");

                }



            }
        }
        #endregion EndDetailsRegion

     
        #region TabEditPost
        //==============================Method for Tab Edit Post==================================

        private void FillCategoryDropDownBox()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_Category> categoryListRoot = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == Convert.ToString("0000")).ToList<LU_tbl_Category>();


            foreach (LU_tbl_Category rootCategory in categoryListRoot)
            {

                ddlCategory.Items.Add(rootCategory.CategoryName);
                var listItem = ddlCategory.Items.FindByText(rootCategory.CategoryName);
                listItem.Attributes["disabled"] = "disabled";
                listItem.Attributes.Add("style", "font-weight: bold");


                List<LU_tbl_Category> catListNodeWise = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == rootCategory.CategoryID.ToString()).ToList<LU_tbl_Category>();
                foreach (LU_tbl_Category cat in catListNodeWise)
                {
                    string indentSize = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    string strDisplayName = HttpUtility.HtmlDecode(indentSize) + cat.CategoryName;
                    ddlCategory.Items.Add(new ListItem(strDisplayName, cat.CategoryID));

                }


            }

            ddlCategory.Items.Insert(0, new ListItem("Select One", "0"));
        }



        private void FillCommonCountry()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_Country> lstCity = ctx.LU_tbl_Country.ToList<LU_tbl_Country>();

            ddlCommonCountry.DataSource = lstCity;
            ddlCommonCountry.DataValueField = "CountryID";
            ddlCommonCountry.DataTextField = "CountryName";
            ddlCommonCountry.DataBind();
            ddlCommonCountry.Items.Insert(0, new ListItem("Select", "0"));

        }


        private void FillCommonCity(string CountryId)
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_City> lstCity = ctx.LU_tbl_City.Where(c => c.CountryID == CountryId).ToList<LU_tbl_City>();

            ddlCommonCity.DataSource = lstCity;
            ddlCommonCity.DataValueField = "CityID";
            ddlCommonCity.DataTextField = "CityName";
            ddlCommonCity.DataBind();
            ddlCommonCity.Items.Insert(0, new ListItem("Select", "0"));

        }

        private void FillAllCity()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_City> lstCity = ctx.LU_tbl_City.ToList<LU_tbl_City>();

            ddlCommonCity.DataSource = lstCity;
            ddlCommonCity.DataValueField = "CityID";
            ddlCommonCity.DataTextField = "CityName";
            ddlCommonCity.DataBind();
            ddlCommonCity.Items.Insert(0, new ListItem("Select", "0"));

        }

        private void SetFieldsForUpdate() 
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                string id = Request.QueryString["ID"];
                Guid postId = new Guid(id);
                var post = from p in ctx.tbl_Post where p.PostID == postId select p;
                tbl_Post objPost = post.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();               


                this.ddlCommonCountry.SelectedValue = objPost.LU_tbl_City.LU_tbl_Country.CountryID;
                this.ddlCommonCity.SelectedValue = objPost.CityID;
                this.ddlCategory.SelectedValue = objPost.CategoryID;
                this.txtCommonProviderFirstName.Text = objPost.ProviderFirstName;
                this.txtCommonProviderLastName.Text = objPost.ProviderLastName;
                this.txtCommonProviderAddress.Text = objPost.ProviderAddress;
                this.txtCommonProviderEmil.Text = objPost.ProviderEmail;
                this.txtCommonProviderPhone.Text = objPost.ProviderPhoneNo;
                this.txtCommonPostingTitle.Text = objPost.PostTitle;
                this.txtCommonPostingDescription.Text = objPost.PostDescription;
                PSImage.ImageUrl = objPost.ImageUrl + "?id=" + Guid.NewGuid();

                if (objPost.PSTID == "001")
                {

                    rdoCommonSales.Checked = true;
                }
                else
                {

                    rdoCommonService.Checked = true;
                }

            }
        
        
        }


        private void UpdatePost() 
        {
            //============Initialize Post Table
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                //try
                //{
                string id = Request.QueryString["ID"];
                var posting = from post in ctx.tbl_Post where post.PostID == new Guid(id) select post;
                tbl_Post objPost = posting.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();


                objPost.CategoryID = ddlCategory.SelectedValue;
                objPost.CityID = ddlCommonCity.SelectedValue;
               // LU_tbl_City city = ctx.LU_tbl_City.Where(c => c.CityID == ddlCommonCity.SelectedValue).FirstOrDefault<LU_tbl_City>();
                //objPost.LU_tbl_City = city;

                if (rdoCommonSales.Checked)
                {
                    objPost.PSTID = "001";
                }
                else
                {
                    objPost.PSTID = "002";
                }

                objPost.PostTitle = this.txtCommonPostingTitle.Text.Trim();
                objPost.PostDescription = this.txtCommonPostingDescription.Text.Trim();


                if (commonImageUpload.PostedFile != null && commonImageUpload.PostedFile.FileName != string.Empty)
                {
                    commonImageUpload.SaveAs(Server.MapPath("~/imageupload/" + objPost.PostID + ".jpg"));
                    objPost.ImageUrl = "/imageupload/" + objPost.PostID + ".jpg";
                }
               


                //objPost.PostingUserID = ((tbl_User)Session["User"]).UserID;  // As it has benn already posted so no need to modify 
                objPost.ProviderFirstName = txtCommonProviderFirstName.Text.Trim();
                objPost.ProviderLastName = txtCommonProviderLastName.Text.Trim();
                objPost.ProviderAddress = txtCommonProviderAddress.Text.Trim();
                objPost.ProviderEmail = txtCommonProviderEmil.Text.Trim();
                objPost.ProviderPhoneNo = txtCommonProviderPhone.Text.Trim();
                //objPost.Approved = false;
                if (((tbl_User)Session["User"]) != null)
                {
                    objPost.EditUser = ((tbl_User)Session["User"]).UserID;  // User 
                }
                objPost.EditDate = DateTime.Now;

                ctx.tbl_Post.Attach(objPost);
                ctx.Entry(objPost).State = System.Data.Entity.EntityState.Modified;

                ctx.SaveChanges();
                ////---------------After Successful Update Do the following operation
                MessagePanel.Visible = true;
                lblSuccessMessage.Visible = true;
                lblSuccessMessage.Text = "Record updated suffessfully.";
                this.FillDetails(); // Update Display View of Details As well                
                TabContainer1.ActiveTabIndex = 0;
                
                //}
                //catch (DbEntityValidationException dbEx)
                //{
                //    foreach (var validationErrors in dbEx.EntityValidationErrors)
                //    {
                //        foreach (var validationError in validationErrors.ValidationErrors)
                //        {
                //            Trace.Write("Property: {0} Error: {1}" + validationError.PropertyName, validationError.ErrorMessage);
                //        }
                //    }
                //}
                //catch (Exception Ex)
                //{


                //}// End of Catch
            }
        
        }

        protected void ddlCommonCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.FillCommonCity(ddlCommonCountry.SelectedValue);

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            this.UpdatePost();
        }
       
        #endregion TabEditPost

      
    }
}