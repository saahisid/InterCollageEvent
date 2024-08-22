<%@ Page Title="" Language="C#" MasterPageFile="~/collegeevent.Master" AutoEventWireup="true" CodeBehind="result.aspx.cs" Inherits="intercollege.result" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">

   
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="about slideanim" id="about">
 <%
     try
     {
         SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
         if (con.State != System.Data.ConnectionState.Open)
             con.Open();
         SqlCommand cmd = new SqlCommand();
         cmd.Connection = con;
         cmd.CommandText = "SELECT * FROM dbo.tblevent_result inner join tblevent_notice on tblevent_result.event_id=tblevent_notice.event_id where tblevent_result.event_id=" + Convert.ToInt32(Request.QueryString["id"].ToString());
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter(cmd);
         da.Fill(dt);

         if (dt.Rows.Count > 0)
         {
             Response.Write("<h2>" + dt.Rows[0]["event_name"].ToString() + " - Result</h2>");
             Response.Write("<p style='text-align:center;'>" + dt.Rows[0]["event_result"].ToString() + "</p>");
         }
     }
     catch (Exception ex)
     { 
     //ex
     }
                    %>
               
	    <div class="about slideanim" id="Div1">
        <p align="center"><b>Post Comments</b></p>
        <%
            if (!string.IsNullOrEmpty(Session["type"] as string))
            {
                if (Session["type"].ToString() == "stud")
                { %>

                <table width="90%" align="center" height="150px">
                <tr>
                <td style="width: 149px; height: 106px;">
                 <asp:Label runat="server" Text="Post Comments"></asp:Label>
                </td>
                <td style="height: 106px">   
                    <asp:TextBox runat="server" TextMode="MultiLine" Rows="5" id="txtpost"
                         CssClass="form-control" Width="100%"></asp:TextBox></td>
                </tr>
                <tr>
                <td style="height: 52px">Upload Event Images
                 </td>
                <td style="height: 52px">
                    <asp:FileUpload ID="UP_IMAGE" runat="server" Multiple="Multiple" 
                    accept=".png,.jpg,.jpeg" CssClass="form-control" Width="100%"/>
                  </td>
                </tr>
                <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;  <asp:Button ID="btnpost" runat="server" Text="Post" onclick="btnpost_Click" class="btn btn-danger"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="UP_IMAGE" ErrorMessage="select picture"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                </table>
                <br />
                <p align="center"><b>View Comments</b></p>
            <asp:GridView ID="GridView1" runat="server" Width="97%" 
                AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                GridLines="None" ShowHeader="False">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
               <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                SelectCommand="SELECT * FROM [tblcomment] where event_id=@a">
                   <SelectParameters>
                       <asp:SessionParameter Name="a" SessionField="ev" />
                   </SelectParameters>
            </asp:SqlDataSource>
               <% }
            }
            
             %>
        </div>  
         <div class="edifice slideanim" id="edifice">
	        	<h3>EVENT GALLERY</h3>
	            <div class="gallery-cursual">

	                <!-- requried-jsfiles-for owl -->
	                    <script src="js/owl.carousel.js"></script>
	                    <script>
		                    $(document).ready(function() {
			                    $("#owl-demo").owlCarousel ({
				                    items : 3,
				                    lazyLoad : true,
				                    autoPlay : true,
				                    pagination : false,
			                    });
		                    });
	                    </script>
	                <!-- //requried-jsfiles-for owl -->

	                <!-- start content_slider -->
	                <div id="owl-demo" class="owl-carousel text-center">
                    <%
                        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
                        if (con1.State != System.Data.ConnectionState.Open)
                            con1.Open();
                        SqlCommand cmd1 = new SqlCommand();
                        cmd1.Connection = con1;
                        cmd1.CommandText = "SELECT * FROM dbo.tblgallery where eventid=" + Convert.ToInt32(Request.QueryString["id"].ToString());
                        DataTable dt1 = new DataTable();
                        SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                        da1.Fill(dt1);
                        if(dt1.Rows.Count > 0)
                        for (int j = 0; j < dt1.Rows.Count; j++)
                        {
                            Response.Write("<div class='item'>");
                            Response.Write("<img class='lazyOwl' src='" + dt1.Rows[j]["photolink"].ToString() + "' alt='name'>");
	                        Response.Write("</div>");
                        }
                         %>
	                    
	                </div>
	                <!--//sreen-gallery-cursual -->
	            </div>
	        </div>      
</div>
</asp:Content>
