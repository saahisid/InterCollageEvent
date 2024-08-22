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

namespace intercollege
{
    public partial class forgot : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        private static Random random = new Random();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtuser_TextChanged(object sender, EventArgs e)
        {
            string email = txtuser.Text;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@email", email);
            cmd.CommandText = "select * from dbo.tblcolg_detail where email_id=@email";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Email Not Registered!!')", true);
                txtuser.Text = "";
                txtuser.Focus();
            }
           
        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            string pass = RandomString(8);
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "update dbo.tblcolg_detail set colg_pass='" + pass + "' where email_id='" + txtuser.Text + "'";
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i > 0)
            {
                try
                {
                    BindMail(txtuser.Text, pass);
                }
                catch (Exception ex)
                {

                }
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "success", "alert('Your Updated Password has been sent to your Registred Email account');", true);
                btnlogin.Enabled = false;
                txtuser.Text = "";
            }
        }

        private void BindMail(string uname, string newpass)
        {
            var fromAddress = "technoinfo29@gmail.com";
            var toAddress = uname;
            const string fromPassword = "reset@123";
            DateTime Date = DateTime.Now;
            string subject = "'Inter College Event Calender -Forgot Password'";
            string body = "From: Inter College Event Calender \n";
            body += "We have recieved your request to reset the login Password on  " + Date + "\n";
            body += "Your New Password is " + newpass + "\n";
            body += "Please make changes to your password as soon as you log in.\n";
            body += "Thank you";

            var smtp = new System.Net.Mail.SmtpClient();
            {
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                smtp.Credentials = new NetworkCredential(fromAddress, fromPassword);
                smtp.Timeout = 20000;
            }
            smtp.Send(fromAddress, toAddress, subject, body);
        }

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}