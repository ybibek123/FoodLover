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
	public partial class OrderDetails : System.Web.UI.Page
	{
        private string connectionString = WebConfigurationManager.ConnectionStrings["QuickBitesDB"].ConnectionString;
        private int orderId;
        private string orderStatus;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsUserAuthenticated())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["orderId"] != null && int.TryParse(Request.QueryString["orderId"], out orderId))
                {
                    LoadOrderDetails();
                }
                else
                {
                    ShowErrorAndRedirect("Invalid order specified.");
                }
            }
        }

        private bool IsUserAuthenticated()
        {
            return Session["UserId"] != null;
        }

        private int GetCurrentUserId()
        {
            return Convert.ToInt32(Session["UserId"]);
        }

        private void LoadOrderDetails()
        {
            DataTable orderData = GetOrderData();

            if (orderData.Rows.Count == 0)
            {
                ShowErrorAndRedirect("Order not found or you don't have permission to view it.");
                return;
            }

            DataRow order = orderData.Rows[0];
            orderStatus = order["Status"].ToString();

            // Display basic order info
            litOrderId.Text = order["OrderId"].ToString();
            litOrderDate.Text = Convert.ToDateTime(order["OrderDate"]).ToString("dd MMM yyyy hh:mm tt");
            litDeliveryAddress.Text = order["DeliveryAddress"].ToString();
            litPaymentMethod.Text = order["PaymentMethod"].ToString();
            litTotalAmount.Text = Convert.ToDecimal(order["TotalAmount"]).ToString("Rs.0.00");

            // Set status display
            litStatus.Text = orderStatus;
            litStatusClass.Text = orderStatus.ToLower();

            // Load order items
            DataTable itemsData = GetOrderItemsData();
            gvOrderItems.DataSource = itemsData;
            gvOrderItems.DataBind();

            // Configure dynamic elements
            ConfigureDynamicElements(order);
        }

        private DataTable GetOrderData()
        {
            string query = @"SELECT o.OrderId, o.OrderDate, o.DeliveryAddress, o.PaymentMethod, 
                            o.TotalAmount, o.Status, o.TrackingNumber
                            FROM Orders o
                            WHERE o.OrderId = @OrderId AND o.UserId = @UserId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@UserId", GetCurrentUserId());

                    con.Open();
                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());
                    return dt;
                }
            }
        }

        private DataTable GetOrderItemsData()
        {
            string query = @"SELECT i.Name, i.Quantity, i.UnitPrice, (i.Quantity * i.UnitPrice) AS Subtotal
                           FROM OrderItems i
                           WHERE i.OrderId = @OrderId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OrderId", orderId);

                    con.Open();
                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());
                    return dt;
                }
            }
        }

        private void ConfigureDynamicElements(DataRow order)
        {
            // Action buttons visibility
            btnCancel.Visible = CanCancelOrder();
        }

        private bool CanCancelOrder()
        {
            // Only allow cancellation for pending/processing orders
            return (orderStatus == "Pending" || orderStatus == "Processing");
        }

        private string GetTrackingUrl(string trackingNumber)
        {
            // Implement your tracking URL logic here
            // This is just a placeholder example
            return $"https://tracking.example.com/?tracking={trackingNumber}";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (!CanCancelOrder())
            {
                ShowError("This order cannot be cancelled at this stage.");
                return;
            }

            try
            {
                CancelOrder();
                ShowSuccess("Order has been cancelled successfully.");
                LoadOrderDetails(); // Refresh the page to show updated status
            }
            catch (Exception ex)
            {
                ShowError("Error cancelling order: " + ex.Message);
            }
        }

        private void CancelOrder()
        {
            string query = @"UPDATE Orders SET 
                           Status = 'Cancelled', 
                           ModifiedDate = GETDATE()
                           WHERE OrderId = @OrderId AND UserId = @UserId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@UserId", GetCurrentUserId());

                    con.Open();
                    int affected = cmd.ExecuteNonQuery();

                    if (affected == 0)
                        throw new Exception("Order could not be cancelled.");
                }
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/User/OrderHistory.aspx");
        }

        private void ShowErrorAndRedirect(string message)
        {
            Session["ErrorMessage"] = message;
            Response.Redirect("~/User/OrderHistory.aspx");
        }

        private void ShowError(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showError",
                $"alert('{message.Replace("'", "\\'")}');", true);
        }

        private void ShowSuccess(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccess",
                $"alert('{message.Replace("'", "\\'")}');", true);
        }
    }
}