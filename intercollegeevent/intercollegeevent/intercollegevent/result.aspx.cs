using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;

namespace intercollege
{
    public partial class result : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        int eventid = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                eventid = Convert.ToInt32(Request.QueryString["id"].ToString());

                loadcomments(eventid);
            }
        }

        public void loadcomments(int eventid)
        {
            if (con.State != System.Data.ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            cmd.CommandText = "select * from dbo.tblcomment inner join tbl_student on tblcomment.postedby = tbl_student.studid where tblcomment.eventid="+eventid;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnpost_Click(object sender, EventArgs e)
        {
            eventid = Convert.ToInt32(Request.QueryString["id"].ToString());
            if (con.State != System.Data.ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@comments", txtpost.Text);
            cmd.Parameters.AddWithValue("@posteddate", DateTime.Now);
            cmd.Parameters.AddWithValue("@eventid", eventid);
            cmd.Parameters.AddWithValue("@postedby", Convert.ToInt32(Session["id"].ToString()));

            cmd.CommandText = "insert into dbo.tblcomment(postedby,postedon,comments,eventid) values(@postedby,@posteddate,@comments,@eventid)";
            int j = cmd.ExecuteNonQuery();
            if (j > 0)
            {
                HttpFileCollection imageCollection = Request.Files;

                for (int i = 0; i < imageCollection.Count; i++)
                {

                    HttpPostedFile uploadimages = imageCollection[i];

                    string fileName = Path.GetFileName(uploadimages.FileName);

                    uploadimages.SaveAs(Server.MapPath("~/uploads/") + fileName);

                    SqlCommand cmd1 = new SqlCommand();
                    cmd1.Connection = con;

                    cmd1.Parameters.AddWithValue("@filepath", "uploads/" + fileName);
                    cmd1.Parameters.AddWithValue("@eventid", eventid);
                    cmd1.CommandText = "insert into dbo.tblgallery(photolink,eventid) values (@filepath,@eventid)";
                    int k = cmd1.ExecuteNonQuery();

                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "ïnfo", "alert('Success!! Comment Posted');window.location='result.aspx?id=" + eventid + "';", true);
                }
            }
            
        }
    }
}