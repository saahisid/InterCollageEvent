﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class MasterPage : System.Web.UI.MasterPage
{
   SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        
    protected void Page_Load(object sender, EventArgs e)
    {
        

        

    }
    protected void btnlogin_Click(object sender, EventArgs e)
    {
     if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "Select * from tbl_admin where uname='" + txtuname.Text + "' and upass='" + txtupass.Text + "'";
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Session["type"] = "admin";
                Session["uname"] = dt.Rows[0]["full_name"].ToString();
                Session["id"] = dt.Rows[0]["adminid"].ToString();

                Response.Redirect("manageCourse.aspx");
            }
        
        else
        {
            lbllogin.Text = "Invalid User !!";
        }
    }
  
}
