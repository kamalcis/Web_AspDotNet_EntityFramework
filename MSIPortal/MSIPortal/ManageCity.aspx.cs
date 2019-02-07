using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MSIPortal
{
    public partial class ManageCity : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                this.BindGrid();
                TabPanelEditCity.Visible = false;
            }
        }

        #region TabCreateCity
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {

                using (MSIPortalContext ctx = new MSIPortalContext())
                {

                    try
                    {
                        LU_tbl_City city = new LU_tbl_City();
                        var maxId = ctx.LU_tbl_City.Select(c => c.CityID).Max(); // Select Max Id
                        int newId = Convert.ToInt32(maxId) + 1;
                        string newStringId = newId.ToString("D3");

                        city.CityID = newStringId;
                        city.CityName = txtCity.Text.Trim();
                        city.EditUser = ((tbl_User)Session["User"]).UserID;
                        city.EditDate = DateTime.Now;

                        ctx.LU_tbl_City.Add(city);
                        ctx.SaveChanges();
                        cpSuccessMessage.Text = "City added successfully";
                        this.BindGrid();
                        cpErrorMessage.Text = string.Empty;
                        txtCity.Text = string.Empty;
                        txtCity.Focus();
                        MessagePanel.Visible = true;
                    }
                    catch (Exception ex)
                    {


                    }
                }
            }



        }
        private bool IsValid()
        {

            if (txtCity.Text != string.Empty)
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    var city = from c in ctx.LU_tbl_City where c.CityName.Trim() == txtCity.Text.Trim() select c;
                    List<LU_tbl_City> list = city.ToList<LU_tbl_City>();
                    if (list.Count > 0)
                    {
                        cpErrorMessage.Text = "Duplicate city name";
                        cpSuccessMessage.Text = string.Empty;
                        MessagePanel.Visible = true;
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }

            } // End Block 

            return true;
        }




        #endregion TabCreateCity

        #region TabListCity
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
            TabContainer1.ActiveTabIndex = 1;
        }




        private void BindGrid()
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                //LU_tbl_Country country = (LU_tbl_Country)Session["Country"];

                //var list = from c in ctx.LU_tbl_Country where c.CountryID == country.CountryID orderby c.EditDate descending select c;

                List<LU_tbl_City> list = ctx.LU_tbl_City.ToList<LU_tbl_City>();
                if (list != null)
                {
                    GridView1.DataSource = list;
                    GridView1.DataBind();
                }
            }
        }




        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            TabPanelEditCity.Visible = true;
            TabContainer1.ActiveTabIndex = 3;
            if (e.CommandName == "Modify")
            {

                string argument = e.CommandArgument.ToString();
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    string cityId = argument;
                    //var city = from c in ctx.LU_tbl_City where c.CityName == cityId select c;
                    //LU_tbl_City objCity = city.ToList<LU_tbl_City>().FirstOrDefault<LU_tbl_City>();
                    LU_tbl_City objCity = ctx.LU_tbl_City.Where(c => c.CityID == cityId).FirstOrDefault();
                    Session["LU_tbl_City_ToEdit"] = objCity;




                    this.txtCityForEdit.Text = objCity.CityName;
                    TabPanelEditCity.Visible = true;
                    this.lblSuccessMessage.Text = string.Empty;
                    this.lblErrorMessage.Text = string.Empty;
                }
            }
        }



        #endregion TabListCountry




        #region TabEditCity
        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            if (IsValidUpdate())
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {

                    LU_tbl_City cityToBeUpdate = (LU_tbl_City)Session["LU_tbl_City_ToEdit"];

                    cityToBeUpdate.CityName = txtCityForEdit.Text;
                    if (((tbl_User)Session["User"]) != null)
                    {
                        cityToBeUpdate.EditUser = ((tbl_User)Session["User"]).UserID;  // User 
                    }
                    cityToBeUpdate.EditDate = DateTime.Now;


                    ctx.LU_tbl_City.Attach(cityToBeUpdate);
                    ctx.Entry(cityToBeUpdate).State = System.Data.Entity.EntityState.Modified;
                    ctx.SaveChanges();

                    this.BindGrid();
                    TabContainer1.ActiveTabIndex = 1;
                    TabPanelEditCity.Visible = false;

                }
            }


        }


        private bool IsValidUpdate()
        {

            if (txtCityForEdit.Text != string.Empty)
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    var city = from c in ctx.LU_tbl_City where c.CityName.Trim() == txtCityForEdit.Text.Trim() select c;
                    List<LU_tbl_City> list = city.ToList<LU_tbl_City>();
                    if (list.Count > 0)
                    {
                        lblErrorMessage.Text = "Duplicate city name";
                        lblSuccessMessage.Text = string.Empty;
                        MessagePanel.Visible = true;
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }

            }
            else
            {
                lblErrorMessage.Text = "City name can not be empty.";
                return false;
            }

            return true;
        }
        #endregion TabEditCountry

    }
}