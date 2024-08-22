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
    public partial class view_stud : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gvclg_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                int studid = Convert.ToInt32(e.CommandArgument.ToString());
                if (con.State != ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@studid", studid);
                cmd.CommandText = "delete from tbl_student where studid=@studid";
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Deleted...');", true);
                    gvclg.DataBind();
                }

            }
            else if (e.CommandName == "edit")
            {
                int studid = Convert.ToInt32(e.CommandArgument.ToString());
                Response.Redirect("studentreg.aspx?stid=" + studid);
            }
        }
    }
}