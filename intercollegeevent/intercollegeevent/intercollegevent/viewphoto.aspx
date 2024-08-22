<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="viewphoto.aspx.cs" Inherits="intercollege.viewphoto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="abbr">Manage Student Uploaded Photos</h1>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" width="100%"
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
        GridLines="None" ShowHeaderWhenEmpty="True" 
        onrowcommand="GridView1_RowCommand">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="event_name" HeaderText="Event" 
                SortExpression="event_name" />
            <asp:BoundField DataField="event_date" HeaderText="Conducted on" 
                SortExpression="event_date" />
            <asp:BoundField DataField="colgname" HeaderText="Conducted By" 
                SortExpression="colgname" />
          <asp:TemplateField>
                <HeaderTemplate>
                View Photo
                </HeaderTemplate>
                <ItemTemplate>
                <a ID="lb1" runat="server" href='<%# Eval("photolink") %>' target="_blank">View</a>
                </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField>
               <HeaderTemplate>Action</HeaderTemplate>
                  <ItemTemplate>
                    
                  <asp:ImageButton ID="btndel" runat="server"  CommandName="del" CommandArgument='<%# Eval("galleryid") %>' ImageUrl="~/images/del.png" Height="22px" Width="22px" OnClientClick="return val()"/>
                   </ItemTemplate>
                   </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <EmptyDataRowStyle Height="40px" HorizontalAlign="Center" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" 
            Height="40px" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" Height="40px" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
        SelectCommand="SELECT galleryid,tblevent_notice.event_name, tblevent_notice.event_date, tbl_College.colgname, tblgallery.photolink FROM tblgallery INNER JOIN tblevent_notice ON tblgallery.eventid = tblevent_notice.event_id INNER JOIN tbl_College ON tblevent_notice.colgid = tbl_College.colgid">
    </asp:SqlDataSource>
</asp:Content>
