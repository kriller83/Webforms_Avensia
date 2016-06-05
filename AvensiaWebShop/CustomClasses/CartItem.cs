using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AvensiaWebShop.Models;

namespace AvensiaWebShop.CustomClasses
{
    public class CartItem
    {
        public int ProductID { get; set; }
        public int ProductModelID { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public short Quantity { get; set; }
        public decimal Price { get; set; }
        public bool Dricounted { get; set; }
        public decimal OriginalPrice { get; set; }
        public decimal LineSum => Price * Quantity;
    }
}