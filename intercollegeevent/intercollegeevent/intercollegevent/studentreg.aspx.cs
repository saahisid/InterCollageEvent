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
    public partial class studentreg1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        int studid = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["stid"] != null)
            {
                studid = Convert.ToInt32(Request.QueryString["stid"].ToString());
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
                 btnsubmit.Text = "Update";
             }

        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {

            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con; 
            string  gender = string.Empty;
            if (radmale.Checked)
                gender = "male";
            else if (radfemale.Checked)
                gender = "female";

       
            cmd.Parameters.AddWithValue("@studentname", txtstuname.Text);
            cmd.Parameters.AddWithValue("@regno", txtreg.Text);
            cmd.Parameters.AddWithValue("@gender", gender);
            cmd.Parameters.AddWithValue("@year", lstyear.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@contact", textcon.Text);
            cmd.Parameters.AddWithValue("@email", txtemail.Text);
            cmd.Parameters.AddWithValue("@course",Convert.ToInt32(lstcousre.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@clgid", Convert.ToInt32(Session["id"].ToString()));

            if (btnsubmit.Text == "Update")
            {
                cmd.Parameters.AddWithValue("@studid", studid);
                cmd.CommandText = "update tbl_student set studname=@studentname,regno=@regno,gender=@gender,admission_year=@year,courseid=@course,contactno=@contact,email_id=@email where studid=@studid";
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! Record Updated.');window.location='view_stud.aspx'", true);
                }
            }
            else
            {
                cmd.CommandText = "insert into tbl_student(colgid,studname,regno,gender,admission_year,courseid,contactno,email_id)" +
                    "values(@clgid,@studentname,@regno,@gender,@year,@course,@contact,@email)";
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! Record Added.');window.location='view_stud.aspx'", true);
                }
            }
            

        }

        protected void btncancle_Click(object sender, EventArgs e)
        {
            txtemail.Text = "";
            txtreg.Text = "";
            txtstuname.Text = "";
            textcon.Text = "";
            lstcousre.SelectedIndex = 0;
            lstyear.SelectedIndex = 0;
        }

        protected void txtreg_TextChanged(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@regno", txtreg.Text);
             cmd.CommandText = "Select * from tbl_student where regno=@regno";
             DataTable dt = new DataTable();
             SqlDataAdapter da = new SqlDataAdapter(cmd);
             da.Fill(dt);
             con.Close();
             if (dt.Rows.Count > 0)
             {
                 ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Registration No. Already Exist');", true);
                 txtreg.Text = "";
                 txtreg.Focus();
             }

        }

        protected void txtemail_TextChanged(object sender, EventArgs e)
        {

             if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "Select * from tbl_student where email_id='" + txtemail.Text + "'";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)

            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Email Id already Registered');", true);
                txtemail.Text = "";
                txtemail.Focus();
             }


        }

       
    }
}