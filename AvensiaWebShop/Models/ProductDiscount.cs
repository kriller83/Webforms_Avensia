//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AvensiaWebShop.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ProductDiscount
    {
        public int ID { get; set; }
        public int ProductID { get; set; }
        public string DiscountLabel { get; set; }
        public Nullable<double> DiscountProcent { get; set; }
        public Nullable<double> DiscountValue { get; set; }
        public bool DiscountActive { get; set; }
        public System.Guid rowgid { get; set; }
        public System.DateTime ModifiedDate { get; set; }
    
        public virtual Product Product { get; set; }
    }
}
