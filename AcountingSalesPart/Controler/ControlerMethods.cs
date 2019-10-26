using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using AcountingSalesPart.Controler;
using AcountingSalesPart.Models;
using System.Windows.Forms;


namespace AcountingSalesPart.Controler
{
    public static class ControlerMethods
    {
        //login
        public static async Task<bool> LoginAsync(String Username ,String Password)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>();
            sqlParams.Add(new SqlParameter("Username", Username.Trim().ToLower()));
            sqlParams.Add(new SqlParameter("Password", Password));

            DataTable dtLoginRe = await DataAccessAsync.ExecSPAsync("HR.loginSP", sqlParams);


            //check info
            if (dtLoginRe.Rows.Count == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        //listToTable
        public static DataTable ListToDataTable<T>(this IList<T> data)
        {
            PropertyDescriptorCollection props =
                TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            for (int i = 0; i < props.Count; i++)
            {
                PropertyDescriptor prop = props[i];
                table.Columns.Add(prop.Name, prop.PropertyType);
            }
            object[] values = new object[props.Count];
            foreach (T item in data)
            {
                for (int i = 0; i < values.Length; i++)
                {
                    values[i] = props[i].GetValue(item);
                }
                table.Rows.Add(values);
            }
            return table;
        }

        // function that creates a list of an object from the given data table
        public static List<T> DataTableToList<T>(DataTable tbl) where T : new()
        {
            // define return list
            List<T> lst = new List<T>();

            // go through each row
            foreach (DataRow r in tbl.Rows)
            {
                // add to the list
                lst.Add(CreateItemFromRow<T>(r));
            }

            // return the list
            return lst;
        }

        public static T CreateItemFromRow<T>(DataRow row) where T : new()
        {
            // create a new object
            T item = new T();

            // set the item
            SetItemFromRow(item, row);

            // return 
            return item;
        }
        public static void SetItemFromRow<T>(T item, DataRow row) where T : new()
        {
            // go through each column
            foreach (DataColumn c in row.Table.Columns)
            {
                // find the property for the column
                PropertyInfo p = item.GetType().GetProperty(c.ColumnName);

                // if exists, set the value
                if (p != null && row[c] != DBNull.Value)
                {
                    p.SetValue(item, row[c], null);
                }
            }
        }

        //getEmp by username
        public static async Task<EMP> GetEmpAsync(String Username )
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>();
            sqlParams.Add(new SqlParameter("Username", Username.Trim().ToLower()));

            DataTable dtLoginRe = await DataAccessAsync.ExecSPAsync("HR.GetEMP", sqlParams);


            //check info
            if (dtLoginRe.Rows.Count == 1)
            {
                List<EMP> emps = DataTableToList<EMP>(dtLoginRe);
                return  emps.FirstOrDefault<EMP>();
            }
            else
            {
                return null;
            }
        }
        //setCustomer
        public static async Task SetCustomerAsync(Customers customers)
        {
            try
            {
                List<SqlParameter> sqlParams = new List<SqlParameter>();
                sqlParams.Add(new SqlParameter("name", customers.CompanyName));
                sqlParams.Add(new SqlParameter("phone", customers.Phone));
                DataTable dtLoginRe = await DataAccessAsync.ExecSPAsync("sales.setcustomer", sqlParams);
            }catch(Exception e)
            {
                MessageBox.Show( "لطفا مقادیر را برسی نمایید  " + "\n"+ e.Message.ToString() ,
                                "خطا",
                                MessageBoxButtons.OK,
                                MessageBoxIcon.Error);
            }
        }
        //get list of Customer
        public static async Task<List<Customers>> GetCustomersAsync()
        {
            List<Customers> customers = new List<Customers>();
            
            DataTable dtCustomers = await DataAccessAsync.ExecSPAsync("sales.getcustomers");
            customers= DataTableToList<Customers>(dtCustomers);


            return customers;
        }

        // get list of product
        public static async Task<List<Product>> GetProductsAsync()
        {
            List<Product> products = new List<Product>();

            DataTable dtCustomers = await DataAccessAsync.ExecSPAsync("Production.getproduct");
            products = DataTableToList<Product>(dtCustomers);


            return products;
        }

        // get list of category
        public static async Task<List<Category>> GetCategoryAsync()
        {
            List<Category> categories = new List<Category>();

            DataTable dtCustomers = await DataAccessAsync.ExecSPAsync("Production.getcategory");
            categories = DataTableToList<Category>(dtCustomers);


            return categories;
        }
        // get list of supliers
        public static async Task<List<Suppliers>> GetSupliersAsync()
        {
            List<Suppliers> suppliers = new List<Suppliers>();

            DataTable dt = await DataAccessAsync.ExecSPAsync("Production.getsupliers");
            suppliers = DataTableToList<Suppliers>(dt);


            return suppliers;
        }

        //uncompited
        public static async Task<List<OrderDetail>> GetOrderDetailsAsync(Orders orders)
        {
            List<OrderDetail> orderDetails = new List<OrderDetail>();

            List<SqlParameter> sql = new List<SqlParameter>();
            sql.Add(new SqlParameter("OrderId", orders.OrderId));
            DataTable dtOrderDetail = await DataAccessAsync.ExecSPAsync("Sales.getOrderDetails", sql);

            orderDetails = DataTableToList<OrderDetail>(dtOrderDetail);


            return orderDetails;
        }
        // setProduct
        public static async Task SetProductAsync(Product product)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>();
            sqlParams.Add(new SqlParameter("code",product.ProuductCode));
            sqlParams.Add(new SqlParameter("name", product.ProductName));
            sqlParams.Add(new SqlParameter("supli", product.SupplierId));
            sqlParams.Add(new SqlParameter("category", product.CategoryId));
            sqlParams.Add(new SqlParameter("unitpricesale", product.UnitPriceSales));
            sqlParams.Add(new SqlParameter("unitpricebuy", product.UnitPriceBuy));
            sqlParams.Add(new SqlParameter("discount", product.Discount));
            sqlParams.Add(new SqlParameter("tax", product.Tax));
            sqlParams.Add(new SqlParameter("qty", product.Qty));

            await DataAccessAsync.ExecSPAsync("Production.setproduct", sqlParams);            
        }
        //update product
        public static async Task UpdateProductAsync(Product product)
        {
            List<SqlParameter> sqlParams = new List<SqlParameter>();
            sqlParams.Add(new SqlParameter("productid", product.ProductId));
            sqlParams.Add(new SqlParameter("code", product.ProuductCode));
            sqlParams.Add(new SqlParameter("name", product.ProductName));
            sqlParams.Add(new SqlParameter("supli", product.SupplierId));
            sqlParams.Add(new SqlParameter("category", product.CategoryId));
            sqlParams.Add(new SqlParameter("unitpricesale", product.UnitPriceSales));
            sqlParams.Add(new SqlParameter("unitpricebuy", product.UnitPriceBuy));
            sqlParams.Add(new SqlParameter("discount", product.Discount));
            sqlParams.Add(new SqlParameter("tax", product.Tax));
            sqlParams.Add(new SqlParameter("qty", product.Qty));

            await DataAccessAsync.ExecSPAsync("Production.updateProduct", sqlParams);
        }
        // setOrderDetails
        public static async Task SetOrderDetailAsync(List<OrderDetail> orderDetails, int orderId)
        {
            List<Product> products = await GetProductsAsync();
            foreach(OrderDetail orderDetail in orderDetails)
            {
                if(products.Find(x => x.ProductId == orderDetail.ProductId).Equals(null))
                {
                    throw new Exception(String.Format("محصول وجود ندارد لطفا بررسی نمایید"));
                }
                else if (orderDetail.qty <= products.Where(x => x.ProductId == orderDetail.ProductId).FirstOrDefault<Product>().Qty)
                {
                    List<SqlParameter> sqlParams = new List<SqlParameter>();
                    sqlParams.Add(new SqlParameter("orderid", orderId));
                    sqlParams.Add(new SqlParameter("productid", orderDetail.ProductId));
                    sqlParams.Add(new SqlParameter("unitpricesales", orderDetail.UnitPriceSale));
                    sqlParams.Add(new SqlParameter("unitpricebuy", orderDetail.UnitPriceBuy));
                    sqlParams.Add(new SqlParameter("discount", orderDetail.discount));
                    sqlParams.Add(new SqlParameter("qty", orderDetail.qty));
                    sqlParams.Add(new SqlParameter("tax", orderDetail.Tax));
                    await DataAccessAsync.ExecSPAsync("sales.setorderdetails", sqlParams);

                }
                else if(orderDetail.qty > products.Where(x => x.ProductId == orderDetail.ProductId).FirstOrDefault<Product>().Qty)
                {
                    throw new Exception(String.Format( "محصول {0} به تعداد کافی موجود نمی باشد",
                        products.Where(x => x.ProductId == orderDetail.ProductId).FirstOrDefault<Product>().ProductName));
                }


            }
        }
        //  set or update product qty 
        public static async Task CheckAndSetProduct(Product product)
        {
            List<Product> products = await GetProductsAsync();
            foreach(Product pro in products)
            {

                if (pro.ProuductCode == product.ProuductCode)
                {
                    List<SqlParameter> sqlParams = new List<SqlParameter>();
                    sqlParams.Add(new SqlParameter("productid", pro.ProductId));
                    sqlParams.Add(new SqlParameter("code", pro.ProuductCode));
                    sqlParams.Add(new SqlParameter("name", pro.ProductName));
                    sqlParams.Add(new SqlParameter("supli", pro.SupplierId));
                    sqlParams.Add(new SqlParameter("category", pro.CategoryId));
                    sqlParams.Add(new SqlParameter("unitpricesale", pro.UnitPriceSales));
                    sqlParams.Add(new SqlParameter("unitpricebuy", pro.UnitPriceBuy));
                    sqlParams.Add(new SqlParameter("discount", pro.Discount));
                    sqlParams.Add(new SqlParameter("tax", pro.Tax));
                    sqlParams.Add(new SqlParameter("qty", product.Qty + pro.Qty));

                    await DataAccessAsync.ExecSPAsync("Production.updateProduct", sqlParams);
                    return;
                }
            }
            await SetProductAsync(product);
            return;
        }
        // set Order , order details and get order
        public static async Task<Orders> SetOrderAsync(Orders orders, List<OrderDetail> orderDetail)
        {
            Orders orderRes = new Orders();

            try
            {

                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("custid", orders.CustId));
                sqlParameters.Add(new SqlParameter("empid", orders.EmpId));
                sqlParameters.Add(new SqlParameter("orderDate", orders.OrderDate));
                sqlParameters.Add(new SqlParameter("profit", orders.Profit));
                sqlParameters.Add(new SqlParameter("amountsell", orders.AmountSell));
                sqlParameters.Add(new SqlParameter("amountbuy", orders.AmountBuy));

                DataTable dtRes = await DataAccessAsync.ExecSPAsync("sales.setorder", sqlParameters);
                orderRes = DataTableToList<Orders>(dtRes).FirstOrDefault<Orders>();


                await SetOrderDetailAsync(orderDetail, orderRes.OrderId);
                return orderRes;

            }
            catch(Exception ex)
            {
                await DeleteOrderAsync(orderRes);
                throw ex;
            }

        }
        // delete order and orderdetails
        public static async Task DeleteOrderAsync(Orders orders)
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("orderid", orders.OrderId));
            
            await DataAccessAsync.ExecSPAsync("sales.deleteorder", sqlParameters);


        }

       // findOrder by code
        public static async Task<List<Orders>> GetOrdersAsync(int code)
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("orderid", code));

            DataTable dtRes = await DataAccessAsync.ExecSPAsync("", sqlParameters);
            return DataTableToList<Orders>(dtRes);

        }
        //getOrders by time
        public static async Task<List<Orders>> GetOrdersAsync(DateTime time1 , DateTime time2 ,int empId)
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("time1", time1));
            sqlParameters.Add(new SqlParameter("time2", time2));
            sqlParameters.Add(new SqlParameter("empid", empId));

            DataTable dtRes = await DataAccessAsync.ExecSPAsync("sales.getorderbytime", sqlParameters);
            return DataTableToList<Orders>(dtRes);

        }

        // check for product qty
        public static async Task<bool> CheckProductQtyAndSet(List<Product> products , Product product)
        {
            foreach (Product produc in products)
            {
                if(produc.ProductId == product.ProductId)
                {
                    if (produc.Qty > product.Qty)
                    {
                        
                        List<SqlParameter> sqlParameters = new List<SqlParameter>();
                        sqlParameters.Add(new SqlParameter("productId", product.ProductId));
                        sqlParameters.Add(new SqlParameter("qty", product.Qty));

                        await DataAccessAsync.ExecSPAsync("Production.decreaseproduct", sqlParameters);
                        return true;
                    }
                    else
                        return false;
                }

            }
            return false;
        }

        //uncompited change number of proudut 
        public static async Task<bool> DecreaseProduct(Product product)
        {
            List<Product> productCheck = await GetProductsAsync();

            if (await CheckProductQtyAndSet(productCheck, product))
            {
                return true;
            }
            else
                return false;
        }

        //get cust by id
        public static async Task<List<Customers>> GetCustomersAsync(int id)
        {
            List<Customers> customers = new List<Customers>();

            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("custid", id));
            DataTable dtCustomers = await DataAccessAsync.ExecSPAsync("sales.getcustomersbyid", sqlParameters);
            customers = DataTableToList<Customers>(dtCustomers);


            return customers;
        }

        public static decimal AmountOfBuy(List<OrderDetail> orderDetails)
        {
            decimal amount = 0;
            foreach (OrderDetail od in orderDetails)
            {
                amount += od.UnitPriceBuy*od.qty;
            }
            return amount;
        }
        //Amount sale with  tax and discount
        public static decimal AmountOfSale(List<OrderDetail> orderDetails)
        {
            decimal amount = 0;
            foreach (OrderDetail od in orderDetails)
            {
                amount +=( od.UnitPriceSale
                    - od.UnitPriceSale * Convert.ToDecimal( od.discount)
                    - od.UnitPriceSale * Convert.ToDecimal(od.Tax))
                    * od.qty;
            }
            return amount;
        }

        public static decimal porfit(List<OrderDetail> orderDetails)
        {
            decimal profit = AmountOfSale(orderDetails) - AmountOfBuy(orderDetails);
            
            return profit;
        }
        
        public static int TotalOfQty(List<OrderDetail> orderDetails)
        {
            return orderDetails.Sum(x => x.qty);

        }
        //set category
        public static async Task SetCategoryAsync(Category category)
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();

            sqlParameters.Add(new SqlParameter("name",category.CategoryName));
            sqlParameters.Add(new SqlParameter("desc",category.Description));
            await DataAccessAsync.ExecSPAsync("Production.setcategory", sqlParameters);

        }
        //set suplier
        public static async Task SetSuplierAsync(Suppliers supplier)
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();

            sqlParameters.Add(new SqlParameter("name", supplier.CompanyName));
            sqlParameters.Add(new SqlParameter("phone", supplier.Phone));
            await DataAccessAsync.ExecSPAsync("Production.setsuplier", sqlParameters);

        }
        //delete product 
        public static async Task DeleteProduct(Product product)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("productId", product.ProductId));
                await DataAccessAsync.ExecSPAsync("Production.deleteProduct", sqlParameters);
            }
            catch(Exception ex)
            {
                throw new Exception(String.Format("امکان حذف وجود ندارد می توانید مقدار محصول را به صفر تغییر دهید "+ ex.Message));
            }

            
        }
        //delete suplier
        public static async Task DeleteSupplier(Suppliers suppliers)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("supId", suppliers.SupplierId));
                await DataAccessAsync.ExecSPAsync("Production.deleteSupplier", sqlParameters);

            }catch(Exception ex)
            {
                throw new Exception("امکان حدف فروشنده وجود ندارد ");
            }
        }
        //delete category
        public static async Task DeleteCategory(Category category)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("catId", category.CategoryId));
                await DataAccessAsync.ExecSPAsync("Production.deleteCategory", sqlParameters);

            }
            catch (Exception ex)
            {
                throw new Exception("امکان حدف دسته بندی وجود ندارد ");
            }
        }
        //set emp uncompited
        public static async Task<String> SetEmp(EMP emp)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("company", emp.Company));
                sqlParameters.Add(new SqlParameter("first", emp.FirstName));
                sqlParameters.Add(new SqlParameter("last", emp.LastName));
                sqlParameters.Add(new SqlParameter("hire", emp.HireDate));
                sqlParameters.Add(new SqlParameter("title", emp.Title));

                DataTable table = await DataAccessAsync.ExecSPAsync("HR.setEmp", sqlParameters);
                return table.Rows[0][0].ToString();

            }
            catch (Exception ex)
            {
                throw new Exception("خطا در ثبت مشخصات کارمند " + ex.Message);
            }
        }

    }
}
