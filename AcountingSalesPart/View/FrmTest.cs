using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AcountingSalesPart.Controler;
using AcountingSalesPart.Models;

namespace AcountingSalesPart.View
{
    public partial class FrmTest : Form
    {
        public FrmTest()
        {
            InitializeComponent();
        }

        private async void button1_Click(object sender, EventArgs e)
        {


        }

        private async void button1_Click_1(object sender, EventArgs e)
        {
            EMP eMP = new EMP();
            eMP.Company = "46005";
            eMP.FirstName = "Ali";
            eMP.LastName = "Mobini";
            eMP.HireDate = DateTime.Now;
            eMP.Title = "admin";
            label1.Text= await ControlerMethods.SetEmp(eMP);
        }
    }
}
