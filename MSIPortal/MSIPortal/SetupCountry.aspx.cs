using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MSIPortal
{
    public partial class SetupCountry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

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
                        lblSuccessMessage.Text = "Country added successfully";
                        lblErrorMessage.Text = string.Empty;
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
                        
            } // End Block 

            return true;
        }           
            
      


    }
}