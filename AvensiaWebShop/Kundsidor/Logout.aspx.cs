using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Controller;

namespace AvensiaWebShop.Kundsidor
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LogOutUser();
        }
        internal void LogOutUser()
        {
            Session[WebShopController.SessionKeyActiveUserID] = null;

            Response.Redirect("/Hem.aspx");
        }
    }
}