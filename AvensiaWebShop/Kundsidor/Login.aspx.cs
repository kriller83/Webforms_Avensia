using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Controller;
using AvensiaWebShop.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;

namespace AvensiaWebShop.Kundsidor
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            using (var db = new AvensiaWebshopEntities())
            {
                var activeUser = db.Customer.SingleOrDefault(c => c.EmailAddress == txtUserName.Text.ToLower().Trim() && c.PasswordHash == txtPassword.Text.Trim());

                if (activeUser != null)
                {
                    Session[WebShopController.SessionKeyActiveUserID] = activeUser.CustomerID;
                    Response.Redirect("/Hem.aspx");
                }

                lblStatus.Text = "Felaktigt lösenord eller användarnamn";
                lblStatus.Visible = true;


            }
        }
    }
}