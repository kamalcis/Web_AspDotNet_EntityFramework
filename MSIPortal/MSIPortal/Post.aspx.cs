using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.Linq;
using System.Data.Entity.Validation;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Net;


namespace MSIPortal
{
    public partial class Post : System.Web.UI.Page
    {

        #region PageLoadRegion
        protected void Page_Load(object sender, EventArgs e)   
        {

          
          
            if (!Page.IsPostBack)
            {
                this.FillCategoryDropDownBox();
                rdoCommonService.Checked = true;         
                
                this.FillUserLocation();
                this.ClearMessagePanel();
                this.FillCommonCountry();
               // this.FillCommonCity();

                //if User Is Logged in Fill the About U section 
                tbl_User user = (tbl_User)Session["User"];
                if (user == null)
                {
                    //FillAboutYouSecttion(user);   
                    PanelAboutYou.Visible = true;

                }
                 ddlCommonCountry.Focus();
                txtPassword.Attributes["type"] = "password";
                txtConfirmPassword.Attributes["type"] = "password";
                
            }
            

           

        }
        #endregion PageLoadRegion

        #region UtilityPrivateMethodsRegion
        //***************UTILITY PRIATE METHODS*************
      
        private void FillCategoryDropDownBox()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_Category> categoryListRoot = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == Convert.ToString("0000")).ToList<LU_tbl_Category>();

           
            foreach (LU_tbl_Category rootCategory in categoryListRoot)
            {

                ddlCategory.Items.Add(rootCategory.CategoryName);                
                var listItem = ddlCategory.Items.FindByText(rootCategory.CategoryName);
                listItem.Attributes["disabled"] = "disabled";
                listItem.Attributes.Add("style", "font-weight: bold");


                List<LU_tbl_Category> catListNodeWise = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == rootCategory.CategoryID.ToString()).ToList<LU_tbl_Category>();
                foreach (LU_tbl_Category cat in catListNodeWise)
                {
                    string indentSize = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    string strDisplayName = HttpUtility.HtmlDecode(indentSize) + cat.CategoryName;
                    ddlCategory.Items.Add(new ListItem(strDisplayName,cat.CategoryID));
                    
                }


            }

           

            ddlCategory.Items.Insert(0, new ListItem("Select One", "0"));
        }



        private void FillCommonCountry()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_Country> lstCity = ctx.LU_tbl_Country.ToList<LU_tbl_Country>();

            ddlCommonCountry.DataSource = lstCity;
            ddlCommonCountry.DataValueField = "CountryID";
            ddlCommonCountry.DataTextField = "CountryName";
            ddlCommonCountry.DataBind();
            ddlCommonCountry.Items.Insert(0, new ListItem("Select One", "0"));

        }


        private void FillCommonCity(string CountryId)
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_City> lstCity = ctx.LU_tbl_City.Where(c=> c.CountryID == CountryId).ToList<LU_tbl_City>();

            ddlCommonCity.DataSource = lstCity;
            ddlCommonCity.DataValueField = "CityID";
            ddlCommonCity.DataTextField = "CityName";
            ddlCommonCity.DataBind();
            ddlCommonCity.Items.Insert(0, new ListItem("Select One", "0"));

        }

      

      

        private void FillUserLocation()
        {
            MSIPortalContext ctx = new MSIPortalContext();
            List<LU_tbl_City> lstLocation = ctx.LU_tbl_City.ToList<LU_tbl_City>();

            ddlUserLocation.DataSource = lstLocation;
            ddlUserLocation.DataValueField = "CityID";
            ddlUserLocation.DataTextField = "CityName";
            ddlUserLocation.DataBind();
            ddlUserLocation.Items.Insert(0, new ListItem("Select", "0"));

        }

        private bool IsValid() 
        {


            //========User Email Validation
            if (this.txtCommonProviderEmil.Text.Trim() != string.Empty)
            {

                Regex re = new Regex(@"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$",
                 RegexOptions.IgnoreCase);
                bool flag = re.IsMatch(this.txtCommonProviderEmil.Text.Trim());
                if (flag == false)
                {

                    this.lblErrorMessage.Text = "Provider email address is invalid.";
                    this.txtCommonProviderEmil.BackColor = System.Drawing.Color.YellowGreen;
                    this.MessagePanel.Visible = true;
                    return false;
                }
                else
                {

                    this.txtCommonProviderEmil.BackColor = System.Drawing.Color.White;
                }

            }         
            
            
            //========User Email Validation
            if (this.txtUserEmail.Text.Trim() != string.Empty) {

                Regex re = new Regex(@"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$",
                 RegexOptions.IgnoreCase);
                bool flag =  re.IsMatch(this.txtUserEmail.Text.Trim());
                if (flag == false)
                {

                    this.lblErrorMessage.Text = "User email address is invalid.";
                    this.MessagePanel.Visible = true;
                    return false;
                }
            
            }           

            //Password validation========================
            if (this.txtPassword.Text.Trim() != string.Empty)
            {
                if (txtPassword.Text.Length < 4)
                {
                    this.lblErrorMessage.Text = "Password must be greater than 3 digits.";
                    this.MessagePanel.Visible = true;
                    return false;
                }
            }
            
            //Confirm Password Validation=============
            if (this.txtPassword.Text.Trim() != this.txtConfirmPassword.Text.Trim()) {

                this.lblErrorMessage.Text = "Password does not matched.";
                this.MessagePanel.Visible = true;
                return false;
            }

           

            return true;
        }

        private void ClearMessagePanel() 
        {

            this.MessagePanel.Visible = true;
            this.lblErrorMessage.Text = string.Empty;
            this.lblSuccessMessage.Text = string.Empty;
        }

        private void ClearForm() 
        {
            ddlCategory.SelectedValue = "0";
            rdoCommonService.Checked = true;
            txtCommonProviderFirstName.Text = string.Empty;
            txtCommonProviderLastName.Text = string.Empty;
            txtCommonProviderAddress.Text = string.Empty;
            txtCommonProviderEmil.Text = string.Empty;
            txtCommonProviderPhone.Text = string.Empty;
            txtCommonPostingTitle.Text = string.Empty;
            txtCommonPostingDescription.Text = string.Empty;
           
            ddlCommonCity.SelectedValue = "0";            
            ddlCommonCountry.SelectedValue = "0";
            ddlCommonCity.Items.Clear();
           // commonImageUpload.PostedFile.FileName = string.Empty;


            //About You
            txtUserEmail.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            txtUserFirstlName.Text = string.Empty;
            txtUserLastName.Text = string.Empty;
            ddlUserLocation.SelectedValue = "0";

            txtUserEmail.Enabled = true;
            txtPassword.Enabled = true;
            txtConfirmPassword.Enabled = true;
            txtUserFirstlName.Enabled = true;
            txtUserLastName.Enabled = true;
            ddlUserLocation.Enabled = true;
           
             
           
            
        }

        private void FillAboutYouSecttion(tbl_User user) 
        {

           
            tbl_UserPassword pass = FindPasswordByUserId(user.UserID).FirstOrDefault<tbl_UserPassword>();
            txtUserEmail.Text = user.LoginName.Trim();
            txtPassword.Text = pass.Password.Trim();
            txtConfirmPassword.Text = pass.Password.Trim();
            txtUserFirstlName.Text = user.FirstName.Trim();
            txtUserLastName.Text = user.LastName.Trim();
            ddlUserLocation.SelectedValue = user.CityID.Trim();
          
            
            //Disable Controls
            txtUserEmail.Enabled = false;
            txtPassword.Enabled = false;
            txtConfirmPassword.Enabled = false;
            txtUserFirstlName.Enabled = false;
            txtUserLastName.Enabled = false;
            ddlUserLocation.Enabled = false;
            lblUserEmailValidation.Text = string.Empty;
          
        }

        private List<tbl_User> FindUserByEmailAndPassword()
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var user = from u in ctx.tbl_User
                           join p in ctx.tbl_UserPassword on u.UserID equals p.UserID 
                           where u.LoginName == txtUserEmail.Text.Trim() && p.Password == txtPassword.Text.Trim()
                           select u;
                return user.ToList<tbl_User>();
            }
        
        }

        private List<tbl_UserPassword> FindPasswordByUserId(Guid userId)
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var pass = from 
                            p in ctx.tbl_UserPassword where  p.UserID == userId select p;
                return pass.ToList<tbl_UserPassword>();
            }

        }

        private List<tbl_User> FindUserByEmailOnly()
        {
            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var user = from u in ctx.tbl_User                           
                           where u.LoginName == txtUserEmail.Text.Trim() select u;
                return user.ToList<tbl_User>();
            }

        }
       
        #endregion UtilityPrivateMethodsRegion

        #region ButtonEventsRegion


        //[System.Web.Services.WebMethod]
        //public static string GetCurrentTime(string name)
        //{

        //    //if (this.FindUserByEmailAndPassword() != null && this.FindUserByEmailAndPassword().Count > 0)
        //    //{
        //    //    tbl_User user = FindUserByEmailAndPassword().FirstOrDefault<tbl_User>();
        //    //    FillAboutYouSecttion(user);
        //    //    commonImageUpload.Focus();
        //    //}
        //    //else
        //    //{
        //    //    //Enabled The controls
        //    //    txtConfirmPassword.Enabled = true;
        //    //    txtUserFirstlName.Enabled = true;
        //    //    txtUserLastName.Enabled = true;

        //    //    ddlUserLocation.Enabled = true;

        //    //    //Set Empty Value
        //    //    txtConfirmPassword.Text = string.Empty;
        //    //    txtUserFirstlName.Text = string.Empty;
        //    //    txtUserLastName.Text = string.Empty;
        //    //    ddlUserLocation.SelectedValue = "0";
        //    //    txtConfirmPassword.Focus();



        //    //}         

    
        //}


        [System.Web.Services.WebMethod]
        public static string[] ReturnUserData(string email,string password)
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                var user = from u in ctx.tbl_User
                           join p in ctx.tbl_UserPassword on u.UserID equals p.UserID
                           where u.LoginName == email && p.Password == password
                           select u;
                tbl_User objUser =  user.FirstOrDefault<tbl_User>();
                if (objUser != null)
                {
                    string[] names = new string[4] { password,objUser.FirstName,objUser.LastName,objUser.CityID };
                    return names;
                }
                else {

                    return null;
                }
                
            }

            
        }


        private void SavePost() 
        {
            ClearMessagePanel();
            using (MSIPortalContext ctx = new MSIPortalContext())
            {
                try
                {
                    tbl_Post post = new tbl_Post();
                    tbl_User user = new tbl_User();
                    tbl_UserPassword password = new tbl_UserPassword();

                    //===========Initialize the User Table
                    if (Session["User"] != null)
                    {
                        user = (tbl_User)Session["User"];
                    }
                    else if (FindUserByEmailAndPassword().Count > 0)
                    {
                        user = FindUserByEmailAndPassword().FirstOrDefault<tbl_User>();
                    }
                    else if (FindUserByEmailAndPassword().Count == 0) // If Existing User but not Logged In  [Eaml&Password Count May be 0]
                    {


                        if (FindUserByEmailOnly().Count == 0) // Insert only if this email is completely new [Email count may be greater than 0]
                        {
                            //Set User 
                            user = new tbl_User();
                            user.UserID = Guid.NewGuid();
                            user.LoginName = this.txtUserEmail.Text.Trim();
                            user.FirstName = this.txtUserFirstlName.Text.Trim();
                            user.LastName = this.txtUserLastName.Text.Trim();
                            user.RoleID = "02"; // Ordinary User
                            user.CityID = ddlUserLocation.SelectedValue;
                            user.IsActive = true;
                            user.EditUser = user.UserID;
                            user.EditDate = DateTime.Now;

                            //Set Password
                            password.UserID = user.UserID;
                            password.Password = txtPassword.Text.Trim();
                            password.EditUser = user.UserID;
                            password.EditDate = DateTime.Now;

                            //Add to Context
                            ctx.tbl_User.Add(user);
                            ctx.tbl_UserPassword.Add(password);

                        }
                        else
                        {
                            MessagePanel.Visible = true;
                            txtUserEmail.Focus();
                            lblUserEmailValidation.Text = "*";
                            lblErrorMessage.Text = "Already registered email";
                            lblSuccessMessage.Visible = false;
                            return; // Stop Inserting any Single Record

                        }


                    }

                    //============Initialize Post Table
                    post.PostID = Guid.NewGuid();
                    post.CategoryID = ddlCategory.SelectedValue;
                    post.CityID = ddlCommonCity.SelectedValue;


                    if (rdoCommonSales.Checked)
                    {
                        post.PSTID = "001";
                    }
                    else
                    {
                        post.PSTID = "002";
                    }

                    post.PostTitle = this.txtCommonPostingTitle.Text.Trim();
                    post.PostDescription = this.txtCommonPostingDescription.Text.Trim();



                    if (commonImageUpload.PostedFile.FileName != string.Empty)
                    {
                        commonImageUpload.SaveAs(Server.MapPath("~/imageupload/" + post.PostID + ".jpg"));
                        post.ImageUrl = "/imageupload/" + post.PostID + ".jpg";
                    }
                    else
                    {
                        post.ImageUrl = "/Styles/images/" + "no_image.jpg";

                    }



                    post.PostingUserID = user.UserID;
                    post.ProviderFirstName = txtCommonProviderFirstName.Text.Trim();
                    post.ProviderLastName = txtCommonProviderLastName.Text.Trim();
                    post.ProviderAddress = txtCommonProviderAddress.Text.Trim();
                    post.ProviderEmail = txtCommonProviderEmil.Text.Trim();
                    post.ProviderPhoneNo = txtCommonProviderPhone.Text.Trim();
                    post.Approved = false;
                    post.Rank = 999; // Default value to make sure out of rank
                    post.EditUser = user.UserID;
                    post.EditDate = DateTime.Now;

                    ctx.tbl_Post.Add(post);
                    ctx.SaveChanges();
                    //---------------After Successful Save Do the following operation
                    MessagePanel.Visible = true;
                    lblSuccessMessage.Visible = true;
                    lblSuccessMessage.Text = "Your posting is successful!";
                    //this.SendConfirmationEmail();
                    lblUserEmailValidation.Text = string.Empty;
                    this.ClearForm();
                    ddlCommonCountry.Focus();
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
                    Response.Write(Ex.ToString());

                }// End of Catch

            }// End of Using
            
        
        
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
                       

                this.SavePost();         
           

         }// End of Method


        public void SendConfirmationEmail() 
        {

            string body = string.Empty;
            if (PanelAboutYou.Visible == true)
            {
                body = "Your post has been submitted for approval. You have already been registered with us. <br/>Your User name:" + txtUserEmail.Text.Trim() +
                               "<br/>Your password: " + txtPassword.Text.Trim();
            }
            else {

                body = "Your post has been submitted for approval";
            }

            string subject = "Confirmation of your post.";
            try
            {

                var client = new SmtpClient("smtp.gmail.com", 587)
                {
                    Credentials = new NetworkCredential("posting.microcomp@gmail.com", "posting2014"),
                    EnableSsl = true
                };
                client.Send("posting.microcomp@gmail.com", txtUserEmail.Text.Trim(), subject, body);                

            }
            catch (Exception ex)
            {

                
            }
        
        }

        //protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlCategory.SelectedItem.Text.Trim() == "Cars")
        //    {
        //        //CarPanel.Visible = true;
        //        //CommonPanel.Visible = false;   // Common Panel Visible in all cases currently. Later on may be changed

        //        //CarPanel.Visible = false;
        //        CommonPanel.Visible = true;
        //        this.FillCommonCurrency();
        //        this.FillCommonCity();
        //    }
        //    else if (ddlCategory.SelectedItem.Value == "0")
        //    {
        //        this.CommonPanel.Visible = false;
        //    }
        //    else
        //    {
        //        //CarPanel.Visible = false;
        //        CommonPanel.Visible = true;
        //        this.FillCommonCurrency();
        //        this.FillCommonCity();



        //    }

        //}

        protected void ddlCommonCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.FillCommonCity(ddlCommonCountry.SelectedValue);
            lblSuccessMessage.Text = string.Empty;
        }

        protected void txtPassword_TextChanged(object sender, EventArgs e)
        {
            
           
            if (this.FindUserByEmailAndPassword() != null && this.FindUserByEmailAndPassword().Count > 0)
            {
                tbl_User user = FindUserByEmailAndPassword().FirstOrDefault<tbl_User>();
                FillAboutYouSecttion(user);                
                commonImageUpload.Focus();
            }
            else
            {
                //Enabled The controls
                txtConfirmPassword.Enabled = true;
                txtUserFirstlName.Enabled = true;
                txtUserLastName.Enabled = true;

                ddlUserLocation.Enabled = true;
              
               
                //Set Empty Value
                txtConfirmPassword.Text = string.Empty;
                txtUserFirstlName.Text = string.Empty;
                txtUserLastName.Text = string.Empty;
                ddlUserLocation.SelectedValue = "0";            
               
                txtConfirmPassword.Focus();

               

            }
        }
        #endregion ButtonEventsRegion


     



    }
}