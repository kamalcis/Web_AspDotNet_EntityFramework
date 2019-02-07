using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MSIPortal
{
    public partial class SetupCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                this.PopulateTree();
                this.BindSalesServiceDropDown();
            }

        }


        private void PopulateTree()
        {
           
                
                MSIPortalContext ctx = new MSIPortalContext();

                List<LU_tbl_Category> categoryListRoot = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == Convert.ToString("0000")).ToList<LU_tbl_Category>();

                TreeNode rootNode = new TreeNode("Root");
                rootNode.Value = "0000";
                TreeView1.Nodes.Clear(); 
                TreeView1.Nodes.Add(rootNode);
                
                foreach (LU_tbl_Category cat in categoryListRoot)
                {

                    TreeNode tn = new TreeNode(cat.CategoryName.ToString());
                    List<LU_tbl_Category> catListNodeWise = ctx.LU_tbl_Category.ToList<LU_tbl_Category>().Where(ct => ct.ParentCatID.Trim() == cat.CategoryID.ToString()).ToList<LU_tbl_Category>();

                    foreach (LU_tbl_Category catNode in catListNodeWise)
                    {
                        TreeNode childNode = new TreeNode(catNode.CategoryName);
                        childNode.Value = catNode.CategoryID;                       
                        tn.ChildNodes.Add(childNode);
                      
                    }
                    tn.Value = cat.CategoryID;
                    rootNode.ChildNodes.Add(tn);
                }

                rootNode.CollapseAll();                
        
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
            //TreeView1.SelectedNode = System.Drawing.Color.Green;
            //TreeView1.SelectedNode.ForeColor = System.Drawing.Color.White;

            TreeView1.SelectedNodeStyle.BackColor = System.Drawing.Color.Green;
            TreeView1.SelectedNodeStyle.ForeColor = System.Drawing.Color.White;
            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using(MSIPortalContext ctx = new MSIPortalContext())
            {
                var maxId = ctx.LU_tbl_Category.Select(c => c.CategoryID).Max(); // Select Max Id
                int newId = Convert.ToInt32(maxId) + 1;
                string newStringId = newId.ToString("D4");

                var count = ctx.LU_tbl_Category.Where(c => c.CategoryName.Trim() == txtCategiryName.Text.Trim()).Count(); // Count Based on given Category Name

                if (Convert.ToInt32(count) > 0) // Duplicacy Check
                {

                    lblError.Text = "Duplicate entry not allowed.";
                    lblSuccess.Text = string.Empty;
                    MessagePanel.Visible = true;
                }
                else
                {

                    if (TreeView1.SelectedNode == null)   // Validate if parent node is not selected
                    {
                        lblError.Text = "Parent node must be selected.";
                        lblSuccess.Text = string.Empty;
                        MessagePanel.Visible = true;
                        return;
                    }
                    
                    LU_tbl_Category category = new LU_tbl_Category();
                    category.CategoryID = newStringId;
                    category.ParentCatID = TreeView1.SelectedNode.Value.ToString();
                    category.CategoryName = txtCategiryName.Text.Trim();
                    category.PSTID = ddlSalesService.SelectedValue;
                    category.EditUser = Guid.NewGuid(); // Needs Modification Will Come from Login Session
                    category.EditDate = DateTime.Now;
                    ctx.LU_tbl_Category.Add(category);
                    ctx.SaveChanges();
                    lblSuccess.Text = "Record saved successfully";
                    txtCategiryName.Text = string.Empty;
                    ddlSalesService.SelectedValue = "000";
                    lblError.Text = string.Empty;
                    MessagePanel.Visible = true;
                    txtCategiryName.Focus();

                
                }
                
                
            }
            this.PopulateTree();
        }// End of Method Populate Tree


        protected void BindSalesServiceDropDown() 
        {

            using (MSIPortalContext ctx = new MSIPortalContext())
            {

                List<LU_tbl_ProductServiceType> listPs = ctx.LU_tbl_ProductServiceType.ToList<LU_tbl_ProductServiceType>();
                ddlSalesService.DataSource = listPs;
                ddlSalesService.DataTextField = "ProductServiceType";
                ddlSalesService.DataValueField = "PSTypeID";
                ddlSalesService.DataBind();

                ddlSalesService.Items.Insert(0, new ListItem("Select One","000"));

            }
        
        }






    }
}