using AcountingSalesPart.View;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Collections.Specialized;
using System.Threading;

namespace AcountingSalesPart.Controler
{
     public static class DataAccessAsync
    {

        private static bool HostState = true;
        public static async Task<DataTable> ExecSPAsync(string spName, List<SqlParameter> sqlParams = null)
        {
            if (sqlParams == null)
                sqlParams = new List<SqlParameter>();

            SqlConnection conn = new SqlConnection();
            DataTable dt = new DataTable();
            try
            {

                conn.ConnectionString = await SqlConTest() ? System.Configuration.ConfigurationManager.ConnectionStrings["t2"].ConnectionString + "User ID=client;Password=1"
                    : System.Configuration.ConfigurationManager.ConnectionStrings["t1"].ConnectionString + "User ID=client;Password=1";

                //conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["t2"].ConnectionString + "User ID=sa;Password=1";
                //conn.Open();

                FrmProgress frm = new FrmProgress(conn.Open);
                frm.ShowDialog();
                // bild an sql /qu
                SqlCommand cmd = new SqlCommand(spName, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(sqlParams.ToArray());
                //exec command
                SqlCommand command = conn.CreateCommand();
                SqlDataReader dr = await cmd.ExecuteReaderAsync();
                //fil datatable 
                dt.Load(dr);
            }

            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "خطا در پایگاه داده ", MessageBoxButtons.OK, MessageBoxIcon.Error);                
            }
            finally
            {
                //close 
                conn.Close();
            }
            return dt;
        }

        private async static Task<bool> SqlConTest()
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["t2"].ConnectionString + "User ID=client;Password=1";
            if (HostState)
            {
                try
                {
                    CancellationTokenSource source = new CancellationTokenSource();
                    source.CancelAfter(TimeSpan.FromSeconds(5));
                    await conn.OpenAsync(source.Token);
                    return true;
                }
                catch
                {
                    HostState = false;
                    return false;
                }
                finally
                {
                    conn.Close();
                }
            }
            else
                return false;

        }
    }


}
