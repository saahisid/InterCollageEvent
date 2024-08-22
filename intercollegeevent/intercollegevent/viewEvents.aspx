<%@ Page Title="" Language="C#" MasterPageFile="~/collegeevent.Master" AutoEventWireup="true" CodeBehind="viewEvents.aspx.cs" Inherits="intercollege.viewEvents" %>

<script runat="server">
    System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);

    protected void gvevents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "del")
        {
            int event_id = Convert.ToInt32(e.CommandArgument.ToString());
            if (con.State != System.Data.ConnectionState.Open)
                con.Open();
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
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
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">View Events</h1>
    <asp:GridView ID="gvevents" runat="server" AutoGenerateColumns="False" width="98%"
        DataKeyNames="event_id" DataSourceID="SqlDataSource1" CellPadding="4" 
        ForeColor="#333333" GridLines="None"   onrowcommand="gvevents_RowCommand"
        EmptyDataText="No Reocrds Found" ShowHeaderWhenEmpty="True" 
       >
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="event_id" HeaderText="event_id" Visible="true"
                InsertVisible="False" ReadOnly="True" SortExpression="event_id" />
            <asp:BoundField DataField="event_name" HeaderText="Name" 
                SortExpression="event_name" />  
                <asp:BoundField DataField="event_type" HeaderText="Event type" 
                SortExpression="event_type" />
            <asp:BoundField DataField="event_desc" HeaderText="Description" 
                SortExpression="event_desc" />
            <asp:BoundField DataField="event_date" HeaderText="Event Date" DataFormatString="{0:d}"
                SortExpression="event_date" />
                <asp:TemplateField>
                <HeaderTemplate>
                View Notice
                </HeaderTemplate>
                <ItemTemplate>
                <a ID="lb1" runat="server" href='<%# Eval("event_file") %>' target="_blank">View</a>
                </ItemTemplate>
                </asp:TemplateField>
          
            <asp:BoundField DataField="status" HeaderText="status" 
                SortExpression="status" visible="false"/>
          <asp:TemplateField>
               <HeaderTemplate>Participants</HeaderTemplate>
                  <ItemTemplate>
                     <a ID="lb2" runat="server"  href='<%# string.Concat("participants.aspx") %>' target="_blank">View</a>
                    </ItemTemplate>
                   </asp:TemplateField>
                    <asp:TemplateField>
                                <HeaderTemplate>Action</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="btndel" runat="server"  CommandName="del" CommandArgument='<%# Eval("event_id") %>' ImageUrl="~/images/del.png" Height="22px" Width="22px" OnClientClick="return val()"/>
                                </ItemTemplate>
                                </asp:TemplateField>
                 
        </Columns>
        <EmptyDataTemplate>No Participants</EmptyDataTemplate>
        <EmptyDataRowStyle Height="40px" HorizontalAlign="Center" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" 
            Height="40px" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" Height="40px" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
        
    SelectCommand="SELECT tblevent_notice.event_id, tblevent_notice.event_name, tblevent_notice.event_desc, tblevent_notice.event_date, tblevent_notice.event_file, tbl_College.colgname, tblevent_notice.status, tblevent_notice.event_type FROM tbl_College INNER JOIN tblevent_notice ON tbl_College.colgid = tblevent_notice.colgid WHERE (tblevent_notice.status = @status) AND (tblevent_notice.colgid = @id)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Active" Name="status" />
            <asp:SessionParameter DefaultValue="" Name="id" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
