using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace QuickBites
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["registered"] != null)
            {
                lblMessage.Text = "Registration successful! Please log in.";
                lblMessage.Visible = true;
                lblMessage.CssClass = "text-success";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text;

                try
                {
                    if (ValidateUser(email, password, out int userId, out string userRole))
                    {
                        // Store UserId & Role in Session
                        Session["UserId"] = userId;
                        Session["UserRole"] = userRole;

                        // Role-based redirection
                        var roleRedirects = new Dictionary<string, string>
                        {
                            { "Admin", "~/Admin/Dashboard.aspx" },
                            { "Customer", "~/Default.aspx" }
                        };

                        string redirectUrl = roleRedirects.ContainsKey(userRole) ? roleRedirects[userRole] : "~/Default.aspx";

                        Response.Redirect(redirectUrl);
                    }
                    else
                    {
                        lblMessage.Text = "Invalid email or password";
                        lblMessage.Visible = true;
                        lblMessage.CssClass = "text-danger";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Login error: " + ex.Message;
                    lblMessage.Visible = true;
                    lblMessage.CssClass = "text-danger";
                }
            }
        }

        private bool ValidateUser(string email, string password, out int userId, out string userRole)
        {
            userId = 0;
            userRole = string.Empty;

            using (SqlConnection connection = new SqlConnection(
                WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = @"SELECT UserId, PasswordHash, Role FROM Users 
                                 WHERE Email = @Email AND IsActive = 1";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string storedHash = reader["PasswordHash"].ToString();

                            if (!string.IsNullOrEmpty(storedHash) && BCrypt.Net.BCrypt.Verify(password, storedHash))
                            {
                                userId = Convert.ToInt32(reader["UserId"]);
                                userRole = reader["Role"].ToString();
                                return true;
                            }
                        }
                    }
                }
            }
            return false;
        }
    }
}
