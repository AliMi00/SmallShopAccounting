using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AcountingSalesPart.Models
{
    public class Orders
    {
        public int OrderId { get; set; }
        public int CustId { get; set; }
        public int EmpId { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal Profit { get; set; }
        public decimal AmountSell { get; set; }
        public decimal AmountBuy { get; set; }


    }
}
