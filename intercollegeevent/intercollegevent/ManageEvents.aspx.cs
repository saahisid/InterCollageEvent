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
    public partial class ManageEvents : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gvevents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                int event_id = Convert.ToInt32(e.CommandArgument.ToString());
                if (con.State != ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@event_id", event_id);
                cmd.CommandText = "delete from tblevent_notice where event_id=@event_id";
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Deleted...');", true);
                    gvevents.DataBind();
                }

            }
            else if (e.CommandName == "edit")
            {
                int event_id = Convert.ToInt32(e.CommandArgument.ToString());
                Response.Redirect("manageEnotice.aspx?event=" + event_id);
            }
        }
    }
}