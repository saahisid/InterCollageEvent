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
    public partial class event_detail : System.Web.UI.Page
    {
       
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {

            if (con.State != ConnectionState.Open)
                con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@event_id", Convert.ToInt32(ddlevent.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@event_schedule", txtevent.Text);
            cmd.CommandText = "insert into tblevent_result(event_id,event_result) values(@event_id,@event_schedule)";
           
           int i = cmd.ExecuteNonQuery();
           if (i > 0)
           {
               ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! ');", true);
              
           }
        }
    }
}