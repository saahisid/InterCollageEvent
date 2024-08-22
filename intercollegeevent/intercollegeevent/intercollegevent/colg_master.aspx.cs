using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace intercollege
{
    public partial class colg_master : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["type"] == null)
            {
                Response.Redirect("index.aspx");
            }
            else if (Session["type"].ToString() != "admin")
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void btnadd_Click1(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@college", txtcollege.Text);
            cmd.Parameters.AddWithValue("@clgcode", txtcolgcode.Text);

            cmd.CommandText = "insert into tbl_College(colgname,college_code) values(@college,@clgcode)";
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Added...');", true);
                txtcollege.Text = "";
                gvcollege.DataBind();
            }
        }

        protected void gvcollege_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                int clgid = Convert.ToInt32(e.CommandArgument.ToString());
                if (con.State != ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@college", clgid);
                cmd.CommandText = "delete from tbl_College where colgid=@college";
                int i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Deleted...');", true);
                    txtcollege.Text = "";
                    gvcollege.DataBind();
                }
            }
        }

        protected void txtcolgcode_TextChanged(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "Select * from tbl_College where college_code ='" + txtcolgcode.Text + "'";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('code error');", true);
                txtcolgcode.Text = "";
                txtcolgcode.Focus();
            }    

        }

        
    }
}