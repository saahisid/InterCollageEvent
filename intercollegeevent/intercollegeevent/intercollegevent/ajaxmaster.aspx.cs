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
    public partial class ajaxmaster : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["candidateid"] as string))
            {
                int candidateid = Convert.ToInt32(Request.QueryString["candidateid"].ToString());
                int studid = Convert.ToInt32(Request.QueryString["studid"].ToString());
                int postid = Convert.ToInt32(Request.QueryString["postid"].ToString());

                if (con.State != System.Data.ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.Parameters.AddWithValue("@candidateid", candidateid);
                cmd.Parameters.AddWithValue("@studid", studid);
                cmd.Parameters.AddWithValue("@postid", postid);

                cmd.CommandText = "select * from tblresult where postid=@postid and stuid=@studid";
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    //ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Already Voted..');", true);
                    Response.Write("Already Voted..");
                }
                else
                {
                    cmd.CommandText = "insert into tblresult (postid,candidateid,stuid)  values(@postid,@candidateid,@studid)";
                    int i = cmd.ExecuteNonQuery();
                    if (i > 0)
                    {
                        Response.Write("success");
                    }
                    else
                    {
                        Response.Write("error");
                    }
                }
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["eventid"] as string))
            {
                int eventid = Convert.ToInt32(Request.QueryString["eventid"].ToString());
                int studid = Convert.ToInt32(Request.QueryString["studid"].ToString());

                if (con.State != System.Data.ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.Parameters.AddWithValue("@eventid", eventid);
                cmd.Parameters.AddWithValue("@studid", studid);

                cmd.CommandText = "select * from dbo.tbleventparticipate where eventid=@eventid and studid=@studid";
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    //ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Already Participated..');", true);
                    Response.Write("Already Participated..");
                }
                else
                {
                    cmd.CommandText = "insert into tbleventparticipate (eventid,studid)  values(@eventid,@studid)";
                    int i = cmd.ExecuteNonQuery();
                    if (i > 0)
                    {
                        Response.Write("success");
                    }
                    else
                    {
                        Response.Write("error");
                    }
                }
            }
        }
    }
}