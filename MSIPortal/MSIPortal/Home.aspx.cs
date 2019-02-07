using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MSIPortal
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.FillCountry();
                this.FillCategoryDropDownBox(); 

            }
            
           
        }

       

        protected void btnSearch_Click(object sender, EventArgs e)
        {

            string CountryId = ddlCountry.SelectedValue;
            string cityId = ddlCity.SelectedValue;
            string categoryId = ddlCategory.SelectedValue;
            string productServiceType = string.Empty;
            string productServiceName = "";
            if (rdoProduct.Checked)
            {
                productServiceType = "001";
                productServiceName = "Sales";
            }
            else 
            {
                productServiceType = "002";
                productServiceName = "Services";
            }

            string cityValue = "";
            if (ddlCity.Items.Count ==0)
            {

                cityValue = "Select One";
            }
            else {
                cityValue = ddlCity.SelectedItem.Text.Trim();
            
            }
           
            Server.Transfer("SearchResult.aspx?country="+CountryId +"&cat="+categoryId+"&city="+cityId+"&type="+productServiceType+"&cityname="+cityValue+"&catname="+ddlCategory.SelectedItem.Text+"&countryname="+ddlCountry.SelectedItem.Text+"&psname="+productServiceName );


        }


        private void FillCategoryDropDownBox()
        {


            
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                List<LU_tbl_Category> categoryListRoot = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == Convert.ToString("0000")).ToList<LU_tbl_Category>();


                foreach (LU_tbl_Category rootCategory in categoryListRoot)
                {

                    ddlCategory.Items.Add(rootCategory.CategoryName);
                    var listItem = ddlCategory.Items.FindByText(rootCategory.CategoryName);
                    listItem.Attributes["disabled"] = "true";
                    
                    listItem.Attributes.Add("style", "font-weight: bold");


                    List<LU_tbl_Category> catListNodeWise = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == rootCategory.CategoryID.ToString()).ToList<LU_tbl_Category>();
                    foreach (LU_tbl_Category cat in catListNodeWise)
                    {
                        string indentSize = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                        string strDisplayName = HttpUtility.HtmlDecode(indentSize) + cat.CategoryName;
                        ddlCategory.Items.Add(new ListItem(strDisplayName, cat.CategoryID));

                    }


                }
            }

            ddlCategory.Items.Insert(0, new ListItem("Select One", "0"));
        }




        private void FillCity(string CountryId)
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



        private void FillCountry()
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                List<LU_tbl_Country> lstCity = ctx.LU_tbl_Country.ToList<LU_tbl_Country>();

                ddlCountry.DataSource = lstCity;
                ddlCountry.DataValueField = "CountryID";
                ddlCountry.DataTextField = "CountryName";
                ddlCountry.DataBind();
                ddlCountry.Items.Insert(0, new ListItem("Select One", "000"));
               
            }
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCountry.SelectedValue != "000")
            {
                ddlCity.Enabled = true;
            }
            else
            {
                ddlCity.Enabled = false;  
            }
            this.FillCity(ddlCountry.SelectedValue);
        }


        protected void CheckUncheckOption() 
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                



            }
        
        }


        [System.Web.Services.WebMethod]
        public static string ReturnData(string categoryId)
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                LU_tbl_Category category = ctx.LU_tbl_Category.Where(c => c.CategoryID == categoryId).FirstOrDefault();
                return category.PSTID;
            }


        }


        
    }
}