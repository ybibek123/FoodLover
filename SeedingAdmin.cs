using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace QuickBites
{
	public class SeedingAdmin
	{
        public static void SeedAdminUser()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if an Admin already exists
                string checkAdminQuery = "SELECT COUNT(*) FROM Users WHERE Role = @Role";
                using (SqlCommand cmd = new SqlCommand(checkAdminQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Role", "Admin");
                    int adminCount = (int)cmd.ExecuteScalar();

                    if (adminCount == 0) // If no admin exists, create one
                    {
                        string insertAdminQuery = @"INSERT INTO Users 
                                                   (Email, PasswordHash, Phone, FullName, 
                                                    Street, City, Role, IsActive, CreatedBy) 
                                                   VALUES 
                                                   (@Email, @PasswordHash, @Phone, @FullName, 
                                                    @Street, @City, @Role, 1, 0)";

                        using (SqlCommand insertCmd = new SqlCommand(insertAdminQuery, conn))
                        {
                            // Set default admin credentials
                            string defaultEmail = "admin@foodlover.com";
                            string defaultPassword = "Admin@123";
                            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(defaultPassword, 12);

                            insertCmd.Parameters.AddWithValue("@Email", defaultEmail);
                            insertCmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                            insertCmd.Parameters.AddWithValue("@Phone", "9800000000");
                            insertCmd.Parameters.AddWithValue("@FullName", "Admin User");
                            insertCmd.Parameters.AddWithValue("@Street", "Tinkune");
                            insertCmd.Parameters.AddWithValue("@City", "Kathmandu");
                            insertCmd.Parameters.AddWithValue("@Role", "Admin");

                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }
    }
}
