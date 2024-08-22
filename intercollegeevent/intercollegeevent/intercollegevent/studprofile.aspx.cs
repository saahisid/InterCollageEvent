using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace intercollege
{
    public partial class studprofile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Session["id"] as string))
            {
                int studid = Convert.ToInt32(Session["id"].ToString());
                if (!IsPostBack)
                {
                    fillstudentdata(studid);
                }
            }
            
        }

        public void fillstudentdata(int studid)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@studid", studid);
            cmd.CommandText = "Select * from tbl_student where studid=@studid";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                txtemail.Text = dt.Rows[0]["email_id"].ToString();
                txtstuname.Text = dt.Rows[0]["studname"].ToString();
                textcon.Text = dt.Rows[0]["contactno"].ToString();
                txtreg.Text = dt.Rows[0]["regno"].ToString();
                lstcousre.SelectedValue = dt.Rows[0]["courseid"].ToString();
                lstyear.SelectedValue = dt.Rows[0]["admission_year"].ToString();
                if (dt.Rows[0]["gender"].ToString().Trim() == "Male")
                {
                    radmale.Checked = true;
                    radfemale.Checked = false;
                }
                else
                {
                    radfemale.Checked = true;
                    radmale.Checked = false;
                }
                
            }

        }
    }
}