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
    
    public partial class vProductCategoryWithDescription
    {
        public int ProductCategoryID { get; set; }
        public Nullable<int> ParentProductCategoryID { get; set; }
        public string Name { get; set; }
        public string CategoryDescription { get; set; }
        public string Culture { get; set; }
        public string CategoryImageName { get; set; }
    }
}
