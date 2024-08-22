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
    public partial class uploadCerti : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Session["type"] as string))
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            int eventid = Convert.ToInt32(ddlevent.SelectedValue.ToString());
            HttpFileCollection imageCollection = Request.Files;

            for (int i = 0; i < imageCollection.Count; i++)
            {

                HttpPostedFile uploadimages = imageCollection[i];

                string fileName = Path.GetFileName(uploadimages.FileName);

                uploadimages.SaveAs(Server.MapPath("~/uploads/") + fileName);
                if (con.State != ConnectionState.Open)
                    con.Open();
                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = con;

                cmd1.Parameters.AddWithValue("@filepath", "uploads/" + fileName);
                cmd1.Parameters.AddWithValue("@eventid", eventid);

                cmd1.Parameters.AddWithValue("@colgid", Convert.ToInt32(ddlcollege.SelectedValue.ToString()));
                cmd1.CommandText = "insert into dbo.tblcertficate(eventid,certificate,colgid) values (@eventid,@filepath,@colgid)";
                int k = cmd1.ExecuteNonQuery();
            }
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "ïnfo", "alert('Success!! Comment Posted');", true);

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                int fileid = Convert.ToInt32(e.CommandArgument.ToString());
                if (con.State != ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@fileid", fileid);
                cmd.CommandText = "delete from dbo.tblcertficate where fileid=@fileid";
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Deleted...');", true);
                    GridView1.DataBind();
                }

            }
        }
    }
}