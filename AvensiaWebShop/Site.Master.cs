using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Controller;
using AvensiaWebShop.CustomClasses;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public string SearchQueryString
        {
            get
            {
                if (!string.IsNullOrEmpty(Request.QueryString["searchQuery"]))
                {

                    var queryString = Request.QueryString["searchQuery"];
                    return HttpUtility.UrlDecode(queryString);
                }

                return string.Empty;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;

            if (!IsPostBack)
            {
                PopulateMenu();
                SearchRefiller();
                FillShopingCart();
                IsUserActive();
            }
        }

        private void FillShopingCart()
        {
            using (var db = new AvensiaWebshopEntities())
            {
                var shopingCart = (ShopingCart)Session[WebShopController.SessionKeyShopingCart] ?? new ShopingCart();

                WebShopController.UppdateMiniCart(this, shopingCart);
            }
        }

        private void SearchRefiller()
        {
            if (!string.IsNullOrWhiteSpace(SearchQueryString))
            {
                txtSearch.Text = SearchQueryString;
            }
        }

        private void PopulateMenu()
        {
            using (var db = new AvensiaWebshopEntities())
            {
                var categoryQuery = db.ProductCategory.Where(p => p.ParentProductCategoryID == null);

                repNavigation.DataSource = categoryQuery.ToList();
                repNavigation.DataBind();
            }
        }

        protected void btnButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Produkter.aspx?searchQuery=" + HttpUtility.UrlEncode(txtSearch.Text.ToLower()));
        }

        internal void IsUserActive()
        {
            var activeUserID = Session[WebShopController.SessionKeyActiveUserID];

            if (activeUserID == null)
            {
                panelAuthorized.Visible = false;
                panelNonAuthorized.Visible = true;
            }
            else
            {
                using (var db = new AvensiaWebshopEntities())
                {
                    var customer = db.Customer.FirstOrDefault(c => c.CustomerID == (int)activeUserID);

                    lblCustomerName.Text = customer.FirstName;
                }

                panelAuthorized.Visible = true;
                panelNonAuthorized.Visible = false;
            }
        }
    }
}