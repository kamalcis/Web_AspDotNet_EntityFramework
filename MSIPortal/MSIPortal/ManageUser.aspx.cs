using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity.Validation;
using System.Data.Entity;
using System.Data;

namespace MSIPortal
{
    public partial class ManageUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {   
                //=====Tab Create New User 
                ClearMessagePanel();
                this.LoadCity();
                txtPassword.Attributes["type"] = "password";
                txtConfirmPassword.Attributes["type"] = "password";
                //=====Tab User List

                //txtExistingPassword.Attributes["type"] = "password";
                //txtNewPassword.Attributes["type"] = "password";
                //txtConfirmNewPassword.Attributes["type"] = "password";
                
                this.BindGrid();
            }
        }

        #region TabUserList
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


                var list = (from u in ctx.tbl_User where u.RoleID == "001" select 
                                
                                
                    new { 
                    UserID = u.UserID,
                    LoginName = u.LoginName,
                    FirstName = u.FirstName,
                    LastName = u.LastName,
                    RoleId = u.RoleID,
                    EditDate = u.EditDate,
                    cityName = u.LU_tbl_City.CityName 
                    }).ToList();

                if (list != null)
                {

                    GridView1.DataSource = list;                   
                    GridView1.DataBind();
                }
            }
        }

        

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            
            GridView1.EditIndex = e.NewEditIndex;            
            this.BindGrid(); 


        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                    DropDownList ddList = (DropDownList)e.Row.FindControl("DropDownListRole");                  
                    if (ddList != null)
                    {
                        ddList.Items.Add(new ListItem("Select One", "0"));
                        ddList.Items.Add(new ListItem("Admin", "001"));
                        ddList.Items.Add(new ListItem("Ordinary", "002"));
                        ddList.DataBind();
                        ddList.SelectedValue = DataBinder.Eval(e.Row.DataItem, "RoleID").ToString();
                       
                    }
                  

            }
        }

       

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridViewRow row = GridView1.Rows[e.RowIndex];
            string loginName = row.Cells[0].Text;
            string roleId = ((DropDownList)(row.Cells[5].Controls[1])).SelectedValue;
            using (MSIPortalContext ctx = new MSIPortalContext()) {

                var varUser = from u in ctx.tbl_User where u.LoginName == loginName select u;
                tbl_User user = varUser.FirstOrDefault<tbl_User>();
                user.RoleID = roleId;
                user.EditUser = ((tbl_User)Session["User"]).UserID;
                ctx.Entry(user).State = EntityState.Modified;
                ctx.SaveChanges();               
            }


            this.BindGrid();
        }

        #endregion TabUserList

        #region TabCreateNewUser
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

            if (IsValid())
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
                        this.BindGrid();
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
                lblErrorMessage.Text = "Password & Confirm password does not match.";
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
        #endregion TabCreateNewUser

        #region TabChangePassword

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            tbl_User user = (tbl_User)Session["User"];
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                var pass = from p in ctx.tbl_UserPassword
                           where p.Password == txtExistingPassword.Text.Trim() && p.tbl_User.LoginName == user.LoginName
                           select p;
                tbl_UserPassword password = pass.FirstOrDefault<tbl_UserPassword>();

                if (password != null)
                {
                    if (txtNewPassword.Text.Trim() == txtConfirmNewPassword.Text.Trim())
                    {

                        password.Password = txtNewPassword.Text.Trim();
                        ctx.Entry(password).State = EntityState.Modified;
                        ctx.SaveChanges();
                        txtExistingPassword.Text = string.Empty;
                        txtNewPassword.Text = string.Empty;
                        txtConfirmNewPassword.Text = string.Empty;

                        cpSuccessMessage.Text = "Password changed successfully";
                        cpErrorMessage.Text = string.Empty;
                        txtExistingPassword.Focus();
                    }
                    else
                    {
                        cpSuccessMessage.Text = string.Empty;
                        cpErrorMessage.Text = "New password and confirm new password miss match.";
                    }
                }
                else
                {
                    cpSuccessMessage.Text = string.Empty;
                    cpErrorMessage.Text = "Provided password does not exist.";
                }
            }
        }

        protected void ClearChangePasswordScreen() 
        {

            txtNewPassword.Text = string.Empty;
            txtNewPassword.Text = string.Empty;
            txtConfirmNewPassword.Text = string.Empty;
        }
        #endregion TabChangePassword

      
        

       

       

       
       

 

    }
}