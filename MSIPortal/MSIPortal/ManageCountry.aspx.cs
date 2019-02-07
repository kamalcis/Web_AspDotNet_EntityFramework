using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MSIPortal
{
    public partial class ManageCountry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                this.BindGrid();
                TabPanelEditCountry.Visible = false;
            }
        }

        #region TabCreateCountry
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {

                using (MSIPortalContext ctx = new MSIPortalContext())
                {

                    try
                    {
                        LU_tbl_Country country = new LU_tbl_Country();
                        var maxId = ctx.LU_tbl_Country.Select(c => c.CountryID).Max(); // Select Max Id
                        int newId = Convert.ToInt32(maxId) + 1;
                        string newStringId = newId.ToString("D3");

                        country.CountryID = newStringId;
                        country.CountryName = txtCountry.Text.Trim();
                        country.EditUser = ((tbl_User)Session["User"]).UserID;
                        country.EditDate = DateTime.Now;

                        ctx.LU_tbl_Country.Add(country);
                        ctx.SaveChanges();
                        cpSuccessMessage.Text = "Country added successfully";
                        this.BindGrid();
                        cpErrorMessage.Text = string.Empty;
                        txtCountry.Text = string.Empty;
                        txtCountry.Focus();
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

            if (txtCountry.Text != string.Empty)
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    var country = from c in ctx.LU_tbl_Country where c.CountryName.Trim() == txtCountry.Text.Trim() select c;
                    List<LU_tbl_Country> list = country.ToList<LU_tbl_Country>();
                    if (list.Count > 0)
                    {
                        cpErrorMessage.Text = "Duplicate country name";
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
        



        #endregion TabCreateCountry

        #region TabListCountry
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
                //LU_tbl_Country country = (LU_tbl_Country)Session["Country"];

                //var list = from c in ctx.LU_tbl_Country where c.CountryID == country.CountryID orderby c.EditDate descending select c;

                List<LU_tbl_Country> list = ctx.LU_tbl_Country.ToList<LU_tbl_Country>();
                if (list != null)
                {
                    GridView1.DataSource = list;
                    GridView1.DataBind();
                }
            }
        }




        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            TabPanelEditCountry.Visible = true;
            TabContainer1.ActiveTabIndex = 3;
            if (e.CommandName == "Modify")
            {

                string argument = e.CommandArgument.ToString();
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    string countryId = argument;
                    var country = from c in ctx.LU_tbl_Country where c.CountryID == countryId select c;
                    LU_tbl_Country objCountry = country.ToList<LU_tbl_Country>().FirstOrDefault<LU_tbl_Country>();
                    Session["LU_tbl_Country_ToEdit"] = objCountry;


                   

                    this.txtCountryForEdit.Text = objCountry.CountryName;
                    TabPanelEditCountry.Visible = true;
                    this.lblSuccessMessage.Text = string.Empty;
                    this.lblErrorMessage.Text = string.Empty;
                }
            }
        }



        #endregion TabListCountry

        

      
        #region TabEditCountry
        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            if (IsValidUpdate())
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {

                    LU_tbl_Country countryToBeUpdate = (LU_tbl_Country)Session["LU_tbl_Country_ToEdit"];

                    countryToBeUpdate.CountryName = txtCountryForEdit.Text;
                    if (((tbl_User)Session["User"]) != null)
                    {
                        countryToBeUpdate.EditUser = ((tbl_User)Session["User"]).UserID;  // User 
                    }
                    countryToBeUpdate.EditDate = DateTime.Now;


                    ctx.LU_tbl_Country.Attach(countryToBeUpdate);
                    ctx.Entry(countryToBeUpdate).State = System.Data.Entity.EntityState.Modified;
                    ctx.SaveChanges();

                    this.BindGrid();
                    TabContainer1.ActiveTabIndex = 1;
                    TabPanelEditCountry.Visible = false;

                }
            }


        }


        private bool IsValidUpdate()
        {

            if (txtCountryForEdit.Text != string.Empty)
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    var country = from c in ctx.LU_tbl_Country where c.CountryName.Trim() == txtCountryForEdit.Text.Trim() select c;
                    List<LU_tbl_Country> list = country.ToList<LU_tbl_Country>();
                    if (list.Count > 0)
                    {
                        lblErrorMessage.Text = "Duplicate country name";
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
                lblErrorMessage.Text = "Country name can not be empty.";
                return false;
            }

            return true;
        }           
        #endregion TabEditCountry
    }
}