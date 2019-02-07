using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity.Validation;

namespace MSIPortal
{
    public partial class SetupCity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) 
            {
                MSIPortalContext ctx = new MSIPortalContext();

                ddlCountry.DataSource = ctx.LU_tbl_Country.ToList<LU_tbl_Country>();
                ddlCountry.DataTextField = "CountryName";
                ddlCountry.DataValueField = "CountryID";
                ddlCountry.DataBind();
                ddlCountry.Items.Insert(0,new ListItem("Select One","0"));
            }
        }

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
                        city.CountryID = ddlCountry.SelectedValue;
                        city.EditUser = ((tbl_User)Session["User"]).UserID;
                        city.EditDate = DateTime.Now;

                        ctx.LU_tbl_City.Add(city);
                        ctx.SaveChanges();
                        lblSuccessMessage.Text = "City added successfully";
                        lblErrorMessage.Text = string.Empty;
                        txtCity.Text = string.Empty;
                        ddlCountry.SelectedValue = "0";
                        ddlCountry.Focus();
                        MessagePanel.Visible = true;
                    }
                    catch (DbEntityValidationException dbEx)
                    {
                        foreach (var validationErrors in dbEx.EntityValidationErrors)
                        {
                            foreach (var validationError in validationErrors.ValidationErrors)
                            {
                                Trace.Write("Property: {0} Error: {1}" + validationError.PropertyName, validationError.ErrorMessage);
                            }
                        }
                    }
                    catch (Exception Ex)
                    {


                    }// End of
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
                        lblErrorMessage.Text = "Duplicate City name";
                        lblSuccessMessage.Text = string.Empty;
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
            
       

    }
}