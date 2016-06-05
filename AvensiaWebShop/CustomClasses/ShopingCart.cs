using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using AvensiaWebShop.Controller;
using AvensiaWebShop.Models;

namespace AvensiaWebShop.CustomClasses
{
    public class ShopingCart
    {
        internal int CustomerID { get; set; } = -1;
        public string CartName { get; set; }
        public List<CartItem> CartItems { get; set; } = new List<CartItem>();
        public int NumberOfItems => CartItems.Sum(i => i.Quantity);
        public decimal SumTotal => CartItems.Sum(product => product.LineSum);
        public int ItemsInMiniCartToShow { get; set; } = 4;
    }
}