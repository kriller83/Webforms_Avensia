using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Controller;
using AvensiaWebShop.CustomClasses;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    public partial class Kassa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var shopingCart = (ShopingCart)Session[WebShopController.SessionKeyShopingCart];

                FillCartItemsAndPrice(shopingCart);
                FillDeliveryOptions();
                FillPaymentOptions();
                Customer customer;
                if (GetActiveUser(out customer))
                    FillActiveUserData(customer);
            }
        }

        private void FillActiveUserData(Customer customer)
        {
            txtFNamn.Text = customer.FirstName;
            txtENamn.Text = customer.LastName;
            txtEPost.Text = customer.EmailAddress;

            txtFNamn.Enabled = false;
            txtENamn.Enabled = false;
            txtEPost.Enabled = false;
        }

        private bool GetActiveUser(out Customer customer)
        {
            var activeUserID = Session[WebShopController.SessionKeyActiveUserID];
            customer = null;

            if (activeUserID != null)
            {
                using (var db = new AvensiaWebshopEntities())
                {
                    customer = db.Customer.FirstOrDefault(c => c.CustomerID == (int)activeUserID);

                    return customer != null;
                }
            }

            return false;
        }

        private void FillCartItemsAndPrice(ShopingCart shopingCart)
        {

            if (shopingCart != null && shopingCart.CartItems.Count > 0)
            {
                repBasket.DataSource = shopingCart.CartItems;
                repBasket.DataBind();

                LtCartSum.Text = $"{shopingCart.SumTotal:N2}";

                var sumWithFreigth = shopingCart.SumTotal + GetFreightPrice();

                ltTotalPriceWithFreight.Text = $"{sumWithFreigth:N2}";

            panelBasketWIthItems.Visible = true;
                panelRegister.Visible = true;

                panelBasketEmpty.Visible = false;
            }
            else
            {
                panelBasketEmpty.Visible = true;

                panelBasketWIthItems.Visible = false;
                panelRegister.Visible = false;
            }
        }

        private void FillDeliveryOptions()
        {
            var options = new List<ListItem>()
            {
                new ListItem("DHL (99 kr)", "99"),
                new ListItem("Express (150 kr)", "159"),
                new ListItem("Posten (89 kr)", "89")
            };

            rblDeliveryOptions.DataSource = options;
            rblDeliveryOptions.DataTextField = "Text";
            rblDeliveryOptions.DataValueField = "Value";
            rblDeliveryOptions.DataBind();

        }

        private void FillPaymentOptions()
        {
            var options = new List<ListItem>()
            {
                new ListItem("Creditcard"),
                new ListItem("Invoice"),
                new ListItem("Cash on delivery")
            };

            rblPaymentOptions.DataSource = options;
            rblPaymentOptions.DataBind();
        }

        protected void OnTextChangedArticleAmount(object sender, EventArgs e)
        {
            var textBox = (TextBox)sender;
            var repeaterItem = (RepeaterItem)textBox.Parent;

            short quantity;
            var lblError = (Label)repeaterItem.FindControl("lblQuantityError");
            var hfOrginalAmount = (HiddenField)repeaterItem.FindControl("hfOrginalAmount");

            if (!short.TryParse(textBox.Text, out quantity) || quantity < 1)
            {
                textBox.Text = hfOrginalAmount.Value;

                lblError.Text = "Not a valid amount:";
                lblError.Visible = true;

                return;
            }
            else
            {
                lblError.Visible = false;
            }

            var hfArticleID = (HiddenField)repeaterItem.FindControl("hfArticleID");
            var productID = int.Parse(hfArticleID.Value);

            var shopingCart = (ShopingCart)Session[WebShopController.SessionKeyShopingCart];

            WebShopController.AddOrUpdateProductToCart(ref shopingCart, productID, quantity, true);

            UppdateCartAndSession(shopingCart);
        }

        protected void repBasket_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var shopingCart = (ShopingCart)Session[WebShopController.SessionKeyShopingCart];

            switch (e.CommandName)
            {
                case "RemoveItem":
                    WebShopController.RemoveProductFromCart(ref shopingCart, int.Parse(e.CommandArgument.ToString()));
                    break;
            }

            UppdateCartAndSession(shopingCart);
            FillCartItemsAndPrice(shopingCart);
        }

        private void UppdateCartAndSession(ShopingCart shopingCart)
        {
            Session[WebShopController.SessionKeyShopingCart] = shopingCart;

            FillCartItemsAndPrice(shopingCart);

            WebShopController.UppdateMiniCart(Master, shopingCart);
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            try
            {
                var shopingCart = (ShopingCart)Session[WebShopController.SessionKeyShopingCart];

                using (var db = new AvensiaWebshopEntities())
                {
                    var customer = new Customer()
                    {
                        NameStyle = false,
                        FirstName = txtFNamn.Text.Trim(),
                        LastName = txtENamn.Text.Trim(),
                        EmailAddress = txtEPost.Text.Trim(),
                        PasswordHash = "",
                        PasswordSalt = "",
                        rowguid = Guid.NewGuid(),
                        ModifiedDate = DateTime.Now

                    };
                    db.Customer.Add(customer);

                    var address = new Address()
                    {
                        AddressLine1 = txtAdress.Text.Trim(),
                        AddressLine2 = txtCoAdress.Text.Trim(),
                        City = txtOrt.Text.Trim(),
                        StateProvince = "",
                        CountryRegion = "",
                        PostalCode = txtPostNr.Text.Trim(),
                        rowguid = Guid.NewGuid(),
                        ModifiedDate = DateTime.Now
                    };
                    db.Address.Add(address);

                    db.SaveChanges();

                    var salesOrderHeader = new SalesOrderHeader()
                    {
                        OrderDate = DateTime.Today,
                        DueDate = DateTime.Today.AddDays(14),
                        SalesOrderNumber = "Number",
                        CustomerID = customer.CustomerID,
                        ShipToAddressID = address.AddressID,
                        ShipMethod = rblDeliveryOptions.SelectedItem.Text,
                        TaxAmt = shopingCart.SumTotal * (decimal)0.2,
                        ModifiedDate = DateTime.Now,
                        rowguid = Guid.NewGuid(),
                        Freight = GetFreightPrice()
                    };
                    db.SalesOrderHeader.Add(salesOrderHeader);

                    db.SaveChanges();

                    foreach (var cartItem in shopingCart.CartItems)
                    {
                        db.SalesOrderDetail.Add(new SalesOrderDetail()
                        {
                            SalesOrderID = salesOrderHeader.SalesOrderID,
                            OrderQty = cartItem.Quantity,
                            ProductID = cartItem.ProductID,
                            UnitPrice = cartItem.Price * (decimal)0.8,
                            UnitPriceDiscount = (decimal)0,
                            rowguid = Guid.NewGuid(),
                            ModifiedDate = DateTime.Now
                        });

                        db.SaveChanges();
                    }


                    Session["LastOrderID"] = salesOrderHeader.SalesOrderID;
                }
            }
            catch (Exception ex)
            {
                Session["LastOrderID"] = null;

                throw;
            }
            Session[WebShopController.SessionKeyShopingCart] = new ShopingCart();
            Response.Redirect("/Bekraftelse.aspx");
        }

        private decimal GetFreightPrice()
        {
            decimal freightPrice;

            if (decimal.TryParse(rblDeliveryOptions.SelectedValue, out freightPrice))
            {
                return freightPrice;
            }

            return (decimal)0;
        }

        protected void rblDeliveryOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            var shopingCart = (ShopingCart)Session[WebShopController.SessionKeyShopingCart];

            FillCartItemsAndPrice(shopingCart);
        }
    }
}
