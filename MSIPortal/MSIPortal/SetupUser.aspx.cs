using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity.Validation;
using System.Text.RegularExpressions;

namespace MSIPortal
{
    public partial class SetupUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ClearMessagePanel();
                this.LoadCity();
                txtPassword.Attributes["type"] = "password";
                txtConfirmPassword.Attributes["type"] = "password";
            }
        }

        protected void LoadCity() 
        {

            MSIPortalContext ctx = new MSIPortalContext();
            ddlCity.DataSource = ctx.LU_tbl_City.ToList<LU_tbl_City>();
            ddlCity.DataTextField = "CityName";
            ddlCity.DataValueField = "CityID";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("Select One", "0"));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            this.ClearMessagePanel();          
          
            if(IsValid())
            {

                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    try
                    {
                        // Setup User
                        tbl_User user = new tbl_User();
                        user.UserID = Guid.NewGuid();
                        user.LoginName = txtEmail.Text.Trim();
                        user.FirstName = txtFirstName.Text.Trim();
                        user.LastName = txtLastName.Text.Trim();
                        user.RoleID = ddlUserType.SelectedValue;
                        user.CityID = ddlCity.SelectedValue;
                        user.IsActive = true;
                        user.EditUser = ((tbl_User)Session["User"]).UserID;
                        user.EditDate = DateTime.Now;

                        //Setup Password
                        tbl_UserPassword pass = new tbl_UserPassword();
                        pass.UserID = user.UserID;
                        pass.Password = txtPassword.Text.Trim();
                        pass.EditUser = ((tbl_User)Session["User"]).UserID;
                        pass.EditDate = DateTime.Now;

                        ctx.tbl_User.Add(user);
                        ctx.tbl_UserPassword.Add(pass);
                        ctx.SaveChanges();
                        this.ClearForm();
                        lblSuccessMessage.Text = "User created successfully.";
                        lblErrorMessage.Text = string.Empty;
                        MessagePanel.Visible = true;
                        txtEmail.Focus();
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


                    }// End of Catch
                }
               
            }
            

     

        }

        private bool IsValid() 
        {     
            
            
            if (txtPassword.Text.Trim() != txtConfirmPassword.Text.Trim()) 
            {
                lblErrorMessage.Text = "Password miss match.";
                MessagePanel.Visible = true;
                return false;
            }


            if (txtEmail.Text != string.Empty)
            {
                using (MSIPortalContext ctx = new MSIPortalContext())
                {
                    var user = from u in ctx.tbl_User where u.LoginName.Trim() == txtEmail.Text.Trim() select u;
                    List<tbl_User> list = user.ToList<tbl_User>();
                    if (list.Count > 0)
                    {
                        lblErrorMessage.Text = "User already exist";
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

        private void ClearMessagePanel() 
        {

            lblSuccessMessage.Text = string.Empty;
            lblErrorMessage.Text = string.Empty;          

        }

        private void ClearForm() 
        {
            this.txtEmail.Text = string.Empty;
            this.txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            ddlCity.SelectedValue = "0";
            ddlUserType.SelectedValue = "0";
        
        }

      
       
    }
}