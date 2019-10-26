using AcountingSalesPart.Models;
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
using System.Data.SqlClient;

namespace AcountingSalesPart.View
{
    public partial class FrmEmpMain : FrmBase
    {
        //VARIABLE
        #region
        private EMP _emp = new EMP() {EmpId = 1, Title = "admin" };
        private List<Customers> _CustomersList;
        private List<Product> _ProductList;
        private List<Category> _CategoriesList;
        private List<OrderDetail> _OrderDetailsList;
        private List<Product> ListProducts;
        private List<Product> _SoldProduct = new List<Product>();
        private Product _Product = new Product();
        private bool CheckShowDialog;

        #endregion

        public FrmEmpMain(EMP emp)
        {
            InitializeComponent();
            _emp = emp;
            
        }
        public FrmEmpMain()
        {
            InitializeComponent();
        }
        private async void FrmEmpMain_Load(object sender, EventArgs e)
        {

            //add customer info 
            Customers customer = await CustCheck();
            txtCustomerCode.Text = customer.CustId.ToString();
            txtCustomerName.Text = customer.CompanyName;
            txtCustomerPhone.Text = customer.Phone;
            //load product 
            _ProductList = await ControlerMethods.GetProductsAsync();
            ListProducts = await ControlerMethods.GetProductsAsync();
            LoadProductTodata();
            LoadSoldProductTodata();

            //page setings
            btnAddEditedProduct.Visible = false;
            if (!_emp.Title.Equals("admin"))
            {
                if (tabControl1.TabCount > 2)
                {
                    tabControl1.TabPages.Remove(TabAddProductAndCat);
                    tabControl1.TabPages.RemoveAt(2);
                    tabControl1.TabPages.Remove(TabExistProduct);

                }

            }
            else
            {
                if (tabControl1.TabCount < 2)
                {
                    tabControl1.TabPages.Add(TabAddProductAndCat);
                    tabControl1.TabPages.Add(TabManage);
                    tabControl1.TabPages.Add(TabExistProduct);
                }
            }

        }

        //SECTION NEW ORDER
        #region
        private async Task<Customers> CustCheck()
        {

            if (rdbtnDefaultCustomer.Checked)
            {
                List<Customers> customers;
                if (_CustomersList != null)
                {
                    customers = _CustomersList;
                }
                else
                {
                    customers = await ControlerMethods.GetCustomersAsync(1);
                }

                return customers.FirstOrDefault<Customers>();
                
                
            }
            else if (rdbtnNewCustomer.Checked && !txtCustomerCode.Text.Equals(""))
            {
                Customers customer = new Customers();
                customer.CompanyName = txtCustomerName.Text;
                customer.Phone = txtCustomerPhone.Text;
                customer.CustId = Convert.ToInt32(txtCustomerCode.Text);
                return customer; 
            }
            else
            {
                List<Customers> customers = await ControlerMethods.GetCustomersAsync(1);
                return customers.FirstOrDefault<Customers>();
            }
        }

        private void rdbtnDefaultCustomer_CheckedChanged(object sender, EventArgs e)
        {
            if (rdbtnNewCustomer.Checked)
            {
                txtCustomerCode.Text = "";
                txtCustomerName.Text = "";
                txtCustomerPhone.Text = "";
            }

        }       
        public void ShowProduct(string productName)
        {
            ListProducts = _ProductList.Where(x => x.ProductName.Contains(productName)).ToList<Product>();
            LoadProductTodata();
        }
        public void ShowProduct(int productCode)
        {
            ListProducts = _ProductList.Where(x => x.ProuductCode.StartsWith(productCode.ToString())).ToList<Product>();
            LoadProductTodata();
        }
        private void LoadProductTodata()
        {
            //add product to data girid view 
            if (_ProductList != null)
            {
                BindingSource bs = new BindingSource();
                bs.Clear();
                bs.ResetBindings(false);
                bs.DataSource = ListProducts.Where(x => x.Qty >0);
                dataProductList.DataSource = bs;
            }

            dataProductList.Columns[0].Visible = false;
            dataProductList.Columns[3].Visible = false;
            dataProductList.Columns[4].Visible = false;
            dataProductList.Columns[6].Visible = false;
            dataProductList.Columns[8].Visible = false;


            dataProductList.Columns[1].HeaderText = "کد کالا ";
            dataProductList.Columns[2].HeaderText = "نام کالا";
            dataProductList.Columns[5].HeaderText = "قیمت";
            dataProductList.Columns[7].HeaderText = "تخفیف";
            dataProductList.Columns[5].DefaultCellStyle.Format = "#,#";

            dataProductList.Columns[1].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dataProductList.Columns[2].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dataProductList.Columns[5].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dataProductList.Columns[7].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
            dataProductList.Columns[9].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;

        }
        private void LoadSoldProductTodata()
        {
            //add product to data girid view 
            if (_SoldProduct != null)
            {
                //BindingSource bs = new BindingSource();
                //bs.Clear();
                //bs.DataSource = _SoldProduct;
                //dataOrderDetails.DataSource =_SoldProduct.ToList();
                dataOrderDetails.DataSource =new  BindingList<Product>(_SoldProduct);


                dataOrderDetails.Columns[0].Visible = false;
                dataOrderDetails.Columns[3].Visible = false;
                dataOrderDetails.Columns[4].Visible = false;
                dataOrderDetails.Columns[6].Visible = false;
                //dataOrderDetails.Columns[8].Visible = false;


                dataOrderDetails.Columns[1].HeaderText = "کد کالا ";
                dataOrderDetails.Columns[2].HeaderText = "نام کالا";
                dataOrderDetails.Columns[5].HeaderText = "قیمت";
                dataOrderDetails.Columns[7].HeaderText = "تخفیف";
                dataOrderDetails.Columns[5].DefaultCellStyle.Format = "#,#";

                dataOrderDetails.Columns[1].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
                dataOrderDetails.Columns[2].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
                dataOrderDetails.Columns[5].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
                dataOrderDetails.Columns[7].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
                dataOrderDetails.Columns[9].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
                dataOrderDetails.Columns[8].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;


            }

        }
        private void LoadProductTotxt(Product product)
        {
            txtCodeProduct.Text =product.ProuductCode.ToString();
            txtNameProduct.Text = product.ProductName.ToString();
            txtPriceProduct.Text = product.UnitPriceSales.ToString();
            txtDiscountProduct.Text = product.Discount.ToString();
        }
        private void LoadProductTotxt(Product product,int qty)
        {
            txtCodeProduct.Text = product.ProuductCode.ToString();
            txtNameProduct.Text = product.ProductName.ToString();
            txtPriceProduct.Text = product.UnitPriceSales.ToString();
            txtDiscountProduct.Text = (product.Discount * 100).ToString();
            txtQtyProduct.Text = qty.ToString();

        }

        private void txtCodeProduct_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtCodeProduct.Text.Equals(""))
                {
                    LoadProductTodata();
                }
                txtAddProductName.Text = "";
                //ShowProduct(Convert.ToInt32(txtCodeProduct.Text.ToString().Trim()));
                ListProducts = _ProductList.Where(x => x.ProuductCode.StartsWith(txtCodeProduct.Text.ToString().Trim())).ToList<Product>();
                LoadProductTodata();

            }
            catch(Exception ex)
            {

            }
        }

        private void txtNameProduct_TextChanged(object sender, EventArgs e)
        {
            try
            {
                ShowProduct(txtNameProduct.Text);

            }
            catch (Exception ex)
            {

            }
        }

        private void dataProductList_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int productId = 0;
            if(dataProductList.SelectedRows.Count == 1)
            {
                productId = Convert.ToInt32(dataProductList[0, dataProductList.SelectedRows[0].Index].Value);
            }
            _Product = _ProductList.Where(x => x.ProductId == productId).FirstOrDefault<Product>();
            LoadProductTotxt(_ProductList.Where(x => x.ProductId == productId).FirstOrDefault<Product>(),1);

        }

        private void txtCodeProduct_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode == Keys.Enter)
            {
                try
                {
                    _Product = _ProductList.Where(x => x.ProuductCode.Equals(txtCodeProduct.Text)).FirstOrDefault<Product>();
                    LoadProductTotxt(_Product, 1);
                    btnAddProduct_Click(sender, e);

                }
                catch(Exception ex)
                {
                    MessageBox.Show("لطفا مقادیر را برسی نمایید  " + "\n" + ex.Message.ToString(),
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                }


            }
        }
        //btn add product new factor section
        private async void btnAddProduct_Click(object sender, EventArgs e)
        {
            AddProductDetails();
            LoadSoldProductTodata();
            _ProductList = await ControlerMethods.GetProductsAsync();

            lblTotal1.Text = String.Format("{0:#,#}", ControlerMethods.AmountOfSale(ProductToOrderDetails(_SoldProduct)));
            lblTotalCount.Text = ControlerMethods.TotalOfQty(ProductToOrderDetails(_SoldProduct)).ToString();
            Product temppr = new Product() { ProductName = "",ProuductCode="",Qty = 1,Discount = 0,UnitPriceSales=0 };
            LoadProductTotxt(temppr);
            txtPackPrice.Text = "0";
        }

        private List<OrderDetail> ProductToOrderDetails(List<Product> products)
        {
            List<OrderDetail> orderDetails = new List<OrderDetail>(); 
            foreach(Product pro in products)
            {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.ProductId = pro.ProductId;
                orderDetail.UnitPriceSale = pro.UnitPriceSales;
                orderDetail.UnitPriceBuy = pro.UnitPriceBuy;
                orderDetail.qty = pro.Qty;
                orderDetail.discount = pro.Discount;
                orderDetail.Tax = pro.Tax;

                orderDetails.Add(orderDetail);
            }
            return orderDetails;
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if(dataOrderDetails.SelectedRows.Count == 1)
            {
                Product tempProduct;
                tempProduct =(Product) dataOrderDetails.SelectedRows[0].DataBoundItem;
                LoadProductTotxt(tempProduct , tempProduct.Qty);
                _SoldProduct.Remove(tempProduct);
                LoadSoldProductTodata();
            }
            else
            {
                MessageBox.Show("لطفا یک سطر را انتخاب نمایید   " + "\n" ,
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
            }
        }

        private void btnDeleteProductDetail_Click(object sender, EventArgs e)
        {
            if (dataOrderDetails.SelectedRows.Count >= 1)
            {
                DialogResult result = MessageBox.Show("ایا مطمن هستید ؟", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                if(result == DialogResult.Yes)
                {
                    Product tempProduct;
                    tempProduct = (Product)dataOrderDetails.SelectedRows[0].DataBoundItem;
                    _SoldProduct.Remove(tempProduct);
                    LoadSoldProductTodata();
                    lblTotal1.Text = String.Format("{0:#,#}", ControlerMethods.AmountOfSale(ProductToOrderDetails(_SoldProduct)));
                    lblTotalCount.Text = ControlerMethods.TotalOfQty(ProductToOrderDetails(_SoldProduct)).ToString();
                }

            }
            else
            {
                MessageBox.Show("لطفا یک سطر را انتخاب نمایید   " + "\n",
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
            }
        }

        private void btnCancelOrder_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("ایا مطمن هستید ؟", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (result == DialogResult.Yes)
            {
                _SoldProduct = new List<Product>();
                LoadSoldProductTodata();
            }
        }
        //btn add factor section new factor 
        private async void btnAddOrderAndOrderDetail_Click(object sender, EventArgs e)
        {
            btnAddOrderAndOrderDetail.Enabled = false;
            Orders order = new Orders();
            Customers customer = await CustCheck();
            List<OrderDetail> details = ProductToOrderDetails(_SoldProduct);
            order.CustId = customer.CustId;
            order.EmpId = _emp.EmpId;
            order.OrderDate = DateTime.Now;
            order.AmountBuy = ControlerMethods.AmountOfBuy(details);
            order.AmountSell = ControlerMethods.AmountOfSale(details);
            order.Profit = ControlerMethods.porfit(details);
            try
            {
                order = await ControlerMethods.SetOrderAsync(order, details);

                DialogResult result = MessageBox.Show( String.Format("فاکتور به شماره {0} ثبت گردید",order.OrderId),
                        "موفق",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Information);

                btnAddOrderAndOrderDetail.Enabled = result == DialogResult.OK ? true : false;

                _SoldProduct = new List<Product>();
                LoadSoldProductTodata();
                lblTotal1.Text = String.Format("{0:#,#}", ControlerMethods.AmountOfSale(ProductToOrderDetails(_SoldProduct)));
                lblTotalCount.Text = ControlerMethods.TotalOfQty(ProductToOrderDetails(_SoldProduct)).ToString();
            }
            catch(Exception ex)
            {
                MessageBox.Show("خطا در هنگام انجام عملایات  " + "\n" + ex.Message,
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
            }

        }

        #endregion

        //btn search orders COMPLITED
        private async void btnSearchOrders_Click(object sender, EventArgs e)
        {
            if (txtOrderIdSearch.Text.Equals(""))
            {
                List<Orders> orders = await ControlerMethods.GetOrdersAsync(date1.Value.Date, date2.Value.Date.AddMinutes(1439), _emp.EmpId);
                dataOrderByTimeOrID.DataSource = orders;
                dataOrderByTimeOrID.Columns["AmountBuy"].Visible = false;
                dataOrderByTimeOrID.Columns["Profit"].Visible = false;
                dataOrderByTimeOrID.Columns["AmountSell"].DefaultCellStyle.Format = "#,#";

                lblOrderTotalPriceSell.Text = "0";
                lblOrderTotalPriceSell.Text = String.Format("{0:#,#}", orders.Sum(x => x.AmountSell));

            }else if (!txtOrderIdSearch.Text.Equals(""))
            {
                List<Orders> orders = await ControlerMethods.GetOrdersAsync(Convert.ToInt32(txtOrderIdSearch.Text));
                dataOrderByTimeOrID.DataSource = orders;
                dataOrderByTimeOrID.Columns["AmountBuy"].Visible = false;
                dataOrderByTimeOrID.Columns["Profit"].Visible = false;
                dataOrderByTimeOrID.Columns["AmountSell"].DefaultCellStyle.Format = "#,#";

                lblOrderTotalPriceSell.Text = "0";
                lblOrderTotalPriceSell.Text = String.Format("{0:#,#}", orders.Sum(x => x.AmountSell));

            }

        }

        //btn delete order and orderdetails COMPITED
        private async void btnDeleteOrder_Click(object sender, EventArgs e)
        {
            if (dataOrderByTimeOrID.SelectedRows.Count == 1)
            {
                DialogResult result = MessageBox.Show("ایا مطمن هستید ؟", "WARNING", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                if (result == DialogResult.Yes)
                {
                    Orders tempOrder;
                    tempOrder = (Orders)dataOrderByTimeOrID.SelectedRows[0].DataBoundItem;
                    await ControlerMethods.DeleteOrderAsync(tempOrder);
                    btnSearchOrders_Click(sender, e);
                }
            }
            else
            {
                MessageBox.Show("لطفا یک سطر را انتخاب نمایید   " + "\n",
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
            }
        }
        //add product available COMPITED
        private async void btnDbAddProduct_Click(object sender, EventArgs e)
        {
            try
            {
                List<Category> categories = await ControlerMethods.GetCategoryAsync();
                List<Suppliers> suppliers = await ControlerMethods.GetSupliersAsync();
                List<Product> products = await ControlerMethods.GetProductsAsync();
                Product product = new Product();
                product.CategoryId = categories.Where(x => x.CategoryName.Equals(comboCat.Text.ToString())).FirstOrDefault<Category>().CategoryId;
                product.SupplierId = suppliers.Where(x => x.CompanyName.Equals(comboSup.Text.ToString())).FirstOrDefault<Suppliers>().SupplierId;
                product.ProductName = txtAddProductName.Text;
                product.ProuductCode = txtAddProductCode.Text;
                product.Qty = Convert.ToInt32(txtAddProductQty.Text);
                product.Tax = Convert.ToInt32(txtAddProductTax.Text) / 100;
                product.UnitPriceBuy = Convert.ToInt32(txtAddProductBuy.Text);
                product.UnitPriceSales = Convert.ToInt32(txtAddProductSale.Text);
                product.Discount = Convert.ToDouble(txtAddProductDiscount.Text) / 100;
                FrmEmpMain_Load(sender, e);

                if(products.Where(x => x.ProuductCode.Equals(product.ProuductCode)).Count() >0)
                {
                    DialogResult dialogResult =  MessageBox.Show(String.Format("محصول موجود می باشد آیا مایل به افزودن تعداد وارد شده می باشید  "),
                                "اخطار",
                                MessageBoxButtons.YesNo,
                                MessageBoxIcon.Warning);
                    if(dialogResult == DialogResult.Yes)
                    {
                        await ControlerMethods.CheckAndSetProduct(product);
                        MessageBox.Show(String.Format("با موفقیت ثبت گردید "),
                                        "موفق",
                                        MessageBoxButtons.OK,
                                        MessageBoxIcon.Information);
                    }

                }
                else
                {
                    await ControlerMethods.CheckAndSetProduct(product);

                }

                dataQtyProduct.DataSource = await ControlerMethods.GetProductsAsync();
            }
            catch(Exception ex)
            {
                MessageBox.Show("خطا در هنگام انجام عملایات  " + "\n" + ex.GetBaseException().ToString(),
                    "خطا",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }


        }
        
        //btn add category COMPLITED
        private async void btnAddCat_Click(object sender, EventArgs e)
        {
            Category category = new Category();
            if (!txtCatName.Text.Equals(""))
            {
                category.CategoryName = txtCatName.Text;
                category.Description = txtCatDes.Text;
                await ControlerMethods.SetCategoryAsync(category);
                txtCatDes.Text = "";
                txtCatName.Text = "";
                DataCategory.DataSource = await ControlerMethods.GetCategoryAsync();
            }


        }
        //btn add supliers COMPLITED
        private async void btnAddSup_Click(object sender, EventArgs e)
        {
            if (!txtSupName.Text.Equals(""))
            {
                Suppliers supplier = new Suppliers();
                supplier.CompanyName = txtSupName.Text;
                supplier.Phone = txtSupPhone.Text;

                await ControlerMethods.SetSuplierAsync(supplier);
                txtSupPhone.Text = "";
                txtSupName.Text = "";
            }
            dataSupliers.DataSource = await ControlerMethods.GetSupliersAsync();

        }
        //tab selection change uncompited
        private async void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(tabControl1.SelectedIndex == 2)
            {
                dataQtyProduct.DataSource = await ControlerMethods.GetProductsAsync();
                dataSupliers.DataSource = await ControlerMethods.GetSupliersAsync();
                DataCategory.DataSource = await ControlerMethods.GetCategoryAsync();
                dataSupliers.Columns["SupplierId"].Visible = false;
                DataCategory.Columns["CategoryId"].Visible = false;
                if (comboCat.Items.Count < 1)
                {
                    List<Category> categories = await ControlerMethods.GetCategoryAsync();
                    foreach (Category cat in categories)
                    {
                        comboCat.Items.Add(cat.CategoryName);
                    }
                    List<Suppliers> suppliers = await ControlerMethods.GetSupliersAsync();
                    foreach (Suppliers sup in suppliers)
                    {
                        comboSup.Items.Add(sup.CompanyName);
                    }

                }

            }
            else if(tabControl1.SelectedIndex == 0)
            {
                FrmEmpMain_Load(sender, e);
            }
            else if(tabControl1.SelectedIndex == 3)
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("date1",dateSumOrder1.Value.Date ));
                sqlParameters.Add(new SqlParameter("date2",dateSumOrder2.Value.Date.AddMinutes(1439)));

                dataSumOrders.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgSumOrders", sqlParameters);
                dataSumOrders.Columns["sumProfit"].DefaultCellStyle.Format = "#,#";
                dataSumOrders.Columns["sumSell"].DefaultCellStyle.Format = "#,#";
                dataSumOrders.Columns["sumBuy"].DefaultCellStyle.Format = "#,#";
                dataSumOrders.Columns["Column1"].HeaderText = "نام کارمند";
                dataSumOrders.Columns["sumProfit"].HeaderText = "مجموع سود";
                dataSumOrders.Columns["sumBuy"].HeaderText = "محموع خرید";
                dataSumOrders.Columns["sumSell"].HeaderText = "مجموع فروش ";
                dataSumOrders.Columns["Column2"].Visible = false;
            }
            else if (tabControl1.SelectedIndex == 4)
            {
                dgvExistProduct.DataSource = await DataAccessAsync.ExecSPAsync("Production.GetProductByCode");

            }
        }

        //btn search Sum Order
        private async void btnSearchSumOrder_Click(object sender, EventArgs e)
        {
            int empId = -1;
            if (dataSumOrders.SelectedRows.Count == 1 && !dataSumOrders.SelectedRows[0].Cells["Column2"].Value.Equals(0))
            {
                empId = Convert.ToInt32(dataSumOrders.SelectedRows[0].Cells["Column2"].Value);
            }
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
            sqlParameters.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));

            dataSumOrders.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgSumOrders", sqlParameters);
            if (rbtnProduct.Checked)
            {
                
                List<SqlParameter> sqlParameters2 = new List<SqlParameter>();
                sqlParameters2.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
                sqlParameters2.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));
                sqlParameters2.Add(new SqlParameter("empId", -1));

                dataEmpSoldOrderDetails.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsAll", sqlParameters2);

            }
            else if (rbtnProductCode.Checked)
            {
                List<SqlParameter> sqlParameters2 = new List<SqlParameter>();
                sqlParameters2.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
                sqlParameters2.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));
                sqlParameters2.Add(new SqlParameter("empId", empId));
                //dataEmpSoldOrderDetails.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsGroupCode", sqlParameters2);
                DataTable dt = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsGroupCode", sqlParameters2);

                List<OrderDetail> orderDetails = ControlerMethods.DataTableToList<OrderDetail>(dt);
                List<AmountSellShow> amountSellShows = await AmountSellForShow(orderDetails);
                dataEmpSoldOrderDetails.DataSource = amountSellShows.ToList();
                dataEmpSoldOrderDetails.Columns[2].DefaultCellStyle.Format = "#,#";
            }
            else if (rbtnCategory.Checked)
            {
                List<SqlParameter> sqlParameters2 = new List<SqlParameter>();
                sqlParameters2.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
                sqlParameters2.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));
                sqlParameters2.Add(new SqlParameter("empId", -1));
                dataEmpSoldOrderDetails.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsGroupCat", sqlParameters2);
            }

        }

        private async void btnUpdateAddedProduct_Click(object sender, EventArgs e)
        {
            if(dataQtyProduct.SelectedRows.Count == 1)
            {
                Product product =(Product)dataQtyProduct.SelectedRows[0].DataBoundItem;

                List<Category> categories = await ControlerMethods.GetCategoryAsync();
                List<Suppliers> suppliers = await ControlerMethods.GetSupliersAsync();
                comboCat.SelectedIndex = comboCat.Items.IndexOf( categories.Where(x => x.CategoryId.Equals(product.CategoryId)).FirstOrDefault<Category>().CategoryName);
                comboSup.SelectedIndex = comboSup.Items.IndexOf(suppliers.Where(x => x.SupplierId.Equals(product.SupplierId)).FirstOrDefault<Suppliers>().CompanyName);
                txtAddProductName.Text = product.ProductName ;
                txtAddProductCode.Text = product.ProuductCode ;
                txtAddProductQty.Text= (product.Qty).ToString() ;
                txtAddProductTax.Text = (product.Tax * 100).ToString();
                txtAddProductBuy.Text = product.UnitPriceBuy.ToString();
                txtAddProductSale.Text = product.UnitPriceSales.ToString();
                txtAddProductDiscount.Text= (product.Discount * 100).ToString();
                btnDbAddProduct.Enabled = false;
                txtAddProductCode.Enabled = false;
                btnAddEditedProduct.Visible = true;
            }
            else
            {
                MessageBox.Show("لطفا یک سطر را انتخاب نمایید   " + "\n",
                    "خطا",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }
        // add edited product and update product 
        private async void btnAddEditedProduct_Click(object sender, EventArgs e)
        {
            try
            {
                List<Category> categories = await ControlerMethods.GetCategoryAsync();
                List<Suppliers> suppliers = await ControlerMethods.GetSupliersAsync();
                List<Product> products = await ControlerMethods.GetProductsAsync();
                Product product = new Product();
                product.ProductId = products.Where(x => x.ProuductCode.Equals(txtAddProductCode.Text)).FirstOrDefault<Product>().ProductId;
                product.CategoryId = categories.Where(x => x.CategoryName.Equals(comboCat.Text.ToString())).FirstOrDefault<Category>().CategoryId;
                product.SupplierId = suppliers.Where(x => x.CompanyName.Equals(comboSup.Text.ToString())).FirstOrDefault<Suppliers>().SupplierId;
                product.ProductName = txtAddProductName.Text;
                product.ProuductCode = txtAddProductCode.Text;
                product.Qty = Convert.ToInt32(txtAddProductQty.Text);
                product.Tax = Convert.ToInt32(txtAddProductTax.Text) / 100;
                product.UnitPriceBuy = Convert.ToInt32(txtAddProductBuy.Text);
                product.UnitPriceSales = Convert.ToInt32(txtAddProductSale.Text);
                product.Discount =Convert.ToDouble(txtAddProductDiscount.Text)/100 ;
                
                FrmEmpMain_Load(sender, e);
                await ControlerMethods.UpdateProductAsync(product);
                MessageBox.Show(String.Format("با موفقیت ثبت گردید "),
                                                "موفق",
                                                MessageBoxButtons.OK,
                                                MessageBoxIcon.Information);
                dataQtyProduct.DataSource = await ControlerMethods.GetProductsAsync();
                btnAddEditedProduct.Visible = false;
                btnDbAddProduct.Enabled = true;
                txtAddProductCode.Enabled = true;
                txtAddProductName.Text = "";
                txtAddProductCode.Text = "";
                txtAddProductQty.Text = "";
                txtAddProductTax.Text = "0";
                txtAddProductBuy.Text = "";
                txtAddProductSale.Text = "";
                txtAddProductDiscount.Text = "";
            }
            catch (Exception ex)
            {
                MessageBox.Show("خطا در هنگام انجام عملایات  " + "\n" + ex.GetBaseException().ToString(),
                    "خطا",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }

        private async void btnDeleteAddedProduct_Click(object sender, EventArgs e)
        {
            if(dataQtyProduct.SelectedRows.Count == 1)
            {
                try
                {
                    Product product = (Product)dataQtyProduct.SelectedRows[0].DataBoundItem;
                    await ControlerMethods.DeleteProduct(product);
                    dataQtyProduct.DataSource = await ControlerMethods.GetProductsAsync();
                }
                catch
                {
                    MessageBox.Show("بعد از فروش محصول امکان حذف وجود ندارد میتوانید تعداد محصول را به صفر تغییر دهید    " + "\n",
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                }


            }
            else
            {
                MessageBox.Show("لطفا یک سطر را انتخاب نمایید   " + "\n",
                    "خطا",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }

        private async void btnDeleteSup_Click(object sender, EventArgs e)
        {
            if (dataSupliers.SelectedRows.Count == 1)
            {
                try
                {
                    Suppliers supplier = (Suppliers)dataSupliers.SelectedRows[0].DataBoundItem;
                    await ControlerMethods.DeleteSupplier(supplier);
                    dataSupliers.DataSource = await ControlerMethods.GetSupliersAsync();
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message + "\n",
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                }


            }
            else
            {
                MessageBox.Show("لطفا یک سطر را انتخاب نمایید   " + "\n",
                    "خطا",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }

        private async void btnDeleteCat_Click(object sender, EventArgs e)
        {
            if (DataCategory.SelectedRows.Count == 1)
            {
                try
                {
                    Category category = (Category)DataCategory.SelectedRows[0].DataBoundItem;
                    await ControlerMethods.DeleteCategory(category);
                    DataCategory.DataSource = await ControlerMethods.GetCategoryAsync();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message + "\n",
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                }


            }
            else
            {
                MessageBox.Show("لطفا یک سطر را انتخاب نمایید   " + "\n",
                    "خطا",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }
        //COMPLITED
        private async void txtAddProductCode_KeyDown(object sender, KeyEventArgs e)
        {

            if (e.KeyCode == Keys.Enter)
            {
                try
                {
                    List<Category> categories = await ControlerMethods.GetCategoryAsync();
                    List<Suppliers> suppliers = await ControlerMethods.GetSupliersAsync();
                    List<Product> products = await ControlerMethods.GetProductsAsync();
                    if(products.Where(x => x.ProuductCode.Equals(txtAddProductCode.Text)).Count() == 1)
                    {
                        DialogResult dialogResult = MessageBox.Show("محصول موجود می باشد \n یک عدد به محصول افزوده شود ؟ ", "توجه", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                        if(dialogResult == DialogResult.Yes)
                        {
                            Product product = (Product)products.Where(x => x.ProuductCode.Equals(txtAddProductCode.Text)).FirstOrDefault<Product>();
                            product.Qty = 1;
                            await ControlerMethods.CheckAndSetProduct(product);
                            dataQtyProduct.DataSource = await ControlerMethods.GetProductsAsync();
                            if (CheckShowDialog.Equals(null))
                            {
                                CheckShowDialog =
                                    MessageBox.Show("هر بار سوال شود ؟", "", MessageBoxButtons.YesNo, MessageBoxIcon.Warning).Equals(DialogResult.Yes) ?   true :  false;
                            }
                        }


                    }

                }
                catch (Exception ex)
                {
                    MessageBox.Show("لطفا مقادیر را برسی نمایید  " + "\n" + ex.Message.ToString(),
                                    "خطا",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                }


            }
        }

        private async void dataSumOrders_SelectionChanged(object sender, EventArgs e)
        {
            int empId = -1;
            if (dataSumOrders.SelectedRows.Count == 1 && !dataSumOrders.SelectedRows[0].Cells["Column2"].Value.Equals(0))
            {
                empId = Convert.ToInt32(dataSumOrders.SelectedRows[0].Cells["Column2"].Value);
            }

            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
            sqlParameters.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));

            if (rbtnProduct.Checked)
            {

                List<SqlParameter> sqlParameters2 = new List<SqlParameter>();
                sqlParameters2.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
                sqlParameters2.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));
                sqlParameters2.Add(new SqlParameter("empId", empId));

                dataEmpSoldOrderDetails.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsAll", sqlParameters2);

            }
            else if (rbtnProductCode.Checked)
            {
                List<SqlParameter> sqlParameters2 = new List<SqlParameter>();
                sqlParameters2.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
                sqlParameters2.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));
                sqlParameters2.Add(new SqlParameter("empId", empId));
                //dataEmpSoldOrderDetails.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsGroupCode", sqlParameters2);
                DataTable dt = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsGroupCode", sqlParameters2);

                List<OrderDetail> orderDetails = ControlerMethods.DataTableToList<OrderDetail>(dt);
                List<AmountSellShow> amountSellShows =await  AmountSellForShow(orderDetails);
                dataEmpSoldOrderDetails.DataSource = amountSellShows.ToList();
            }
            else if (rbtnCategory.Checked)
            {
                List<SqlParameter> sqlParameters2 = new List<SqlParameter>();
                sqlParameters2.Add(new SqlParameter("date1", dateSumOrder1.Value.Date));
                sqlParameters2.Add(new SqlParameter("date2", dateSumOrder2.Value.Date.AddMinutes(1439)));
                sqlParameters2.Add(new SqlParameter("empId", empId));
                dataEmpSoldOrderDetails.DataSource = await DataAccessAsync.ExecSPAsync("Sales.dvgOrderDetailsGroupCat", sqlParameters2);
            }
        }

        private void FrmEmpMain_FormClosed(object sender, FormClosedEventArgs e)
        {
            FrmLogin frmLogin = new FrmLogin();
            frmLogin.Show();
        }

        private async void txtTabAddProductSearch_TextChanged(object sender, EventArgs e)
        {
            List<Product> _ProductListTa2 = await ControlerMethods.GetProductsAsync();
            List<Product> ListProductsTab2 = _ProductList.Where(x => x.ProuductCode.StartsWith(txtTabAddProductSearch.Text.Trim())).ToList<Product>();
            BindingSource bs = new BindingSource();
            bs.Clear();
            bs.ResetBindings(false);
            if (txtTabAddProductSearch.Text.Equals(""))
            {
                if (_ProductListTa2 != null)
                {
                    bs.DataSource = ListProductsTab2;
                    dataQtyProduct.DataSource = bs;
                }
            }
            else
            {
                bs.DataSource = ListProductsTab2;
                dataQtyProduct.DataSource = bs;
            }
            
        }

        private async void txtTabAddSupSearch_TextChanged(object sender, EventArgs e)
        {
            List<Suppliers> suppliersTab2 = await ControlerMethods.GetSupliersAsync();
            if (txtTabAddSupSearch.Text.Equals(""))
            {
                if (suppliersTab2 != null)
                {
                    
                    dataSupliers.DataSource = suppliersTab2;
                }
            }
            else
            {
                if (suppliersTab2 != null)
                {

                    dataSupliers.DataSource = suppliersTab2.Where(x => x.CompanyName.Contains(txtTabAddSupSearch.Text.Trim())).ToList<Suppliers>();
                }
            }
        }

        private async void txtTabAddCatSearch_TextChanged(object sender, EventArgs e)
        {
            List<Category> categoryTab2 = await ControlerMethods.GetCategoryAsync();
            if (txtTabAddSupSearch.Text.Equals(""))
            {
                if (categoryTab2 != null)
                {

                    DataCategory.DataSource = categoryTab2;
                }
            }
            else
            {
                if (categoryTab2 != null)
                {

                    DataCategory.DataSource = categoryTab2.Where(x => x.CategoryName.Contains(txtTabAddCatSearch.Text.Trim())).ToList<Category>();
                }
            }
        }

        private async void rbtnShowExistProductByCat_CheckedChanged(object sender, EventArgs e)
        {
            dgvExistProduct.DataSource =await DataAccessAsync.ExecSPAsync("Production.GetProductByCat");
        }

        private async void rbtnShowExistProductByCode_CheckedChanged(object sender, EventArgs e)
        {
            dgvExistProduct.DataSource =await DataAccessAsync.ExecSPAsync("Production.GetProductByCode");

        }
        //ADD PRODUCTDETAILS
        private  void AddProductDetails()
        {
            Product _product = _ProductList.Where(x => x.ProuductCode.Equals(txtCodeProduct.Text)).FirstOrDefault<Product>();
            if (_product == null)
            {
                return;
            }
            if (_SoldProduct.Where(
                x => x.ProductId == _product.ProductId 
                && x.UnitPriceSales == Convert.ToInt32(txtPriceProduct.Text) + Convert.ToInt32(txtPackPrice.Text)
                && x.UnitPriceBuy == (_product.UnitPriceBuy + Convert.ToInt32(txtPackPrice.Text)) ).Count() == 1)
            {
                var index = _SoldProduct.FindIndex(
                    x => x.ProductId == _product.ProductId
                    && x.UnitPriceSales == Convert.ToInt32(txtPriceProduct.Text) + Convert.ToInt32(txtPackPrice.Text)
                    && x.UnitPriceBuy == (_product.UnitPriceBuy + Convert.ToInt32(txtPackPrice.Text)));

                _product = _SoldProduct.Where(
                    x => x.ProductId == _product.ProductId
                    && x.UnitPriceSales == Convert.ToInt32(txtPriceProduct.Text) + Convert.ToInt32(txtPackPrice.Text)
                    && x.UnitPriceBuy == (_product.UnitPriceBuy + Convert.ToInt32(txtPackPrice.Text))).FirstOrDefault<Product>();

                _product.Qty += Convert.ToInt32(txtQtyProduct.Text);
                _SoldProduct.RemoveAt(index);
                _SoldProduct.Add(_product);

            }
            else
            {
                _product.UnitPriceSales = Convert.ToInt32(txtPriceProduct.Text) + Convert.ToInt32(txtPackPrice.Text);
                _product.UnitPriceBuy += Convert.ToInt32(txtPackPrice.Text);
                _product.Discount = Convert.ToDouble(txtDiscountProduct.Text) / 100;
                _product.Qty = Convert.ToInt32(txtQtyProduct.Text);
                _SoldProduct.Add(_product);
            }
        }

        private async Task<List<AmountSellShow>> AmountSellForShow(List<OrderDetail> orderDetails)
        {
            List<Product> products = await ControlerMethods.GetProductsAsync();
            List<AmountSellShow> amountSellShows = new List<AmountSellShow>();
            foreach(OrderDetail od in orderDetails)
            {
                if(amountSellShows.Exists(x => x.ProductId==od.ProductId))
                {
                    amountSellShows.Where(x => x.ProductId == od.ProductId).FirstOrDefault()
                        .AmountSell += (od.UnitPriceSale - od.UnitPriceSale * Convert.ToDecimal(od.discount)) * od.qty;
                    amountSellShows.Where(x => x.ProductId == od.ProductId).FirstOrDefault()
                        .Qty += od.qty;
                }
                else
                {
                    AmountSellShow amountSell = new AmountSellShow();
                    amountSell.ProductId = od.ProductId;
                    amountSell.ProductName = products.Where(x => x.ProductId.Equals(od.ProductId)).FirstOrDefault().ProductName;
                    amountSell.AmountSell = (od.UnitPriceSale - od.UnitPriceSale * Convert.ToDecimal(od.discount)) * od.qty;
                    amountSell.Qty = od.qty;
                    amountSellShows.Add(amountSell);

                }
            }
            return amountSellShows;
        }


    }
}
