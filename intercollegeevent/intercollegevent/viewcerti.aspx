<%@ Page Title="" Language="C#" MasterPageFile="~/collegemaster.Master" AutoEventWireup="true" CodeBehind="viewcerti.aspx.cs" Inherits="intercollege.viewcerti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1 class="abbr">Download Certificates</h1>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="event_id,fileid" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None" Width="95%" 
        ShowHeaderWhenEmpty="True">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="event_name" HeaderText="Event Name" 
                SortExpression="event_name" />
                 <asp:BoundField DataField="event_date" HeaderText="Conducted On" 
                SortExpression="event_date" />
          

                 <asp:TemplateField>
               <HeaderTemplate>Certificate</HeaderTemplate>
                  <ItemTemplate>
                    <a href='<%# Eval("certificate") %>' runat="server" target="_blank">Download</a>
                   </ItemTemplate>
                   </asp:TemplateField>

            <asp:BoundField DataField="event_id" HeaderText="event_id" Visible="false"
                InsertVisible="False" ReadOnly="True" SortExpression="event_id" />
            <asp:BoundField DataField="fileid" HeaderText="fileid" InsertVisible="False" 
                ReadOnly="True" SortExpression="fileid" visible="false"/>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <EmptyDataTemplate>No Data Found</EmptyDataTemplate>
        <EmptyDataRowStyle Height="40px" HorizontalAlign="Center" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" 
            Height="40px" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Height="40px" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
        SelectCommand="SELECT tblevent_notice.event_name,tblevent_notice.event_date, tblcertficate.certificate, tblevent_notice.event_id, tblcertficate.fileid FROM tblcertficate INNER JOIN tblevent_notice ON tblcertficate.eventid = tblevent_notice.event_id WHERE (tblcertficate.colgid = @id)">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
