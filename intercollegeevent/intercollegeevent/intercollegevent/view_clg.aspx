<%@ Page Title="" Language="C#" MasterPageFile="~/Login.master" AutoEventWireup="true" CodeBehind="view_clg.aspx.cs" Inherits="intercollege.view_clg" %>
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
    <h1 class="abbr">View College</h1>
    <asp:GridView ID="gvclg" runat="server" AutoGenerateColumns="False" width="100%"
        CellPadding="4" DataKeyNames="colgid" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="colgid" HeaderText="colgid" InsertVisible="False" 
                ReadOnly="True" SortExpression="colgid" Visible="false" />
                <asp:TemplateField>
                <HeaderTemplate>Photo</HeaderTemplate>
                <ItemTemplate>
                <asp:Image ImageUrl='<%# Eval("photopath") %>' Width="100px" Height="100px" runat="server" ID="img1" />
                </ItemTemplate>
                </asp:TemplateField>
            <asp:BoundField DataField="colgname" HeaderText="Name" 
                SortExpression="colgname" />
            <asp:BoundField DataField="address" HeaderText="Address" 
                SortExpression="address" />
            <asp:BoundField DataField="contact" HeaderText="Contact No." 
                SortExpression="contact" />
            <asp:BoundField DataField="email_id" HeaderText="Email ID" 
                SortExpression="email_id" />
            <asp:BoundField DataField="photopath" HeaderText="photopath" 
                SortExpression="photopath" Visible="false"/>
           
            <asp:BoundField DataField="status" HeaderText="Status" 
                SortExpression="status" />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" 
            Height="35px" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" Height="30px" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
        
        SelectCommand="SELECT tbl_College.colgid, tbl_College.colgname, tblcolg_detail.address, tblcolg_detail.contact, tblcolg_detail.email_id, tblcolg_detail.photopath, tblcolg_detail.status FROM tblcolg_detail INNER JOIN tbl_College ON tblcolg_detail.colg_id = tbl_College.colgid">
    </asp:SqlDataSource>
</asp:Content>
