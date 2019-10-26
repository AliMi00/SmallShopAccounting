using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AcountingSalesPart.Models
{
    public class OrderDetail
    {
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public decimal UnitPriceSale { get; set; }
        public decimal UnitPriceBuy { get; set; }
        public int qty { get; set; }
        public double discount { get; set; }
        public double Tax { get; set; }


    }
}
