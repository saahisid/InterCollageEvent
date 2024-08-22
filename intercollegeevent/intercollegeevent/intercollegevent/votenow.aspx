<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="votenow.aspx.cs" Inherits="intercollege.votenow" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
  <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" DataKeyNames="colgid">
        <Columns>
            <asp:BoundField DataField="event_id" HeaderText="event_id" 
                SortExpression="event_id" />
            <asp:BoundField DataField="colgname" HeaderText="colgname" 
                SortExpression="colgname" />
            <asp:BoundField DataField="event_name" HeaderText="event_name" 
                SortExpression="event_name" />
            <asp:BoundField DataField="event_date" HeaderText="event_date" 
                SortExpression="event_date" />
            <asp:BoundField DataField="colgid" HeaderText="colgid" InsertVisible="False" 
                ReadOnly="True" SortExpression="colgid" />
            <asp:BoundField DataField="event_result" HeaderText="event_result" 
                SortExpression="event_result" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
        
        SelectCommand="SELECT tblevent_result.event_id, tbl_college.colgname, tblevent_notice.event_name, tblevent_notice.event_date, tbl_college.colgid, tblevent_result.event_result FROM tblevent_result INNER JOIN tblevent_notice ON tblevent_result.event_id = tblevent_notice.event_id INNER JOIN tbl_college ON tblevent_notice.Colgid = tbl_college.colgid">
    </asp:SqlDataSource>

</asp:Content>
