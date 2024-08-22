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
    public partial class manageCourse : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["type"] == null)
            {
                Response.Redirect("login.aspx");
            }
        }
 

        protected void btnadd_Click1(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@course_name", txtcou.Text);
            cmd.CommandText = "insert into tbl_course(course_name) values(@course_name)";
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Added...');", true);
                txtcou.Text = "";
                gvcourse.DataBind();
            }

        }

        protected void gvcourse_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                int courseid = Convert.ToInt32(e.CommandArgument.ToString());
                if (con.State != ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@courseid", courseid);
                cmd.CommandText = "delete from tbl_course where courseid=@courseid";
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Deleted...');", true);
                    txtcou.Text = "";
                    gvcourse.DataBind();
                }

            }
        }

        protected void txtcou_TextChanged(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@course", txtcou.Text);
            cmd.CommandText = "select * from tbl_course where LOWER(course_name)=Lower(@course)";
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Already Exist..');", true);
                txtcou.Text = "";
                txtcou.Focus();
            }
        }
    }
}