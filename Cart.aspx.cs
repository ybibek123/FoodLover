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
	public partial class Cart : System.Web.UI.Page
	{
        private readonly string connectionString = WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx?returnUrl=Cart.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCartItems();
                CalculateTotal();
            }
        }

        private void LoadCartItems()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = @"
                SELECT ci.CartItemId, p.Name, ci.Quantity, ci.Price, (ci.Quantity * ci.Price) AS Subtotal
                FROM CartItems ci
                JOIN Products p ON ci.ProductId = p.ProductId
                WHERE ci.UserId = @UserId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();

                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                gvCart.DataSource = dt;
                gvCart.DataBind();
            }
        }

        private void CalculateTotal()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = "SELECT SUM(Quantity * Price) FROM CartItems WHERE UserId = @UserId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                object result = cmd.ExecuteScalar();
                lblTotal.Text = (result != DBNull.Value) ? Convert.ToDecimal(result).ToString("C") : "₹0.00";
            }
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int cartItemId = Convert.ToInt32(e.CommandArgument);
                int userId = Convert.ToInt32(Session["UserId"]);

                string query = "DELETE FROM CartItems WHERE CartItemId = @CartItemId AND UserId = @UserId";
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@CartItemId", cartItemId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadCartItems();
                CalculateTotal();
            }
            else if (e.CommandName == "Update")
            {
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
                int newQuantity = Convert.ToInt32(txtQuantity.Text);
                int cartItemId = Convert.ToInt32(e.CommandArgument);
                int userId = Convert.ToInt32(Session["UserId"]);

                string query = "UPDATE CartItems SET Quantity = @Quantity WHERE CartItemId = @CartItemId AND UserId = @UserId";
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Quantity", newQuantity);
                    cmd.Parameters.AddWithValue("@CartItemId", cartItemId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadCartItems();
                CalculateTotal();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx?returnUrl=Cart.aspx");
                return;
            }
            Response.Redirect("Checkout.aspx");
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Menu.aspx");
        }
    }
}