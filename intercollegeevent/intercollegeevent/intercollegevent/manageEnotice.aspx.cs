using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Globalization;

namespace intercollege
{
    public partial class manageEnotice : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        int eventid = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Session["type"] as string))
            {
                Response.Redirect("index.aspx");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["event"] as string))
            {
                eventid = Convert.ToInt32(Request.QueryString["event"].ToString());
                if (!IsPostBack)
                {
                    filleventdata(eventid);
                }
            }
           
        }

        public void filleventdata(int eventid)
        {
            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@eventid", eventid);
            cmd.CommandText = "Select * from tblevent_notice where event_id=@eventid";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                txtevent.Text = dt.Rows[0]["event_name"].ToString();
                txtdes.Text = dt.Rows[0]["event_desc"].ToString();
               // txtevedate.Text = DateTime.ParseExact((dt.Rows[0]["event_date"]).ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                ddlcolg.SelectedValue = dt.Rows[0]["colgid"].ToString();
              
                if (dt.Rows[0]["event_type"].ToString().Trim() == "Sports")
                {
                    rbsports.Checked = true;
                    rbculture.Checked = false;
                    rbothers.Checked = false;
                }
                else if (dt.Rows[0]["event_type"].ToString().Trim() == "Culture")
                {
                    rbsports.Checked = false;
                    rbculture.Checked = true;
                    rbothers.Checked = false;
                }
                else
                {
                    rbsports.Checked = false;
                    rbculture.Checked = false;
                    rbothers.Checked = true;
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
            string event_type = string.Empty;
            if (rbculture.Checked)
                event_type = "Culture";
            else if (rbsports.Checked)
                event_type = "Sports";
            else
                event_type = "Other";

            string filename = string.Empty;
            if (up_file.HasFile)
            {
                filename = up_file.FileName;
                up_file.SaveAs(Server.MapPath("~/uploads/" + filename));
            }
            else
            {
                if (btnsubmit.Text == "Update")
                {
                    filename = filecopy.HRef;
                    txtevedate.Text = "";
                }
            }

            cmd.Parameters.AddWithValue("@evenname", txtevent.Text);
            cmd.Parameters.AddWithValue("@descrition", txtdes.Text);
           cmd.Parameters.AddWithValue("@eventdate", DateTime.ParseExact(txtevedate.Text,"dd/MM/yyyy",CultureInfo.InvariantCulture));
            cmd.Parameters.AddWithValue("@eventupload", "uploads/" + filename);
            cmd.Parameters.AddWithValue("@colname", Convert.ToInt32(ddlcolg.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@event_type", event_type);
            cmd.Parameters.AddWithValue("@status", "Active");
                          
            if (btnsubmit.Text == "Update")
            {
                cmd.Parameters.AddWithValue("@event", eventid);
                cmd.CommandText = "update tblevent_notice set event_name=@evenname,event_desc=@descrition,event_date=@eventdate,event_file=@eventupload,colgid=@colname,event_type=@event_type where event_id=@event";
                int i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! Record Updated.');window.location='ManageEvents.aspx';", true);
                }
            }
            else
            {
                cmd.CommandText = "insert into tblevent_notice(event_name,event_desc,event_date,event_file,colgid,status,event_type) values(@evenname,@descrition,@eventdate,@eventupload,@colname,@status,@event_type)";
                int i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! Record Added.')", true);
                    clearform();
                }
            }


        }

        public void clearform()
        {
            txtdes.Text = "";
            txtevedate.Text = "";
            txtevent.Text = "";
            ddlcolg.SelectedIndex = 0;
        }
    }
}