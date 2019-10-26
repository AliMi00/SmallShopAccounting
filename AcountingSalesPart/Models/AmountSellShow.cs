using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AcountingSalesPart.Models
{
    class AmountSellShow
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal AmountSell { get; set; }
        public int  Qty { get; set; }

    }
}
