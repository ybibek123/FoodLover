using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickBites
{
	public partial class MyOrders : System.Web.UI.Page
	{
        private readonly string connectionString = WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx?returnUrl=MyOrders.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = @"
                SELECT OrderId, OrderDate, TotalAmount, Status
                FROM Orders
                WHERE UserId = @UserId
                ORDER BY OrderDate DESC";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();

                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }
    }
}