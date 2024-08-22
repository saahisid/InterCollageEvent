<%@ Page Title="" Language="C#" MasterPageFile="~/collegemaster.master" AutoEventWireup="true" CodeBehind="participants.aspx.cs" Inherits="intercollege.participants" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 align="center">Participants List</h2>
    <%
        if (string.IsNullOrEmpty(Session["type"] as string))
        {
            Response.Redirect("index.aspx");
        }
         %>
    <asp:GridView ID="GridView1" runat="server" Width="97%" CellPadding="4" 
        ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="EventNAME" HeaderText="EventNAME" 
                SortExpression="EventNAME" />
            <asp:BoundField DataField="CollegeName" HeaderText="CollegeName" 
                SortExpression="CollegeName" />
            <asp:BoundField DataField="StudentName" HeaderText="StudentName" 
                SortExpression="StudentName" />
      <asp:TemplateField>
                <HeaderTemplate>
                View ID PROOF
                </HeaderTemplate>
                <ItemTemplate>
                <a ID="lb1" runat="server" href='<%# Eval("idproof") %>' target="_blank">View</a>
                </ItemTemplate>
                </asp:TemplateField>
          
            <asp:BoundField DataField="Amount" HeaderText="Amount" 
                SortExpression="Amount" />
            <asp:BoundField DataField="EventID" HeaderText="EventID" 
                SortExpression="EventID" />
            <asp:BoundField DataField="CollegeId" HeaderText="CollegeId" 
                SortExpression="CollegeId" />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" Height="40px" />
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
        
        SelectCommand="SELECT [EventNAME], [CollegeName], [StudentName], [Idproof], [Amount], [EventID], [CollegeId] FROM [tbl_candidate] WHERE ([CollegeId] = @CollegeId)">
        <SelectParameters>
            <asp:SessionParameter Name="CollegeId" SessionField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
