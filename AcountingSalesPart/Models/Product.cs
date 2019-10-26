using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AcountingSalesPart.Models
{
    public class Product
    {
        public int ProductId { get; set; }
        public string ProuductCode { get; set; }
        public String ProductName { get; set; }
        public int SupplierId { get; set; }
        public int CategoryId { get; set; }
        public int UnitPriceSales { get; set; }
        public int UnitPriceBuy { get; set; }
        public double Discount { get; set; }
        public int Qty { get; set; }
        public double Tax { get; set; }


    }
}
