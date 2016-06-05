using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop;
using AvensiaWebShop.Controller;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    public partial class Hem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PopulatePopularProduct();
            LoadCampaigns();
        }

        private void PopulatePopularProduct()
        {
            repPopularItems.DataSource = WebShopController.GetPopularProducts(6);
            repPopularItems.DataBind();
        }

        private void LoadCampaigns()
        {
            repCampaign.DataSource = WebShopController.GetCampaigns(1);
            repCampaign.DataBind();
        }
    }

}
