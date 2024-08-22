<%@ Page Title="" Language="C#" MasterPageFile="~/collegeevent.Master" AutoEventWireup="true" CodeBehind="ManageEvents.aspx.cs" Inherits="intercollege.ManageEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function val() {
            var flag = confirm("Do you want to delete the record");
            if (!flag)
                return false;
            else
                return true;
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">Manage Events</h1>
    <asp:GridView ID="gvevents" runat="server" AutoGenerateColumns="False" width="98%"
        DataKeyNames="event_id" DataSourceID="SqlDataSource1" CellPadding="4" 
        ForeColor="#333333" GridLines="None" 
    onrowcommand="gvevents_RowCommand" EmptyDataText="No Reocrds Found" 
    ShowHeaderWhenEmpty="True" AllowPaging="True">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
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
            <asp:BoundField DataField="colgname" HeaderText="colgname" 
                SortExpression="colgname" />
            <asp:BoundField DataField="status" HeaderText="status" 
                SortExpression="status"/>
            <asp:BoundField DataField="event_type" HeaderText="event_type" 
                SortExpression="event_type" />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
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
        
        
    SelectCommand="SELECT tblevent_notice.event_id, tblevent_notice.event_name, tblevent_notice.event_desc, tblevent_notice.event_date, tblevent_notice.event_file, tbl_College.colgname, tblevent_notice.status, tblevent_notice.event_type FROM tbl_College INNER JOIN tblevent_notice ON tbl_College.colgid = tblevent_notice.colgid WHERE (tblevent_notice.status = 'Active') and tblevent_notice.colgid =@a">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="a" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
