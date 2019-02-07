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
    public partial class Rank : System.Web.UI.Page
    {

        List<string> ListId = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {

            //============Access Control================
            tbl_User user = (tbl_User)Session["User"];
            if (user == null)
            {

                Response.Redirect("AccessDenied.aspx");

            }
            else
            {
                if (user.RoleID.Trim() != "001")
                {

                    Response.Redirect("AccessDenied.aspx");
                }
            }
            //======================Access Control=============


            if (!Page.IsPostBack)
            {

                Session.Add("ListId", ListId);
                // Fill Search Section
                this.FillSearchCountry();
                this.FillSearchCategory();

               
                // Fill Edit Rank Section
                
                this.FillCommonCountry();// Value Set
                this.FillAllCity();
                this.FillCategoryDropDownBox(); // Value Set. 

                //this.SetFieldsForUpdate();
                TabContainer1.ActiveTabIndex = 0;
                TabPanelEditRank.Visible = false;
            }



        }


        #region PostByCategory 
       


        protected void btnSearch_Click(object sender, EventArgs e)
        {

            string CountryId = ddlCountry.SelectedValue;
            string cityId = ddlCity.SelectedValue;
            string categoryId = ddlSearchCategory.SelectedValue;
            string productServiceType = string.Empty;
          
            if (rdoProduct.Checked)
            {
                productServiceType = "001";
               
            }
            else
            {
                productServiceType = "002";
               
            }



            this.BinGridData(categoryId, cityId, productServiceType);


        }


        private void FillSearchCategory()
        {



            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                List<LU_tbl_Category> categoryListRoot = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == Convert.ToString("0000")).ToList<LU_tbl_Category>();


                foreach (LU_tbl_Category rootCategory in categoryListRoot)
                {

                    ddlSearchCategory.Items.Add(rootCategory.CategoryName);
                    var listItem = ddlSearchCategory.Items.FindByText(rootCategory.CategoryName);
                    listItem.Attributes["disabled"] = "true";

                    listItem.Attributes.Add("style", "font-weight: bold");


                    List<LU_tbl_Category> catListNodeWise = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == rootCategory.CategoryID.ToString()).ToList<LU_tbl_Category>();
                    foreach (LU_tbl_Category cat in catListNodeWise)
                    {
                        string indentSize = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                        string strDisplayName = HttpUtility.HtmlDecode(indentSize) + cat.CategoryName;
                        ddlSearchCategory.Items.Add(new ListItem(strDisplayName, cat.CategoryID));

                    }


                }
            }

            ddlSearchCategory.Items.Insert(0, new ListItem("Select One", "0"));
        }




        private void FillSearchCity(string CountryId)
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                List<LU_tbl_City> lstCity = ctx.LU_tbl_City.Where(c => c.CountryID == CountryId).ToList<LU_tbl_City>();

                ddlCity.DataSource = lstCity;
                ddlCity.DataValueField = "CityID";
                ddlCity.DataTextField = "CityName";
                ddlCity.DataBind();
                ddlCity.Items.Insert(0, new ListItem("Select One", "0"));
            }

        }



        private void FillSearchCountry()
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                List<LU_tbl_Country> lstCity = ctx.LU_tbl_Country.ToList<LU_tbl_Country>();

                ddlCountry.DataSource = lstCity;
                ddlCountry.DataValueField = "CountryID";
                ddlCountry.DataTextField = "CountryName";
                ddlCountry.DataBind();
                ddlCountry.Items.Insert(0, new ListItem("Select One", "0"));

            }
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.FillSearchCity(ddlCountry.SelectedValue);
        }

              

        
        #endregion EndPostByCategory

        #region GridData
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

        private void BinGridData(string cat, string city, string type) 
        {      
       
            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {

                var post = from p in ctx.tbl_Post where p.CategoryID == cat && p.CityID == city && p.PSTID == type && p.Approved== true
                orderby p.EditDate descending select p;
                List<tbl_Post> list = post.ToList<tbl_Post>();
                if (list.Count < 1)
                {
                    SearchMessagePanel.Visible = true;
                    lblSearchMessage.Text = "No record found";
                }
                else 
                {

                    SearchMessagePanel.Visible = false;
                }

                GridView1.DataSource = list;
                GridView1.DataBind();

            }
        
        }         
        
       

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            string cat = ddlSearchCategory.SelectedValue;
            string city = ddlCity.SelectedValue;
            string type = string.Empty;

            if (rdoProduct.Checked)
            {
                type = "001";
                
            }
            else
            {
                type = "002";
                
            }
            TabContainer1.ActiveTabIndex = 0;
            BinGridData(cat,city,type);
            
          
        }

             

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            TabPanelEditRank.Visible = true;
            TabContainer1.ActiveTabIndex = 1;
            if (e.CommandName == "Modify")
            {
                string id = Convert.ToString(e.CommandArgument);
                this.SetFieldsForUpdate(id);
                this.hiddenPostId.Value = id;
                this.DisableFields();
            }
           
        }



        #endregion GridData

        #region TabEditPost
        //==============================Method for Tab Edit Post==================================

        private void FillCategoryDropDownBox()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_Category> categoryListRoot = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == Convert.ToString("0000")).ToList<LU_tbl_Category>();


            foreach (LU_tbl_Category rootCategory in categoryListRoot)
            {

                ddlCommonCategory.Items.Add(rootCategory.CategoryName);
                var listItem = ddlCommonCategory.Items.FindByText(rootCategory.CategoryName);
                listItem.Attributes["disabled"] = "disabled";
                listItem.Attributes.Add("style", "font-weight: bold");


                List<LU_tbl_Category> catListNodeWise = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == rootCategory.CategoryID.ToString()).ToList<LU_tbl_Category>();
                foreach (LU_tbl_Category cat in catListNodeWise)
                {
                    string indentSize = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    string strDisplayName = HttpUtility.HtmlDecode(indentSize) + cat.CategoryName;
                    ddlCommonCategory.Items.Add(new ListItem(strDisplayName, cat.CategoryID));

                }


            }

            ddlCommonCategory.Items.Insert(0, new ListItem("Select One", "0"));
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

        private void SetFieldsForUpdate(string id)
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                
                Guid postId = new Guid(id);
                var post = from p in ctx.tbl_Post where p.PostID == postId select p;
                tbl_Post objPost = post.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();


                this.ddlCommonCountry.SelectedValue = objPost.LU_tbl_City.LU_tbl_Country.CountryID;
                this.ddlCommonCity.SelectedValue = objPost.CityID;
                this.ddlCommonCategory.SelectedValue = objPost.CategoryID;
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
                ddlRank.SelectedValue = Convert.ToString(objPost.Rank);
             

            }


        }

        private void DisableFields()
        {
            this.ddlCommonCountry.Enabled = false;
            this.ddlCommonCity.Enabled = false;
            this.ddlCommonCategory.Enabled = false;
            this.txtCommonProviderFirstName.Enabled = false;
            this.txtCommonProviderLastName.Enabled = false;
            this.txtCommonProviderAddress.Enabled = false;
            this.txtCommonProviderEmil.Enabled = false;
            this.txtCommonProviderPhone.Enabled = false;
            this.txtCommonPostingTitle.Enabled = false;
            this.txtCommonPostingDescription.Enabled = false;
            this.rdoCommonSales.Enabled = false;
            this.rdoCommonService.Enabled = false;
            this.commonImageUpload.Enabled = false;
          
        
        
        }

        private void UpdateRank()
        {
            //============Initialize Post Table
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                //try
                //{
                string id = hiddenPostId.Value;
                var posting = from post in ctx.tbl_Post where post.PostID == new Guid(id) select post;
                tbl_Post objPost = posting.ToList<tbl_Post>().FirstOrDefault<tbl_Post>();

                objPost.Rank = Convert.ToInt32(ddlRank.SelectedValue); // Only Rank WIll Update
                ctx.tbl_Post.Attach(objPost);
                ctx.Entry(objPost).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ////---------------After Successful Update Do the following operation
                MessagePanel.Visible = true;
                //lblSuccessMessage.Visible = true;
                //lblSuccessMessage.Text = "Rank updated suffessfully.";
                TabContainer1.ActiveTabIndex = 1;
                TabPanelEditRank.Visible = false;


                // GEt Parameter for Bind DataGrid
                string cat = ddlSearchCategory.SelectedValue;
                string city = ddlCity.SelectedValue;
                string type = string.Empty;

                if (rdoProduct.Checked)
                {
                    type = "001";

                }
                else
                {
                    type = "002";

                }

                BinGridData(cat, city, type);             
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
            this.UpdateRank();
        }

        #endregion TabEditPost

        
    }
}