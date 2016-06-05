using System;
using System.Collections.Generic;
using System.Deployment.Internal;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Services.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.CustomClasses;
using AvensiaWebShop.Models;

namespace AvensiaWebShop.Controller
{
    public static class WebShopController
    {
        public static MailAddress SuportMail { get; set; } = new MailAddress("support@flycycle.se", "FlyCycle Support");

        public const string SessionKeyActiveUserID = "ActiveUserID";
        public const string SessionKeyShopingCart = "ShopingCart";

        public const string UrlQueryKeyCategoryID = "catid";
        public const string QueryKeyProductCategoryID = "prodcatid";
        public const string QueryKeyProductModelID = "prodmodid";
        public const string QueryKeyProductID = "prodid";


        internal static decimal GetProductPrice(vProductAndDescripttionExtendedENOnly product)
        {
            if (product.DiscountActive != null && product.DiscountActive.Value)
            {
                return product.DiscountValue != null
                    ? product.ListPrice - (decimal)product.DiscountValue.Value
                    : product.ListPrice * (decimal)(1 - product.DiscountProcent.Value / 100);
            }

            return product.ListPrice;
        }

        internal static void UppdateMiniCart(MasterPage master, ShopingCart shopingCart)
        {
            var activeCart = shopingCart.CartItems.Take(shopingCart.ItemsInMiniCartToShow);

            Repeater shopingBasketRepeater = (Repeater)master.FindControl("repBasket");
            HyperLink linkToRegisterSmallCart = (HyperLink) master.FindControl("linkToRegisterSmallCart");
            Label lblMiniCartCount = (Label)master.FindControl("lblMiniCartCount");
            Label lblMiniCartSum = (Label)master.FindControl("lblMiniCartSum");
            Literal liMiniCartContentEmpty = (Literal)master.FindControl("liMiniCartContentEmpty");
            Label lblMoreThanFiveItemsInCart = (Label) master.FindControl("lblMoreThanFiveItemsInCart");

            lblMiniCartCount.Text = $"Articles: {shopingCart.NumberOfItems}"; ;
            lblMiniCartSum.Text = $"Sum: {shopingCart.SumTotal:N2} kr";

            shopingBasketRepeater.DataSource = activeCart;
            shopingBasketRepeater.DataBind();
            
            if (shopingCart.CartItems.Count > 0)
            {
                linkToRegisterSmallCart.Visible = true;
                liMiniCartContentEmpty.Visible = false;
            }
            else
            {
                linkToRegisterSmallCart.Visible = false;
                liMiniCartContentEmpty.Visible = true;
            }

            if (shopingCart.CartItems.Count > shopingCart.ItemsInMiniCartToShow)
                lblMoreThanFiveItemsInCart.Visible = true;
            else
            {
                lblMoreThanFiveItemsInCart.Visible = false;
            }
        }

        internal static bool AddOrUpdateProductToCart(ref ShopingCart cart, int productID, short productQty, bool replaceQuantity = false)
        {
            using (var db = new AvensiaWebshopEntities())
            {
                var vProduct = db.vProductAndDescripttionExtendedENOnly.FirstOrDefault(p => p.ProductID == productID);

                if (vProduct == null)
                {
                    // TODO: Implementera felkod om Product är null (inte finns i database).
                    return false;
                }

                var cartItem = cart.CartItems.FirstOrDefault(i => i.ProductID == vProduct.ProductID);
                
                if (cartItem == null)
                {
                    cartItem = new CartItem()
                    {
                        ProductID = vProduct.ProductID,
                        ProductModelID = vProduct.ProductModelID,
                        ProductName = vProduct.Name,
                        ProductImage = vProduct.LargePhotoFileName,
                        Price = Math.Round(WebShopController.GetProductPrice(vProduct), 2),
                        Quantity = 0,
                        Dricounted = vProduct.DiscountActive ?? false,
                        OriginalPrice = Math.Round(vProduct.ListPrice, 2)
                    };

                    cart.CartItems.Insert(0, cartItem);
                }

                if (replaceQuantity)
                    cartItem.Quantity = productQty;
                else
                    cartItem.Quantity += productQty;
            }

            return true;
        }

        internal static bool RemoveProductFromCart(ref ShopingCart cart, int productID)
        {
            var cartItem = cart.CartItems.SingleOrDefault(i => i.ProductID == productID);

            return cart.CartItems.Remove(cartItem);
        }

        internal static List<vProductAndDescripttionExtendedENOnly> GetPopularProducts(int numberOfProducts)
        {
            var result = new List<vProductAndDescripttionExtendedENOnly>();

            using (var db = new AvensiaWebshopEntities())
            {
                var popularItemIdsQuery =
                    db.SalesOrderDetail
                        .GroupBy(p => p.ProductID)
                        .OrderByDescending(g => g.Count())
                        .Select(g => g.FirstOrDefault().Product.ProductID)
                        .Take(numberOfProducts);

                result =
                    db.vProductAndDescripttionExtendedENOnly
                        .Where(p => popularItemIdsQuery.Contains(p.ProductID)).ToList();

                if (result.Count < numberOfProducts)
                {
                    result.AddRange(db.vProductAndDescripttionExtendedENOnly.GroupBy(p => p.ProductModelID)
                        .Where((p, index) => index % 5 == 0)
                        .Select(group => group.FirstOrDefault())
                        .Take(numberOfProducts - result.Count)
                        .ToList()
                        );
                }
            }

            return result;
        }

        internal static string ConverDatabasImageToString(byte[] imageByteArray)
        {
            return $"data:image/jpg;base64,{Convert.ToBase64String(imageByteArray)}";
        }

        internal static void SendMail(MailAddress fromAdress, MailAddress toAdress, string subject, string body, MailPriority mailPriority = MailPriority.Normal)
        {
            MailMessage mail = new MailMessage(fromAdress, toAdress);
            SmtpClient client = new SmtpClient();
            client.Port = 25;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Host = "localhost";
            mail.Subject = subject;
            mail.Body = body;
            mail.Priority = mailPriority;
            client.Send(mail);
        }

        internal static List<Kampanj> GetCampaigns(int numberOfCampaigns)
        {
            var campaignsList = new List<Kampanj>();
            using (var db = new AvensiaWebshopEntities())
            {
                campaignsList = db.Kampanj.Where(c => c.KampanjStatus == "active").ToList();
                if (campaignsList.Count > numberOfCampaigns)
                {
                    int numberToRemove = campaignsList.Count - numberOfCampaigns;
                    campaignsList.RemoveRange(numberOfCampaigns, numberToRemove);
                }
            }

           return campaignsList;
        }
    }
}