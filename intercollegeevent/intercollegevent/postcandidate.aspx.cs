using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;

namespace intercollege
{
    public partial class postcandidate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        int candidateid = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
           
           
         
        }

       
     
      
        }
    }
