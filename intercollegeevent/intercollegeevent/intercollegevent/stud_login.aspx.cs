using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net;
using System.IO;

namespace intercollege
{
    public partial class stud_login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = ("hii");
        }

        protected void txtregno_TextChanged(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@regno", txtregno.Text);
            cmd.CommandText = "Select * from tbl_student where regno=@regno";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            int studid = 0;
            if (dt.Rows.Count > 0)
            {
                studid = Convert.ToInt32(dt.Rows[0][0].ToString());
                string contact = dt.Rows[0]["contactno"].ToString();
                string numbers = "1234567890";

                string characters = numbers;
                int length = 5;
                string otp = string.Empty;
                for (int i = 0; i < length; i++)
                {
                    string character = string.Empty;
                    do
                    {
                        int index = new Random().Next(0, characters.Length);
                        character = characters.ToCharArray()[index].ToString();
                    } while (otp.IndexOf(character) != -1);
                    otp += character;
                }
         
               bindSMS(contact, otp);
                Session["otp"] = otp;
                Session["dt"] = dt;
                otp_msg.Visible = true;
                txtotp.Visible = true;
                txtregno.Enabled = false;
              //  txtotp.Attributes["value"] = otp;
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Registration No. doesn't Exist');", true);
                txtregno.Text = "";
                txtregno.Focus();
            }

        }

      
        
      

       

        protected void btnlogin_Click(object sender, EventArgs e)
        {
           
        }

       
    }
}