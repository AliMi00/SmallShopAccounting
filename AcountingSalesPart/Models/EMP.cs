using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AcountingSalesPart.Models
{
    public class EMP
    {
        public int EmpId { get; set; }
        public String Company { get; set; }
        public String FirstName { get; set; }
        public String LastName { get; set; }
        public String Title { get; set; }
        public DateTime HireDate { get; set; }
    }
}
