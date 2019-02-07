using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace MSIPortal
{
    public partial class UploadAdvertisement : System.Web.UI.Page
    {
        
        
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
               
                LoadLeftGrid();
                LoadRightGrid();


                if (Convert.ToInt32(Session["ActiveIndex"]) == 0)
                {
                    TabContainer1.ActiveTabIndex = 0;
                }
                else {

                    TabContainer1.ActiveTabIndex = 1;
                }
                
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {   
 

            string delImageUrl = Server.MapPath("~/ads_left/") +  e.CommandArgument.ToString().Substring(11);
            if (File.Exists(delImageUrl)) {

                File.Delete(delImageUrl);
            }
            this.LoadLeftGrid();

        }

      

        private void LoadLeftGrid()
        {

            this.RenameLeftSlider(); // First Rename all the Files
            
            string[] filesindirectory = Directory.GetFiles(Server.MapPath("~/ads_left"));
            List<String> images = new List<string>(filesindirectory.Count());

            foreach (string item in filesindirectory)
            {
                images.Add(String.Format("~/ads_left/{0}", System.IO.Path.GetFileName(item)));
            }

            GridView1.DataSource = images;
            GridView1.DataBind();
        
        }


        private void LoadRightGrid()
        {

            this.RenameRightSlider();
            string[] filesindirectory = Directory.GetFiles(Server.MapPath("~/ads_right"));
            List<String> images = new List<string>(filesindirectory.Count());

            foreach (string item in filesindirectory)
            {
                images.Add(String.Format("~/ads_right/{0}", System.IO.Path.GetFileName(item)));
            }

            GridView2.DataSource = images;
            GridView2.DataBind();

        }

        protected void btnLeftUpload_Click(object sender, EventArgs e)
        {
            

            if (fileUploadLeft.HasFile)
            {
                
                try
                {

                    if (fileUploadLeft.PostedFile.ContentType == "image/jpeg")
                    {
                        System.Drawing.Image imgFile = System.Drawing.Image.FromStream(fileUploadLeft.PostedFile.InputStream);
                        int width = Convert.ToInt32(imgFile.PhysicalDimension.Width);
                        int height = Convert.ToInt32(imgFile.PhysicalDimension.Height);
                        if (width == 170 && height == 350)
                        {
                            if (fileUploadLeft.PostedFile.ContentLength < 102400)
                            {
                                string filename = Path.GetFileName(fileUploadLeft.FileName);

                                if (!File.Exists(Server.MapPath("~/ads_left/") + filename))
                                {

                                    fileUploadLeft.SaveAs(Server.MapPath("~/ads_left/") + filename);
                                    StatusLabel.Text = "Upload status: File uploaded!";
                                    Session["ActiveIndex"] = 0;
                                    Response.Redirect("UploadAdvertisement.aspx");
                                    //this.LoadLeftGrid();
                                }
                                else
                                {
                                    StatusLabel.Text = "Upload status: File already exist with this name!";

                                }


                            }
                            else
                                StatusLabel.Text = "Upload status: The file has to be less than 100 kb!";
                        }
                        else
                            StatusLabel.Text = "Upload status: Image Width should be 170 and height should be 350 pixel!";
                    }
                    else
                        StatusLabel.Text = "Upload status: Only JPEG files are accepted!";
                    
                }
                catch (Exception ex)
                {
                    StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
            else
            {

                StatusLabel.Text = "Upload status: No files have been selected!";
            }

        }


        private void RenameLeftSlider()
        {     

            DirectoryInfo d = new DirectoryInfo(Server.MapPath("~/ads_left/"));//Assuming Test is your Folder
            FileInfo[] Files = d.GetFiles("*.*"); //Getting Text files
            List<string> listFileNames = new List<string>();
          
            int i = 1;
            foreach (FileInfo file in Files)
            {
                
                FileInfo info = new FileInfo(Server.MapPath("~/ads_left/") + file.Name);
                if (!File.Exists(Server.MapPath("~/ads_left/") + "ad" + i + ".jpg"))
                {
                    info.MoveTo(Server.MapPath("~/ads_left/") + "ad" + i + ".jpg");// move/rename it.
                }
                i++;
            }          
      
        
        }


        private void RenameRightSlider()
        {

            DirectoryInfo d = new DirectoryInfo(Server.MapPath("~/ads_right/"));//Assuming Test is your Folder
            FileInfo[] Files = d.GetFiles("*.*"); //Getting Text files
            List<string> listFileNames = new List<string>();

            int i = 1;
            foreach (FileInfo file in Files)
            {

                FileInfo info = new FileInfo(Server.MapPath("~/ads_right/") + file.Name);
                if (!File.Exists(Server.MapPath("~/ads_right/") + "ad" + i + ".jpg"))
                {
                    info.MoveTo(Server.MapPath("~/ads_right/") + "ad" + i + ".jpg");// move/rename it.
                }
                i++;
            }


        }

        protected void btnRightUpload_Click(object sender, EventArgs e)
        {
            if (fileUploadRight.HasFile)
            {
               

                try
                {


                    if (fileUploadRight.PostedFile.ContentType == "image/jpeg")
                    {
                        System.Drawing.Image imgFile = System.Drawing.Image.FromStream(fileUploadRight.PostedFile.InputStream);
                        int width = Convert.ToInt32(imgFile.PhysicalDimension.Width);
                        int height = Convert.ToInt32(imgFile.PhysicalDimension.Height);

                        if (width == 170 && height == 350)
                        {

                            if (fileUploadRight.PostedFile.ContentLength < 102400)
                            {
                                string filename = Path.GetFileName(fileUploadRight.FileName);
                                if (!File.Exists(Server.MapPath("~/ads_right/") + filename))
                                {
                                    fileUploadRight.SaveAs(Server.MapPath("~/ads_right/") + filename);
                                    StatusLabelRight.Text = "Upload status: File uploaded!";
                                    Session["ActiveIndex"] = 1;
                                    Response.Redirect("UploadAdvertisement.aspx");
                                    //this.LoadLeftGrid();
                                }
                                else
                                {
                                    StatusLabelRight.Text = "Upload status: File already exist with this name!";
                                }
                            }
                            else
                                StatusLabelRight.Text = "Upload status: The file has to be less than 100 kb!";
                        }
                        else
                            StatusLabelRight.Text = "Upload status: Image Width should be 170 and height should be 350 pixel!";
                    }
                    else
                        StatusLabelRight.Text = "Upload status: Only JPEG files are accepted!";
                  
                }
                catch (Exception ex)
                {
                    StatusLabelRight.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
            else
            {
                StatusLabelRight.Text = "Upload status: No files have been selected!";
            }
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            string delImageUrl = Server.MapPath("~/ads_right/") + e.CommandArgument.ToString().Substring(12);
            if (File.Exists(delImageUrl))
            {

                File.Delete(delImageUrl);
            }
            this.LoadRightGrid();
        }


        
       
       
    }
}