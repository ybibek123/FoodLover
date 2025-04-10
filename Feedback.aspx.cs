using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace QuickBites
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["DBCon"].ConnectionString))
            {
                string query = "INSERT INTO Feedbacks (Name, Comment) VALUES (@Name, @Comment)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Comment", txtComment.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                lblMessage.Text = "Thanks for your feedback!";
                txtName.Text = txtComment.Text = "";
            }
        }
    }
}