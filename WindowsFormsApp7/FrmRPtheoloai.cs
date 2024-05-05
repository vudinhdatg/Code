using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using System.Data.SqlClient;
namespace WindowsFormsApp7
{
    public partial class FrmRPtheoloai : Form
    {
        public FrmRPtheoloai()
        {
            InitializeComponent();
        }
        private string theloai;
        private void crystalReportViewer1_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["db_qlbs"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    cnn.Open();
                    cmd.CommandText = "timkiem_theoloaisach";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@theloai", theloai);

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    RpHoaDon r = new RpHoaDon();
                    r.SetDataSource(dt);
                    FrmRp f = new FrmRp();
                    crystalReportViewer1.ReportSource = r;
                    crystalReportViewer1.Refresh();

                    cnn.Close();
                }
            }
        }
    }
}
