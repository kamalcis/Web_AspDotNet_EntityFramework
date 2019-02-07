using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace MSIPortal
{
    public partial class GlobalSearchResult : System.Web.UI.Page
    {


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

                this.BindGridData();
               
            }
        }// End Page Load


        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            //BindGridData();
            GridView1.DataSource = (List<tbl_Post>)Session["PostList"];
            GridView1.DataBind();

        }


        private void BindGridData()
        {
           

                List<tbl_Post> posts = this.PerformGlobalSearch((string)Session["SearchText"]);
               // List<tbl_Post> posts = this.PerformGlobalSearchBasicLikeOperation((string)Session["SearchText"]);
                Session["PostList"] = posts;
                lblRecordCount.Text = posts.Count.ToString();
                GridView1.DataSource = posts; // Call the Master Page Method
                GridView1.DataBind();
                   
        }


        #region GlobalSearch


        public List<tbl_Post> PerformGlobalSearch(string searchText)
        {

            string sentence = searchText.Trim();
            if (sentence == string.Empty || sentence == null) { return new List<tbl_Post>(); } // Exit program if Empty
            string[] words = sentence.Split(' ');
            List<LU_tbl_Country> countryList = GetAllCountry();
            List<LU_tbl_City> cityList = GetAllCity();
            bool isCountry = false;
            string countryName = "";
            bool isCity = false;
            string cityName = "";



            List<tbl_Post> searchResult = new List<tbl_Post>();
            int score = 0;

            foreach (string word in words) // Determine The Sentence Contain Country or City
            {

                var country = from c in countryList.Where(c => c.CountryName == word) select c;
                List<LU_tbl_Country> coList = country.ToList<LU_tbl_Country>();
                if (coList.Count > 0)
                {
                    isCountry = true;
                    countryName = word;
                }

                var city = from c in cityList.Where(c => c.CityName == word) select c;
                List<LU_tbl_City> ctList = city.ToList<LU_tbl_City>();
                if (ctList.Count > 0)
                {
                    isCity = true;
                    cityName = word;
                }

            }


            if (isCountry) // If Country Name Provided
            {

                List<tbl_Post> postByCountryList = GetPostByCountry(countryName);
                foreach (tbl_Post post in postByCountryList)
                {
                    post.Rank = 0;
                    score = 0;
                    foreach (string word in words)
                    {

                        if (post.PostTitle.ToLower().Contains(word.ToLower()))
                        {
                            score = score + 1;
                            post.Rank = score;
                        }

                    }

                }

                var varSearchResult = from p in postByCountryList.Where(p => p.Rank > 0) orderby p.Rank descending, p.EditDate descending select p;
                searchResult = varSearchResult.ToList<tbl_Post>();
                return searchResult;  // Exit Program

            }

            if (isCity)  // IF City Name is Provided
            {
                List<tbl_Post> postByCityList = GetPostByCity(cityName);

                foreach (tbl_Post post in postByCityList)
                {
                    post.Rank = 0;
                    score = 0;
                    foreach (string word in words)
                    {

                        if (post.PostTitle.ToLower().Contains(word.ToLower()))
                        {
                            score = score + 1;
                            post.Rank = score;
                        }

                    }


                }

                var varSearchResult = from p in postByCityList.Where(p => p.Rank > 0) orderby p.Rank descending, p.EditDate descending select p;
                searchResult = varSearchResult.ToList<tbl_Post>();
                return searchResult;  // Exit Program

            }

            if (isCountry == false && isCity == false) // IF No Country City is Provided
            {

                List<tbl_Post> allPostList = GetAllPost();
                foreach (tbl_Post post in allPostList)
                {
                    post.Rank = 0;
                    score = 0;
                    foreach (string word in words)
                    {

                        if (post.PostTitle.ToLower().Contains(word.ToLower()))
                        {
                            score = score + 1;
                            post.Rank = score;
                        }

                    }

                }

                var varSearchResult = from p in allPostList.Where(p => p.Rank > 0) orderby p.Rank descending, p.EditDate descending select p;
                searchResult = varSearchResult.ToList<tbl_Post>();
                return searchResult;  // Exit Program


            }

            return searchResult;
        }

        public List<tbl_Post> PerformGlobalSearchBasicLikeOperation(string searchText) 
        {
            using (MSIPortalContext ctx = new MSIPortalContext()) 
            {
                var result = from post in ctx.tbl_Post where post.PostTitle.Contains(searchText) select post;
                return result.ToList<tbl_Post>();
            
            }
        
        }

        private List<LU_tbl_Country> GetAllCountry()
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var list = from country in ctx.LU_tbl_Country select country;
                return list.ToList<LU_tbl_Country>();
            }
        }

        private List<LU_tbl_City> GetAllCity()
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var list = from c in ctx.LU_tbl_City select c;
                return list.ToList<LU_tbl_City>();
            }
        }

        private List<tbl_Post> GetPostByCountry(string countryName)
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var list = from p in ctx.tbl_Post where p.LU_tbl_City.LU_tbl_Country.CountryName == countryName select p;
                return list.ToList<tbl_Post>();
            }
        }


        private List<tbl_Post> GetPostByCity(string cityName)
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var list = from c in ctx.tbl_Post where c.LU_tbl_City.CityName == cityName select c;
                return list.ToList<tbl_Post>();
            }
        }


        private List<tbl_Post> GetAllPost()
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var list = from p in ctx.tbl_Post select p;
                return list.ToList<tbl_Post>();
            }
        }
        #endregion GlobalSearch

        
    }// End Class
}// End Project