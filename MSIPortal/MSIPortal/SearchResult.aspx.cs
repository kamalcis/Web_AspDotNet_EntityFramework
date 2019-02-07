using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace MSIPortal
{
    public partial class SearchResult : System.Web.UI.Page
    {

        protected string GetImageUrl(string dbImgURL)
        {
            if (File.Exists( Server.MapPath( dbImgURL)))
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
                lblPsName.Text = Request.QueryString["psname"];
                lblCountryName.Text = Request.QueryString["countryname"];
                lblCityName.Text = Request.QueryString["cityname"];
                if (lblCityName.Text == "Select One") {
                    lblCityName.Text = "All City";
                }
                lblCategoryName.Text = Request.QueryString["catname"].Trim();
                this.BindGridData();

                 
            }
            
          
        }


        private List<tbl_Post> Search(string cat, string city, string type) // Search By Type, City, Category
        {
            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {

                var post = from p in ctx.tbl_Post where p.CategoryID == cat && p.CityID == city && p.PSTID == type && p.Approved== true
                orderby p.Rank ascending , p.EditDate descending select p;
                return post.ToList<tbl_Post>();

            }
        
        }


        private List<tbl_Post> SearchWithoutCity(string type, string county,string cat) // Search By Type, Country, Category // No City Supplied
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var post = from p in ctx.tbl_Post
                           where p.LU_tbl_City.CountryID == county && p.CategoryID == cat && p.PSTID == type && p.Approved == true
                           orderby p.EditDate descending
                           select p;
                return post.ToList<tbl_Post>();

            }

        }




        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            List<tbl_Post> listPost =(List<tbl_Post>) Session["SearchResult"];
            GridView1.DataSource = listPost;
            GridView1.DataBind();
           
        }


        private void BindGridData()
        {

                string category = Request.QueryString["cat"];
                string city = Request.QueryString["city"];
                string type = Request.QueryString["type"];
                string country = Request.QueryString["country"];
                List<tbl_Post> searchResult = new List<tbl_Post>() ;
                
                if (category != "0" && city != "0") // If city is supplied
                {
                    searchResult = Search(category, city, type);
                    
                }

                if (country != "0" && category != "0" && city == "0") // If city is not supplied only country is supplied
                {
                    searchResult = SearchWithoutCity(type,country,category);
                    
                }

                lblNumberofRecord.Text = String.Concat(searchResult.Count);
                Session["SearchResult"] = searchResult;
                GridView1.DataSource = searchResult;
                GridView1.DataBind();
        }
       

    }
}