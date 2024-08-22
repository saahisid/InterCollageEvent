using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace intercollege
{
    public partial class collegeevent : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["type"] != null)
            {
                if (Session["type"].ToString() == "admin")
                {
                    admin_menu.Visible = true;
                    user_menu.Visible = false;
                    menu.Visible = false;
                    stud_menu.Visible = false;
                }
                else if (Session["type"].ToString() == "colg")
                {
                    user_menu.Visible = true;
                    admin_menu.Visible = false;
                    menu.Visible = false;
                    stud_menu.Visible = false;
                }
                else if (Session["type"].ToString() == "stud")
                {
                    user_menu.Visible = false;
                    admin_menu.Visible = false;
                    menu.Visible = false;
                    stud_menu.Visible = true;
                }
                else
                {
                    menu.Visible = true;
                    admin_menu.Visible = false;
                    user_menu.Visible = false;
                    stud_menu.Visible = false;
                }
            }
            else
            {
                menu.Visible = true;
                admin_menu.Visible = false;
                user_menu.Visible = false;
                stud_menu.Visible = false;
            }
        }
    }
}