<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="intercollege.index" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .second-slide
        {
            width: 837px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

			<div class="carousel-inner" role="listbox">
				

				<div class="item">
					<img class="second-slide" src="images/c.jpg" alt="Second Slide">
				</div>

				<div class="item">
					&nbsp;</div>

			</div>
		</div>

         <div class="container">
            <div class="services slideanim" id="services">
                <h3><center>Events</center></h3>
                
                <%
                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
                        if (con.State != System.Data.ConnectionState.Open)
                            con.Open();
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        cmd.CommandText = "SELECT * FROM tblevent_notice where status='Active' order by event_id desc";
                        DataTable dt = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                         
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                cmd.CommandText = "SELECT * FROM tblevent_notice where event_id=" + Convert.ToInt32(dt.Rows[i][0].ToString());
                                DataTable dt1 = new DataTable();
                                SqlDataAdapter da1 = new SqlDataAdapter(cmd);
                                da1.Fill(dt1);

                                Response.Write("<div class='col-md-6 col-sm-6 s1'> <div class='services-info' style='text-align:center;'><h4 style='text-align:center;'>" + dt.Rows[i][1].ToString() + "</h4><p> <b>Event Type: " + dt.Rows[i][7].ToString() + "</b>");
                                Response.Write("<br/>" + dt.Rows[i][2].ToString() + " </p><p>Event Date: " + Convert.ToDateTime(dt.Rows[i][3]).ToString("yyyy/MM/dd") + "</p><b><a href='" + dt.Rows[i][4].ToString() + "' target='_blank'>View Notice</a>");

                                if (dt1.Rows.Count > 0)
                                {
                                    Response.Write("&nbsp;&nbsp;&nbsp;<a href='result.aspx?id=" + dt.Rows[i][0].ToString() + "'>View Result</a>");
                                }
                                Response.Write("</b></p></div></div>");
                            }
                        }
                    %>
               
               
		        <div class="clearfix"></div>
            </div>
            </div></div>
</asp:Content>
