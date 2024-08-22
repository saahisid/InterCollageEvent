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
    public partial class CollegeProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Session["type"] as string))
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    int clgid = Convert.ToInt32(Session["id"].ToString());
                    loadCollege(clgid);
                }
            }
        }

        public void loadCollege(int colgid)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@colgid", colgid);
            cmd.CommandText = "Select * from tblcolg_detail where colg_id=@colgid";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                txtadd.Text = dt.Rows[0]["address"].ToString();
                txtcolgcode.Text = dt.Rows[0]["colg_code"].ToString();
                txtcon.Text = dt.Rows[0]["contact"].ToString();
                txtemail.Text = dt.Rows[0]["email_id"].ToString();
                txtalt.Text = dt.Rows[0]["contact2"].ToString();
                txtlan.Text = dt.Rows[0]["longitude"].ToString();
                txtlon.Text = dt.Rows[0]["lattitude"].ToString();
                Image1.ImageUrl = dt.Rows[0]["photopath"].ToString();
            }
        }

        protected void btnupdateprofile_Click1(object sender, EventArgs e)
        {
            update_div.Visible = true;
            up_prof.Visible = false;
            tblprof1.Enabled = true;
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            string filename = string.Empty;
            string imagename = string.Empty;

             if (FileUploadimage.HasFile)
             {
                imagename = DateTime.Now.ToString("MM-dd-yyyy_HHmmss");
                string imgFileType = Path.GetExtension(FileUploadimage.FileName).ToString().ToLower();
                FileUploadimage.SaveAs(Server.MapPath("~/uploads/colimg/" + imagename + imgFileType));
                filename = "uploads/colimg/" + imagename + imgFileType;
             }
             else
             {
                 filename = Image1.ImageUrl;
             }
            cmd.Parameters.AddWithValue("@clgid", Convert.ToInt32(Session["id"].ToString()));
            cmd.Parameters.AddWithValue("@addr", txtadd.Text);
            cmd.Parameters.AddWithValue("@contact", txtcon.Text);
            cmd.Parameters.AddWithValue("@alt", txtalt.Text);
            cmd.Parameters.AddWithValue("@email", txtemail.Text);
            cmd.Parameters.AddWithValue("@long", txtlon.Text);
            cmd.Parameters.AddWithValue("@lat", txtlan.Text);
            cmd.Parameters.AddWithValue("@colgcode", txtcolgcode.Text);
            cmd.Parameters.AddWithValue("@imagename", filename);

            cmd.CommandText = "update tblcolg_detail SET address=@addr,contact=@contact,contact2=@alt,email_id=@email,photopath=@imagename,lattitude=@lat,longitude=@long,colg_code=@colgcode where colg_id=@clgid";

            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Profile Updated.');", true);
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("CollegeProfile.aspx");
        }

        
    }
}