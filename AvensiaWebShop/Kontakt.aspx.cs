using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Controller;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    public partial class Kontakt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                GetActiveUser();
        }

        private void GetActiveUser()
        {
            var activeUserID = Session[WebShopController.SessionKeyActiveUserID];

            if (activeUserID != null)
            {
                using (var db = new AvensiaWebshopEntities())
                {
                    var customer = db.Customer.FirstOrDefault(c => c.CustomerID == (int)activeUserID);

                    if (customer != null && customer.CustomerID > 0)
                    {
                        txtFirstName.Text = customer.FirstName;
                        txtForLastName.Text = customer.LastName;
                        txtEmail.Text = customer.EmailAddress;

                        txtFirstName.Enabled = false;
                        txtForLastName.Enabled = false;
                        txtEmail.Enabled = false;
                    }
                }
            }
        }

        protected void SubmitTxtButton_Click(object sender, EventArgs e)
        {
            try
            {
                panelContactForm.Visible = false;
                panelConfirm.Visible = true;

                SendForm();
            }
            catch
            {
                throw;
            }
        }

        private void SendForm()
        {
            MailAddress fromAddress = new MailAddress(txtEmail.Text, $"{txtFirstName.Text} {txtForLastName.Text}");
            string txtFromBody =
                $"Förnamn:{txtFirstName.Text},\n\r" +
                $"Efternamn:{txtForLastName.Text}\n\r" +
                $"E-post:{txtEmail.Text}\n\r" +
                $"Mail inehåll:\n\r" + txtMailContent.Text;
            string DroppDownAlternative = ddlOptions.Text;
            MailAddress toAddress = new MailAddress("sales@flycyckel.se", "FlyCycle Suport");

            WebShopController.SendMail(fromAddress, toAddress, DroppDownAlternative, txtFromBody);
        }
    }
}