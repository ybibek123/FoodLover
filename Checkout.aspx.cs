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
	public partial class Checkout : System.Web.UI.Page
	{
        private readonly string connectionString = WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx?returnUrl=Checkout.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrderSummary();
            }
        }

        private void LoadOrderSummary()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = @"
                SELECT p.Name, ci.Quantity, ci.Price, (ci.Quantity * ci.Price) AS Subtotal
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

                gvOrderSummary.DataSource = dt;
                gvOrderSummary.DataBind();
            }

            // Calculate total
            string totalQuery = "SELECT SUM(Quantity * Price) FROM CartItems WHERE UserId = @UserId";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(totalQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                object result = cmd.ExecuteScalar();
                lblTotal.Text = (result != DBNull.Value) ? Convert.ToDecimal(result).ToString("C") : "₹0.00";
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            decimal totalAmount = 0;
            string deliveryAddress = $"{txtFullName.Text}, {txtPhone.Text}, {txtAddress.Text}";
            string paymentMethod = rblPaymentMethod.SelectedValue;
            string instructions = txtInstructions.Text;

            // Calculate total amount
            string totalQuery = "SELECT SUM(Quantity * Price) FROM CartItems WHERE UserId = @UserId";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(totalQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                totalAmount = Convert.ToDecimal(cmd.ExecuteScalar());
            }

            // Create order
            int orderId;
            string orderQuery = @"
                INSERT INTO Orders (UserId, TotalAmount, Status, DeliveryAddress, PaymentMethod, SpecialInstructions)
                VALUES (@UserId, @TotalAmount, 'Pending', @DeliveryAddress, @PaymentMethod, @Instructions);
                SELECT SCOPE_IDENTITY();";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(orderQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                cmd.Parameters.AddWithValue("@DeliveryAddress", deliveryAddress);
                cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                cmd.Parameters.AddWithValue("@Instructions", instructions);
                con.Open();
                orderId = Convert.ToInt32(cmd.ExecuteScalar());
            }

            // Move cart items to order items
            string moveItemsQuery = @"
                INSERT INTO OrderItems (OrderId, ProductId, Quantity, UnitPrice)
                SELECT @OrderId, ProductId, Quantity, Price 
                FROM CartItems 
                WHERE UserId = @UserId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(moveItemsQuery, con);
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Clear cart
            string clearCartQuery = "DELETE FROM CartItems WHERE UserId = @UserId";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(clearCartQuery, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Redirect to order confirmation
            Response.Redirect($"OrderConfirmation.aspx?orderId={orderId}");
        }
    }
}