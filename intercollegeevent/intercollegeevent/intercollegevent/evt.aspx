<%@ Page Title="" Language="C#" MasterPageFile="~/Login.master" AutoEventWireup="true" CodeFile="evt.aspx.cs" Inherits="evt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        Select College<asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="SqlDataSource1" DataTextField="colgname" 
            DataValueField="colgid" AutoPostBack="True" 
            onselectedindexchanged="DropDownList1_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:clgconn %>" 
            SelectCommand="SELECT distinct [colgname],tblevent_notice.colgid FROM [tbl_college],tblevent_notice where tbl_college.colgid=tblevent_notice.colgid">
        </asp:SqlDataSource>
    </p>
    <p>
        Event:</p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="event_name" HeaderText="event_name" 
                    SortExpression="event_name" />
                <asp:BoundField DataField="event_desc" HeaderText="event_desc" 
                    SortExpression="event_desc" />
                <asp:BoundField DataField="event_date" HeaderText="event_date" 
                    SortExpression="event_date" />
                <asp:BoundField DataField="event_file" HeaderText="event_file" 
                    SortExpression="event_file" />
                <asp:BoundField DataField="event_type" HeaderText="event_type" 
                    SortExpression="event_type" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:clgconn %>" 
            SelectCommand="SELECT [event_name], [event_desc], [event_date], [event_file], [event_type] FROM [tblevent_notice] where colgid=@a">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="a" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

