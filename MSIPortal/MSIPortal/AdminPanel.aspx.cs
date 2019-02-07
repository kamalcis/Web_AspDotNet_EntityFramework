using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MSIPortal
{
    public partial class AdminPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
            
            ImageButtonUser.Attributes.Add("onmouseover", "src='Styles/Images/userMO.png'");
            ImageButtonUser.Attributes.Add("onmouseout", "src='Styles/Images/user.png'");


            ImageButtonCountry.Attributes.Add("onmouseover", "src='Styles/Images/countryMO.png'");
            ImageButtonCountry.Attributes.Add("onmouseout", "src='Styles/Images/country.png'");

            ImageButtonCity.Attributes.Add("onmouseover", "src='Styles/Images/cityMO.png'");
            ImageButtonCity.Attributes.Add("onmouseout", "src='Styles/Images/city.png'");

            ImageButtonCategory.Attributes.Add("onmouseover", "src='Styles/Images/categoryMO.png'");
            ImageButtonCategory.Attributes.Add("onmouseout", "src='Styles/Images/category.png'");

            ImageButtonApprove.Attributes.Add("onmouseover", "src='Styles/Images/approveMO.png'");
            ImageButtonApprove.Attributes.Add("onmouseout", "src='Styles/Images/approve.png'");

            ImageButtonSearch.Attributes.Add("onmouseover", "src='Styles/Images/searchMO.png'");
            ImageButtonSearch.Attributes.Add("onmouseout", "src='Styles/Images/search.png'");

            ImageButtonRank.Attributes.Add("onmouseover", "src='Styles/Images/rankMO.png'");
            ImageButtonRank.Attributes.Add("onmouseout", "src='Styles/Images/rank.png'");

            ImageButtonAdvertisement.Attributes.Add("onmouseover", "src='Styles/Images/AdvertisementsMO.png'");
            ImageButtonAdvertisement.Attributes.Add("onmouseout", "src='Styles/Images/Advertisements.png'");
        }

        protected void ImageButtonUser_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ManageUser.aspx");
        }

        protected void ImageButtonCountry_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ManageCountry.aspx");
        }

        protected void ImageButtonCity_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ManageCity.aspx");
        }

        protected void ImageButtonApprove_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ApprovePost.aspx");
        }

        protected void ImageButtonCategory_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("SetupCategory.aspx");
        }

        protected void ImageButtonSearch_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Home.aspx?action="+"view");
        }

        protected void ImageButtonRank_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Rank.aspx");
        }

       

        protected void ImageButtonAdvertisement_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("UploadAdvertisement.aspx");
        }


    }
}