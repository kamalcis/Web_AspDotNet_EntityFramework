//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MSIPortal
{
    using System;
    using System.Collections.Generic;
    
    public partial class LU_tbl_ProductServiceType
    {
        public LU_tbl_ProductServiceType()
        {
            this.tbl_Post = new HashSet<tbl_Post>();
        }
    
        public string PSTypeID { get; set; }
        public string ProductServiceType { get; set; }
        public System.Guid EditUser { get; set; }
        public System.DateTime EditDate { get; set; }
    
        public virtual ICollection<tbl_Post> tbl_Post { get; set; }
    }
}