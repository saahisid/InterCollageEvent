<%@ Page Title="" Language="C#" MasterPageFile="~/stud.master" AutoEventWireup="true" CodeBehind="colgEvent.aspx.cs" Inherits="intercollege.colgEvent" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        if (con.State != System.Data.ConnectionState.Open)
            con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "SELECT * FROM tblevent_notice where status='Active'";
        
       
    }
    protected void GridView1_SelectedIndexChanged(object sender, System.EventArgs e)
    {

        GridViewRow r = GridView1.SelectedRow;
        Response.Redirect("postcandidate.aspx?eid=" + r.Cells[1].Text + "&ename=" + r.Cells[2].Text + "&col=" + r.Cells[8].Text + "&cid=" + r.Cells[6].Text);
       


    }

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    function participate(eventid, studid) {
        if (studid == 0) {
            window.location = 'index.aspx';
        }
        else {
            if (window.XMLHttpRequest) {
                // code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {
                // code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    //document.getElementById("bmark").innerHTML = xmlhttp.responseText;
                    if (xmlhttp.responseText == "success") {
                        alert("Success!!");
                        window.location.reload();
                    }
                    else {
                        alert(xmlhttp.responseText);
                    }
                }
            }
            var getlink = "ajaxmaster.aspx?eventid=" + eventid + "&studid=" + studid;
            xmlhttp.open("GET", getlink, true);
            xmlhttp.send();
        }
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
    	
    	
    	<div class="container">
            <div class="services slideanim" id="services">
                <h3>Events</h3>
                <p>We have taken up some Social Services done by our students in the slums and backward regions so that they can not only excel in education, but also as a good human being in the society.<asp:Label 
                        ID="Label1" runat="server" Text="Label"></asp:Label>
                </p>
                <p>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="event_id" DataSourceID="SqlDataSource1" 
                        onselectedindexchanged="GridView1_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="event_id" HeaderText="event_id" 
                                InsertVisible="False" ReadOnly="True" SortExpression="event_id" />
                            <asp:BoundField DataField="event_name" HeaderText="event_name" 
                                SortExpression="event_name" />
                            <asp:BoundField DataField="event_desc" HeaderText="event_desc" 
                                SortExpression="event_desc" />
                            <asp:BoundField DataField="event_date" HeaderText="event_date" 
                                SortExpression="event_date" />
                            <asp:BoundField DataField="event_file" HeaderText="event_file" 
                                SortExpression="event_file" />
                            <asp:BoundField DataField="Colgid" HeaderText="Colgid" 
                                SortExpression="Colgid" />
                            <asp:BoundField DataField="event_type" HeaderText="event_type" 
                                SortExpression="event_type" />
                            <asp:BoundField DataField="colgname" HeaderText="colgname" 
                                SortExpression="colgname" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                        SelectCommand="SELECT [event_id], [event_name], [event_desc], [event_date], [event_file], [tblevent_notice].[Colgid], [event_type] ,colgname FROM [tblevent_notice],tbl_college where [tblevent_notice].colgid=tbl_college.colgid">
                    </asp:SqlDataSource>
                </p>
          
               
               
		        <div class="clearfix"></div>
            </div>
            </div></div>
</asp:Content>
