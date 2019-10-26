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
    public partial class FrmLogin : FrmBase
    {

        private bool exitApp = true;
        public FrmLogin()
        {
            InitializeComponent();

        }

        private async void btnLogin_Click(object sender, EventArgs e)
        {
            String Username, Password;
            bool LoginRes;
            Username = txtUserName.Text.ToString();
            Password = txtPassWord.Text.ToString();
            try
            {
                LoginRes = await ControlerMethods.LoginAsync(Username, Password);
                if (LoginRes)
                {
                    EMP emp = await ControlerMethods.GetEmpAsync(Username);
                    FrmEmpMain frmEmpMain = new FrmEmpMain(emp);
                    frmEmpMain.Show();
                    exitApp = false;
                    this.Close();
                    
                    
                }
                else
                {
                    MessageBox
                        .Show("خواهشمند است اطلاعات را با دقت وارد نمایید   ", "خطا", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtPassWord.Text = "";
                    txtPassWord.Text = "";
                }
            }
            catch 
            {
                MessageBox
                    .Show("لطفا دوباره امتحان کنید ", "خطا", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
           

        }

        private void FrmLogin_FormClosed(object sender, FormClosedEventArgs e)
        {
            if(exitApp)
            Application.ExitThread();
        }

        private void FrmLogin_FormClosing(object sender, FormClosingEventArgs e)
        {

        }
    }
}
