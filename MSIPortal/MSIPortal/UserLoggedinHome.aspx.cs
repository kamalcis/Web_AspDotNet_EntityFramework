using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity.Validation;
using System.Data.Entity;

namespace MSIPortal
{
    public partial class UserLoggedinHome : System.Web.UI.Page
    {

       
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) {

                BindGrid();
                
                
                TabContainer1.ActiveTabIndex = 0;
                TabPanelEditPost.Visible = false;

                if (Session["User"] != null) 
                {
                    tbl_User user = (tbl_User)Session["User"];
                    lblFirstName.Text = user.FirstName.Trim();
                    lblLastName.Text = user.LastName.Trim();
                    lblLoginName.Text = user.LoginName.Trim();
                    lblUserRole.Text = "Ordinary User";
                }

                //=============On EditPost is activated
                
                    this.FillCommonCountry();
                    this.FillCategoryDropDownBox();
                    this.FillAllCity();
                

            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
            TabContainer1.ActiveTabIndex = 2;
        }

        private void BindGrid() 
        {

            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {
                tbl_User user =(tbl_User) Session["User"];
               
                var list = from p in ctx.tbl_Post where p.PostingUserID == user.UserID orderby p.EditDate descending select p ;

                if (list != null)
                {
                    GridView1.DataSource = list.ToList<tbl_Post>();
                    GridView1.DataBind();
                }
            }
        }

        //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    TabPanelEditPost.Visible = true;
        //    TabPanelEditPost.Focus();
        //}



        #region TabYourPost
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            TabPanelEditPost.Visible = true;
            TabContainer1.ActiveTabIndex = 3;
            if (e.CommandName == "Modify") 
            {

                string argument = e.CommandArgument.ToString();
                using (MSIPortalContext ctx = new MSIPortalContext()) 
                {
                    Guid postId = new Guid(e.CommandArgument.ToString());
                    var post = from p in ctx.tbl_Post where p.PostID == postId select p;
                    tbl_Post objPost = post.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();
                    Session["PostTobeModify"] = objPost;


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
                    PSImage.ImageUrl = objPost.ImageUrl;

                    if (objPost.PSTID == "001")
                    {

                        rdoCommonSales.Checked = true;
                    }
                    else {

                        rdoCommonService.Checked = true;
                    }

                }
            }
        }
        #endregion TabYourPost

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

        protected void ddlCommonCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.FillCommonCity(ddlCommonCountry.SelectedValue);
            
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {


            //============Initialize Post Table
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                //try
                //{
                    tbl_Post objPost = (tbl_Post)Session["PostTobeModify"];
                    objPost.CategoryID = ddlCategory.SelectedValue;
                    objPost.CityID = ddlCommonCity.SelectedValue;
                    LU_tbl_City city = ctx.LU_tbl_City.Where(c=> c.CityID == ddlCommonCity.SelectedValue).FirstOrDefault<LU_tbl_City>();
                    objPost.LU_tbl_City = city;

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


                    if ( commonImageUpload.PostedFile!=null && commonImageUpload.PostedFile.FileName != string.Empty)
                    {
                        commonImageUpload.SaveAs(Server.MapPath("~/imageupload/" + objPost.PostID + ".jpg"));
                        objPost.ImageUrl = "/imageupload/" + objPost.PostID + ".jpg";
                    }
                    //else
                    //{
                    //    objPost.ImageUrl = "/Styles/images/" + "no_image.jpg";

                    //}



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
                    ////---------------After Successful Save Do the following operation
                    //MessagePanel.Visible = true;
                    //lblSuccessMessage.Visible = true;
                    this.BindGrid();
                    TabContainer1.ActiveTabIndex = 2;
                    TabPanelEditPost.Visible = false;
                    //lblUserEmailValidation.Text = string.Empty;
                    //this.ClearForm();
                    //ddlCommonCountry.Focus();
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

      
        #endregion TabEditPost

        protected void btnSave_Click(object sender, EventArgs e)
        {
            tbl_User user = (tbl_User)Session["User"];
            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {
                var pass = from p in ctx.tbl_UserPassword
                           where p.Password == txtExistingPassword.Text.Trim() && p.tbl_User.LoginName == user.LoginName
                           select p;
                tbl_UserPassword password = pass.FirstOrDefault<tbl_UserPassword>();

                if (password != null)
                {
                    if (txtNewPassword.Text.Trim() == txtConfirmNewPassword.Text.Trim())
                    {

                        password.Password = txtNewPassword.Text.Trim();
                        ctx.Entry(password).State = EntityState.Modified;
                        ctx.SaveChanges();
                        txtExistingPassword.Text = string.Empty;
                        txtNewPassword.Text = string.Empty;
                        txtConfirmNewPassword.Text = string.Empty;
                        
                        cpSuccessMessage.Text = "Password changed successfully";
                        cpErrorMessage.Text = string.Empty;
                        txtExistingPassword.Focus();
                    }
                    else
                    {
                        cpSuccessMessage.Text = string.Empty;
                        cpErrorMessage.Text = "New password and confirm new password miss match.";
                    }
                }
                else 
                {
                    cpSuccessMessage.Text = string.Empty;
                    cpErrorMessage.Text = "Provided password does not exist.";    
                }
            }

        }

       

       

    }
}
       