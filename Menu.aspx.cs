using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace QuickBites
{
	public partial class Menu : System.Web.UI.Page
	{
        private readonly string connectionString = WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;
        private int currentCategoryId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("~/Login.aspx?returnUrl=Menu.aspx");
                    return;
                }

                LoadCategories();
                LoadProducts(0);
                //UpdateCartCount();
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryId, Name FROM Categories ORDER BY Name";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                ddlCategories.DataSource = cmd.ExecuteReader();
                ddlCategories.DataTextField = "Name";
                ddlCategories.DataValueField = "CategoryId";
                ddlCategories.DataBind();
            }
        }

        private void LoadProducts(int categoryId)
        {
            string query = "SELECT ProductId, Name, Description, Price FROM Products WHERE IsActive = 1";
            if (categoryId > 0) query += " AND CategoryId = @CategoryId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                if (categoryId > 0) cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                con.Open();
                rptProducts.DataSource = cmd.ExecuteReader();
                rptProducts.DataBind();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx?returnUrl=Menu.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");

            int productId = Convert.ToInt32(btn.CommandArgument);
            int quantity = Convert.ToInt32(txtQuantity.Text);

            // Check if item already exists in cart
            string checkQuery = "SELECT Quantity FROM CartItems WHERE UserId = @UserId AND ProductId = @ProductId";
            int existingQuantity = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(checkQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null) existingQuantity = Convert.ToInt32(result);
            }

            // Get product price
            decimal price = 0;
            string priceQuery = "SELECT Price FROM Products WHERE ProductId = @ProductId";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(priceQuery, con);
                cmd.Parameters.AddWithValue("@ProductId", productId);
                con.Open();
                price = Convert.ToDecimal(cmd.ExecuteScalar());
            }

            if (existingQuantity > 0)
            {
                // Update existing item
                string updateQuery = "UPDATE CartItems SET Quantity = Quantity + @Quantity WHERE UserId = @UserId AND ProductId = @ProductId";
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(updateQuery, con);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            else
            {
                // Add new item
                string insertQuery = @"
                    INSERT INTO CartItems (UserId, ProductId, Quantity, Price)
                    VALUES (@UserId, @ProductId, @Quantity, @Price)";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(insertQuery, con);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);
                    cmd.Parameters.AddWithValue("@Price", price);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            //UpdateCartCount();
        }

        //private void UpdateCartCount()
        //{
        //    if (Session["UserId"] == null) return;

        //    int userId = Convert.ToInt32(Session["UserId"]);
        //    string query = "SELECT SUM(Quantity) FROM CartItems WHERE UserId = @UserId";

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        SqlCommand cmd = new SqlCommand(query, con);
        //        cmd.Parameters.AddWithValue("@UserId", userId);
        //        con.Open();
        //        object result = cmd.ExecuteScalar();
        //        cartCount.InnerText = (result != DBNull.Value) ? result.ToString() : "0";
        //    }
        //}

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");
            txtQuantity.Text = (Convert.ToInt32(txtQuantity.Text) + 1).ToString();
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");
            int qty = Convert.ToInt32(txtQuantity.Text);
            if (qty > 1) txtQuantity.Text = (qty - 1).ToString();
        }

        protected void btnViewCart_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx?returnUrl=Menu.aspx");
                return;
            }
            Response.Redirect("Cart.aspx");
        }

        protected void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            currentCategoryId = Convert.ToInt32(ddlCategories.SelectedValue);
            LoadProducts(currentCategoryId);
        }
    }
}