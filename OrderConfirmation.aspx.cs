using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickBites
{
	public partial class OrderConfirmation : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["orderId"] != null)
                {
                    litOrderId.Text = Request.QueryString["orderId"];
                }
                else
                {
                    Response.Redirect("Menu.aspx");
                }
            }
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu.aspx");
        }
    }
}