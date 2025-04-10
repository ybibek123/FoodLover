using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickBites
{
	public partial class Registration : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                cvTerms.ErrorMessage = string.Empty;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // 🔹 1. Hash the password using BCrypt
                    string hashedPassword = BCrypt.Net.BCrypt.HashPassword(txtPassword.Text, 12);

                    // 🔹 2. Save to database
                    using (SqlConnection connection = new SqlConnection(
                        WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
                    {
                        string query = @"INSERT INTO Users 
                                        (Email, PasswordHash, Phone, FullName, 
                                         Street, City, IsActive, CreatedBy)
                                        VALUES 
                                        (@Email, @PasswordHash, @Phone, @FullName, 
                                         @Street, @City, 1, 0)";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            command.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                            command.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                            command.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                            command.Parameters.AddWithValue("@Street", txtStreet.Text.Trim());
                            command.Parameters.AddWithValue("@City", txtCity.Text.Trim());

                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                Response.Redirect("~/Login.aspx?registered=true");
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627) // Unique constraint violation (duplicate email)
                    {
                        cvTerms.IsValid = false;
                        cvTerms.ErrorMessage = "This email is already registered.";
                    }
                    else
                    {
                        cvTerms.IsValid = false;
                        cvTerms.ErrorMessage = "Database error. Please try again later.";
                    }
                }
                catch (Exception ex)
                {
                    cvTerms.IsValid = false;
                    cvTerms.ErrorMessage = "An unexpected error occurred: " + ex.Message;
                }
            }
        }

        protected void cvTerms_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cbTerms.Checked;
            if (!args.IsValid)
            {
                cvTerms.ErrorMessage = "You must accept the terms and conditions.";
            }
        }

        protected void cvPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (txtPassword.Text.Length >= 8) &&
                           (System.Text.RegularExpressions.Regex.IsMatch(txtPassword.Text, "[A-Za-z]")) &&
                           (System.Text.RegularExpressions.Regex.IsMatch(txtPassword.Text, "[0-9]"));

            if (!args.IsValid)
            {
                cvPassword.ErrorMessage = "Password must be at least 8 characters with letters and numbers.";
            }
        }
    }
}