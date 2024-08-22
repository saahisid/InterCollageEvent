using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Text;

namespace intercollege
{
    public partial class verifyclg : System.Web.UI.Page
        {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
                protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gvclg_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "aprve")
            {
                int colgid = Convert.ToInt32(e.CommandArgument.ToString());
                updatestatus("Active", colgid);

            }
            else if (e.CommandName == "deny")
            {
                int colgid = Convert.ToInt32(e.CommandArgument.ToString());
                updatestatus("Disapproved", colgid);
            }

        }

        public void updatestatus(string status, int clgid)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@clgid", clgid);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.CommandText = "update tblcolg_detail set status=@status where colg_id=@clgid";
            int i = cmd.ExecuteNonQuery();

            if (i > 0)
            {

                cmd.CommandText = "Select * from tblcolg_detail where colg_id=@clgid";
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                string email = dt.Rows[0]["email_id"].ToString();
                string pass = dt.Rows[0]["colg_pass"].ToString();
                // var fromAddress = "intercoad@gmail.com";
                //  var toAddress = email ;
                const string fromPassword = "9768200910";
                DateTime Date = DateTime.Now;
                string subject = "'Inter College Event Calender - Account Information'";
                string body = "From: Inter College Event Calender \n";
                if (status == "Active")
                {
                    body += "Congradulations!! Your Account is verified by University and its Activated on  " + Date + "\n";
                    body += "Your Login Email is " + email + "\n";
                    body += "Your Login Password is " + pass + "\n";
                    body += "Please make changes to your password as soon as you log in.\n";
                }
                else if (status == "Disapproved")
                {
                    body += "Your Account is verified by University and its Disapproved on  " + Date + "\n";
                    body += "Please Contact University Admin for Furthure details\n";
                }

                body += "Thank you";

                string to = email; //To address    
                string from = "adnansayed465@gmail.com"; //From address    
                System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage(from, to);

                //string mailbody = "OTP  " + otp;
                message.Subject = "Email from INTERCOLLEGE EVENT MANAGMENT ADMIN ";
                message.Body = body;
                message.BodyEncoding = Encoding.UTF8;
                message.IsBodyHtml = true;
                System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587); //Gmail smtp    
                System.Net.NetworkCredential basicCredential1 = new
                System.Net.NetworkCredential("adnansayed465@gmail.com", "9768200910");
                client.EnableSsl = true;

                client.UseDefaultCredentials = false;
                client.Credentials = basicCredential1;
                try
                {
                    client.Send(message);
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Mail Updated...');", true);
                }

                catch (Exception ex)
                {
                    throw ex;
                } 
            //    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Updated...');", true);
                gvclg.DataBind();
            }
        }
        

        private void BindMail(string uname, string status, string newpass)
        {
        }
    }
}