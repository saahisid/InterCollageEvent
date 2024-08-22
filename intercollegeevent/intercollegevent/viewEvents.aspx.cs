using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace intercollege
{
    public partial class viewEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void gvevents_SelectedIndexChanged(object sender, System.EventArgs e)
        {

            GridViewRow r = gvevents.SelectedRow;
            Response.Redirect("result.aspx?id=" + r.Cells[1].Text );



        }
    }
}