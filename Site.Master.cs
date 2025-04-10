using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickBites
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserRole"] == null)
                {
                    GuestNavbar.Visible = true;
                    UserNavbar.Visible = false;
                    AdminNavbar.Visible = false;
                }
                else if (Session["UserRole"].ToString() == "Customer")
                {
                    GuestNavbar.Visible = false;
                    UserNavbar.Visible = true;
                    AdminNavbar.Visible = false;
                }
                else if (Session["UserRole"].ToString() == "Admin")
                {
                    GuestNavbar.Visible = false;
                    UserNavbar.Visible = false;
                    AdminNavbar.Visible = true;
                }
            }
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}