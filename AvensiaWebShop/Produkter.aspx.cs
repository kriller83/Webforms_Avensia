using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AvensiaWebShop.Controller;
using AvensiaWebShop.CustomClasses;
using AvensiaWebShop.Models;

namespace AvensiaWebShop
{
    public partial class Produkter : System.Web.UI.Page
    {
        public string SearchQueryString
        {
            get
            {
                if (Request.QueryString["searchQuery"] != null)
                {
                    var queryString = Request.QueryString["searchQuery"];
                    return HttpUtility.UrlDecode(queryString);
                }

                return null;
            }
        }

        public int CategoryIDQueryString
        {
            get
            {
                int categoryId;

                if (!string.IsNullOrEmpty(Request.QueryString[WebShopController.UrlQueryKeyCategoryID]) &&
                    int.TryParse(Request.QueryString[WebShopController.UrlQueryKeyCategoryID], out categoryId))
                {
                    //hfActiveTopCategory.Value = categoryId.ToString();
                    return categoryId;
                }
                //else if (int.TryParse(hfActiveTopCategory.Value, out categoryId) && categoryId >= 0)
                //{
                //    return categoryId;
                //}

                return -1;
            }
        }

        private int ProductCategoryIDQueryString
        {
            get
            {
                int categoryId;

                if (!string.IsNullOrEmpty(Request.QueryString[WebShopController.QueryKeyProductCategoryID]) &&
                    int.TryParse(Request.QueryString[WebShopController.QueryKeyProductCategoryID], out categoryId))
                    return categoryId;

                return -1;
            }
        }

        private int ProductModelIDQueryString
        {
            get
            {
                int productId;

                if (!string.IsNullOrEmpty(Request.QueryString[WebShopController.QueryKeyProductModelID]) &&
                    int.TryParse(Request.QueryString[WebShopController.QueryKeyProductModelID], out productId))
                    return productId;

                return -1;
            }
        }

        public int ProductIDQueryString
        {
            get
            {
                int productId;

                if (!string.IsNullOrEmpty(Request.QueryString[WebShopController.QueryKeyProductID]) &&
                    int.TryParse(Request.QueryString[WebShopController.QueryKeyProductID], out productId))
                    return productId;

                return -1;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadContent();
            LoadCampaigns();
        }

        private void LoadContent()
        {
            HidePanels();

            if (ProductModelIDQueryString > 0)
            {
                panelProductView.Visible = true;

                FillProductInfo(ProductModelIDQueryString, ProductIDQueryString);
            }
            else if (ProductCategoryIDQueryString > 0)
            {
                panelProductList.Visible = true;
                panelCategories.Visible = true;
                PanelCategoryMenu.Visible = true;

                FillCategoryRepeaterAndDescrition(CategoryIDQueryString);
                FillProductRepeater(ProductCategoryIDQueryString);
            }
            else if (CategoryIDQueryString > 0)
            {
                panelCategories.Visible = true;
                PanelCategoryMenu.Visible = true;

                FillCategoryRepeaterAndDescrition(CategoryIDQueryString, true);
            }
            else if (SearchQueryString != null)
            {
                DisplaySearchResult(SearchQueryString);
            }
        }

        private void HidePanels()
        {
            panelCategories.Visible = false;
            panelProductList.Visible = false;
            panelProductView.Visible = false;
            panelCategoryDescription.Visible = false;
            PanelCategoryMenu.Visible = false;
            panelNoProducts.Visible = false;
        }

        private void FillCategoryRepeaterAndDescrition(int parentCategoryId, bool showCategoryDescription = false)
        {
            using (var db = new AvensiaWebshopEntities())
            {
                IQueryable<vProductCategoryWithDescription> categoryQuery = db.vProductCategoryWithDescription;

                if (CategoryIDQueryString >= parentCategoryId)
                    categoryQuery = categoryQuery.Where(cat => cat.ParentProductCategoryID == CategoryIDQueryString);

                repSubMenu.DataSource = categoryQuery.ToList();
                repSubMenu.DataBind();

                var parentCategory =
                    db.vProductCategoryWithDescription.Where(cat => cat.ProductCategoryID == parentCategoryId)
                        .FirstOrDefault();

                ltPageHeader.Text = parentCategory.Name;

                if (showCategoryDescription && parentCategory.CategoryImageName != null)
                {
                    imgCategoryImage.ImageUrl = "~/images/products/" + parentCategory.CategoryImageName;
                    panelCategoryDescription.Visible = true;
                }
                if (showCategoryDescription && parentCategory.CategoryDescription != null)
                {
                    ltCategoryDescripton.Text = parentCategory.CategoryDescription;
                    panelCategoryDescription.Visible = true;
                }
            }
        }

        private void FillProductRepeater(int productParentCategory)
        {
            var products = new List<vProductAndDescripttionExtendedENOnly>();

            using (var db = new AvensiaWebshopEntities())
            {
                var categoryQuery =
                    db.ProductCategory.FirstOrDefault(cat => cat.ProductCategoryID == productParentCategory);

                if (categoryQuery != null && !string.IsNullOrEmpty(categoryQuery.Name))
                    ltPageHeader.Text = categoryQuery.Name;

                products = db.vProductAndDescripttionExtendedENOnly
                    .Where(product => product.ProductCategoryID == productParentCategory)
                    .ToList();
            }

            products = FillProductListAndFilter(products);
        }

        private List<vProductAndDescripttionExtendedENOnly> FillProductListAndFilter(List<vProductAndDescripttionExtendedENOnly> products)
        {
            products = FilterAndOrderProductList(products);

            products = products
                .GroupBy(produduct => produduct.ProductModelID)
                .Select(productGroup => productGroup.FirstOrDefault())
                .ToList();

            products = OrderListBySelection(products);

            repProductList.DataSource = products;
            repProductList.DataBind();
            return products;
        }

        private List<vProductAndDescripttionExtendedENOnly> FilterAndOrderProductList(List<vProductAndDescripttionExtendedENOnly> products)
        {
            if (!IsPostBack)
                FillProductListFilter(products);

            if (IsPostBack && ddlColor.SelectedIndex > 0)
            {
                products = products.Where(p => p.Color == ddlColor.SelectedValue).ToList();
            }

            if (IsPostBack && ddlSize.SelectedIndex > 0)
            {
                products = products.Where(p => p.Size == ddlSize.SelectedValue).ToList();
            }

            return products;
        }

        private List<vProductAndDescripttionExtendedENOnly> OrderListBySelection(
            List<vProductAndDescripttionExtendedENOnly> products)
        {
            if (ddlSortorder.SelectedValue == "1")
            {
                switch (ddlOrderBy.SelectedValue)
                {
                    case "name":
                        products = products.OrderBy(p => p.ProductModel).ToList();
                        break;
                    case "color":
                        products = products.OrderBy(p => p.Color).ToList();
                        break;
                    case "size":
                        products = products.OrderBy(p => p.Size).ToList();
                        break;
                }
            }
            else
            {
                switch (ddlOrderBy.SelectedValue)
                {
                    case "name":
                        products = products.OrderByDescending(p => p.ProductModel).ToList();
                        break;
                    case "color":
                        products = products.OrderByDescending(p => p.Color).ToList();
                        break;
                    case "size":
                        products = products.OrderByDescending(p => p.Size).ToList();
                        break;
                }
            }

            return products;
        }

        private void FillProductListFilter(List<vProductAndDescripttionExtendedENOnly> products)
        {
            var colorList =
                products
                    .GroupBy(p => p.Color)
                    .Select(colorGroup => colorGroup.FirstOrDefault())
                    .Where(p => p.Color != null)
                    .Select(p => new ListItem(p.Color, p.Color)).ToList();

            if (colorList.Count > 0)
            {
                ddlColor.DataSource = colorList;
                ddlColor.DataBind();
                ddlColor.Visible = true;

                ddlColor.Items.Insert(0, new ListItem("Color", "-1"));

                ddlOrderBy.Items.Add(new ListItem("Color", "color"));
            }
            else
            {
                ddlColor.Visible = false;
            }

            var sizeList =
                products
                    .GroupBy(p => p.Size)
                    .Select(sizeGroup => sizeGroup.FirstOrDefault())
                    .Where(p => p.Size != null)
                    .Select(p => new ListItem(p.Size, p.Size)).ToList();

            if (sizeList.Count > 0)
            {
                ddlSize.DataSource = sizeList;
                ddlSize.DataBind();
                ddlSize.Visible = true;

                ddlSize.Items.Insert(0, new ListItem("Size", "-1"));

                ddlOrderBy.Items.Add(new ListItem("Size", "size"));
            }
            else
            {
                ddlSize.Visible = false;
            }
        }

        protected void filterDdl_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillProductRepeater(ProductCategoryIDQueryString);
        }

        private void FillProductInfo(int productModelId, int productID)
        {
            using (var db = new AvensiaWebshopEntities())
            {
                var products =
                    db.vProductAndDescripttionExtendedENOnly.Where(p => p.ProductModelID == productModelId)
                        .OrderBy(product => product.Name);

                var activeProduct =
                    (productID < 0)
                        ? products.FirstOrDefault()
                        : products.SingleOrDefault(p => p.ProductID == productID);

                hfActiveProduct.Value = activeProduct.ProductID.ToString();

                ltPageHeader.Text =
                    $"{activeProduct.ProductModel} {(activeProduct.Size != null ? $"Storlek {activeProduct.Size} " : string.Empty)}{(activeProduct.Color ?? string.Empty)}";

                imgMainImage.ImageUrl = $"/Media.ashx?image={activeProduct.LargePhotoFileName}";
                imgMainImage.AlternateText = activeProduct.Name;

                lbArticlePrice.Text = $"{activeProduct.ListPrice:N2}";

                if (activeProduct.DiscountActive != null && activeProduct.DiscountActive.Value)
                {
                    ltArticleOrginalPrice.Text = $"{activeProduct.ListPrice:N2}";

                    lbArticlePrice.Text =
                        $"{WebShopController.GetProductPrice(activeProduct):N2}";

                    lbArticlePrice.CssClass = "articleDiscountedPrice";
                    panelArticleOriginalPrice.Visible = true;
                }
                else
                {
                    lbArticlePrice.CssClass = string.Empty;

                    panelArticleOriginalPrice.Visible = false;
                }

                ltArticleDescription.Text = activeProduct.Description;

                ltArticleNumber.Text = activeProduct.ProductNumber;

                if (products.Count() > 1 && (activeProduct.Color != null || activeProduct.Size != null))
                {
                    UpdateArticleChoiseDropDown(products, activeProduct);
                }
            }
        }

        private void UpdateArticleChoiseDropDown(IOrderedQueryable<vProductAndDescripttionExtendedENOnly> products,
            vProductAndDescripttionExtendedENOnly activeProduct)
        {
            if (ddlArticleChoises.Items.Count == 0)
            {
                foreach (var product in products)
                {
                    ddlArticleChoises.Items.Add(
                        new ListItem(
                            $"{(product.Size != null ? $"Size {product.Size} " : string.Empty)}{(product.Color ?? string.Empty)}",
                            product.ProductID.ToString()));
                }
            }

            ddlArticleChoises.SelectedValue = activeProduct.ProductID.ToString();
            panelArticleOptions.Visible = true;
        }

        protected void ddlArticleChoises_SelectedIndexChanged(object sender, EventArgs e)
        {
            var articleDownList = (DropDownList)sender;

            FillProductInfo(ProductModelIDQueryString, int.Parse(articleDownList.SelectedValue));
        }

        protected void repProductList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId;

            if (int.TryParse(e.CommandName, out productId))
            {
                // TODO [Erik]: Save item to basket. Hur löser vi val av färg/storlek?
            }
        }

        private void DisplaySearchResult(string searchQueryFromUrl)
        {

            var searchStrings = new List<string>();
            var searchQuery = new List<vProductAndDescripttionExtendedENOnly>();

            if (searchQueryFromUrl.Length > 0)
                searchStrings.AddRange(searchQueryFromUrl.Split(' ').ToList());

            if (searchStrings.Count > 0)
            {
                string sqlQuery = "SELECT *" +
                                  " FROM [AvensiaWebShop].[dbo].[vProductAndDescripttionExtendedENOnly]" +
                                  " WHERE Name LIKE '%" + searchStrings[0] + "%'" +
                                  " OR Description LIKE '%" + searchStrings[0] + "%'" +
                                  " OR ProductNumber LIKE '%" + searchStrings[0] + "%'";

                for (int i = 1; i < searchStrings.Count; i++)
                {

                    sqlQuery += " OR Name LIKE '%" + searchStrings[i] + "%'" +
                                " OR Description LIKE '%" + searchStrings[i] + "%'" +
                                " OR ProductNumber LIKE '%" + searchStrings[0] + "%'";
                }

                using (var db = new AvensiaWebshopEntities())
                {
                    searchQuery = db.vProductAndDescripttionExtendedENOnly.SqlQuery(sqlQuery).ToList();
                }
            }

            ltPageHeader.Text = "Search results";
            
            if (searchQuery.ToList().Count > 0)
            {
                FillProductListAndFilter(searchQuery);

                panelProductList.Visible = true;
                PanelCategoryMenu.Visible = true;
                panelCategories.Visible = true;
            }
            else
            {
                panelNoProducts.Visible = true;
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            ShopingCart shopingCart = (ShopingCart)Session[WebShopController.SessionKeyShopingCart];

            if (shopingCart == null)
                shopingCart = new ShopingCart();

            int productID = -1;
            if (!int.TryParse(hfActiveProduct.Value, out productID))
            {
                // TODO: Implementera felkod om ProductID inte är en sifra (HidenField går inte att manupura på framsidan(?)).
            }

            short productQty;
            if (!short.TryParse(txtArticleAmount.Text, out productQty))
            {
                // TODO: Implementera felkod om antalet inte är en sifra.
            }

            if (WebShopController.AddOrUpdateProductToCart(ref shopingCart, productID, productQty))
            {
                //TODO: Implementera felkod om varan inte kan läggas i korgen.
            }

            Session[WebShopController.SessionKeyShopingCart] = shopingCart;

            WebShopController.UppdateMiniCart(Master, shopingCart);
        }

        private void LoadCampaigns()
        {
            repCampaign.DataSource = WebShopController.GetCampaigns(5);
            repCampaign.DataBind();
        }

    }
}