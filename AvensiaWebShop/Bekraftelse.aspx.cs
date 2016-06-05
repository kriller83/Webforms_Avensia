using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Controller;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    public partial class Bekraftelse : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            FillOrderConfirm();
        }

        private void FillOrderConfirm()
        {
            int orderId = -1;

            var lastOrderIDObject = Session["LastOrderID"];

            if (lastOrderIDObject != null)
            {
                orderId = int.Parse(lastOrderIDObject.ToString());
            }

            else if (lastOrderIDObject == null || orderId == -1)
            {
                Response.Redirect("/Hem.aspx");
            }

            using (var db = new AvensiaWebshopEntities())
            {
                var orderQuerry = db.SalesOrderHeader.SingleOrDefault(o => o.SalesOrderID == orderId);

                repProductList.DataSource = orderQuerry.SalesOrderDetail;
                repProductList.DataBind();

                ltFreigtLabel.Text = $"{orderQuerry.ShipMethod} Shipping";
                ltFreightPrice.Text = $"{orderQuerry.Freight:N2}";

                ltTax.Text = $"{orderQuerry.TaxAmt:N2}";

                name.Text = $"{orderQuerry.Customer.FirstName} {orderQuerry.Customer.LastName}";

                var addressQuery = db.Address.FirstOrDefault(a => a.AddressID == orderQuerry.ShipToAddressID);

                if (addressQuery.AddressLine2 == "")
                {
                    adress.Text =
                       $"{addressQuery.AddressLine1} <br/> {addressQuery.City} <br/> {addressQuery.PostalCode}";
                }
                else
                {
                    adress.Text =
                        $"{addressQuery.AddressLine1} <br/> C/o {addressQuery.AddressLine2} <br/> {addressQuery.City} <br/> {addressQuery.PostalCode}";

                }

                pris.Text = $"&nbsp&nbsp&nbsp{orderQuerry.TotalDue:N2} kr";

                legendText.Text = $"order id: <span>{orderId}</span>";

                var customerQuery = db.Customer.FirstOrDefault(c => c.CustomerID == orderQuerry.CustomerID);
                mail.Text = $"{customerQuery.EmailAddress}";

                SendComfirmationMail(orderQuerry, orderQuerry.Customer);
            }
        }

        private void SendComfirmationMail(SalesOrderHeader salesOrderHeader, Customer customer)
        {
            try
            {
                var subject = "Thank you for ordering form FlyCycles";
                var body = $"We have recived your order with the order ID {salesOrderHeader.SalesOrderNumber}.\r\n" +
                           $"Best regards\r\n" +
                           $"FlyCycles";

                WebShopController.SendMail(WebShopController.SuportMail,
                    new MailAddress(customer.EmailAddress, $"{customer.FirstName} {customer.LastName}"), subject, body);
            }
            catch (Exception ex)
            {
                // TODO: Logg order confirm mail error.

                panelMail.Visible = false;
                panelMailError.Visible = true;
            }
        }
    }
}