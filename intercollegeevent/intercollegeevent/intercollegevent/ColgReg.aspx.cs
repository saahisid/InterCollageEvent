using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;

namespace intercollege
{
    public partial class ColgReg : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        private static Random random = new Random();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            string filename = string.Empty;
            string imagename = string.Empty;
            string imgFileType = string.Empty;
           
            if (FileUploadimage.HasFile)
            {
                imagename = DateTime.Now.ToString("MM-dd-yyyy_HHmmss");
                imgFileType = Path.GetExtension(FileUploadimage.FileName).ToString().ToLower();
                FileUploadimage.SaveAs(Server.MapPath("~/uploads/colimg/" + imagename + imgFileType));
            }


            string pass = RandomString(8);

            cmd.Parameters.AddWithValue("@clgid", Convert.ToInt32(ddlcollege.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@addr", txtadd.Text);
            cmd.Parameters.AddWithValue("@contact", txtcon.Text);
            cmd.Parameters.AddWithValue("@alt", txtalt.Text);
            cmd.Parameters.AddWithValue("@email", txtemail.Text);
            cmd.Parameters.AddWithValue("@long", txtlon.Text);
            cmd.Parameters.AddWithValue("@lat", txtlan.Text);
            cmd.Parameters.AddWithValue("@colgcode", txtcolgcode.Text);
            cmd.Parameters.AddWithValue("@imagename", "uploads/colimg/" + imagename + imgFileType);
            cmd.Parameters.AddWithValue("@status", "Active");

            cmd.Parameters.AddWithValue("@pass", txtcolgcode0.Text);

            cmd.CommandText = "insert into tblcolg_detail(colg_id,address,contact,contact2,email_id,photopath,lattitude,longitude,colg_pass,status,colg_code) "
            + "values(@clgid,@addr,@contact,@alt,@email,@imagename,@lat,@long,@pass,@status,@colgcode)";

            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Registration success!!lOGIN WITH OUR EMAIL AND PASSWORD');", true);
                clearform();
            }
        }

        public void clearform()
        {
            txtadd.Text = "";
            txtcon.Text = "";
            txtalt.Text = "";
            txtemail.Text = "";
            txtlon.Text = "";
            txtlan.Text = "";

        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            clearform();
        }

        protected void txtemail_TextChanged(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "Select * from tblcolg_detail where email_id='"+txtemail.Text+"'";
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

        protected void txtcolgcode_TextChanged(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "Select * from  tblcolg_detail where colg_code='" +txtcolgcode.Text + "'";
            
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