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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {

            using (var db = new AvensiaWebshopEntities())
            {
                var customerExistQuery = db.Customer.FirstOrDefault(c => c.EmailAddress == txtUserName.Text);
                if (customerExistQuery != null)
                {
                    lblStatus.Text = "E-postadressen finns redan";
                    return;
                }
                else if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    lblStatus.Text = "Password must match";
                    return;
                }
                var customer = new Customer()
                {
                    NameStyle = false,
                    FirstName = txtFirstName.Text.Trim(),
                    LastName = txtLastName.Text.Trim(),
                    EmailAddress = txtUserName.Text,
                    PasswordHash = txtPassword.Text,
                    PasswordSalt = "",
                    rowguid = Guid.NewGuid(),
                    ModifiedDate = DateTime.Now

                };
                db.Customer.Add(customer);

                db.SaveChanges();

                Session[WebShopController.SessionKeyActiveUserID] = customer.CustomerID;

                Response.Redirect("/Hem.aspx");
            }
        }
    }
}