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
    
    public partial class Kampanj
    {
        public int KampanjID { get; set; }
        public string KampanjNamn { get; set; }
        public string KampanjImageName { get; set; }
        public string KampanjURL { get; set; }
        public Nullable<System.DateTime> KampanjStart { get; set; }
        public Nullable<System.DateTime> KampanjEnd { get; set; }
        public System.Guid rowguid { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public string KampanjStatus { get; set; }
    }
}