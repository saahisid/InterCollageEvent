<%@ Page Title="" Language="C#" MasterPageFile="~/collegemaster.master" AutoEventWireup="true" CodeBehind="view_stud.aspx.cs" Inherits="intercollege.view_stud" %>

<script runat="server">

  
</script>
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
    <h1 class="abbr">View Student</h1>
    <asp:GridView ID="gvclg" runat="server" AutoGenerateColumns="False" width="100%"
        CellPadding="4" DataKeyNames="studid" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None" onrowcommand="gvclg_RowCommand">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="studid" HeaderText="studid" InsertVisible="False" 
                ReadOnly="True" SortExpression="studid" Visible="false"/>
            <asp:BoundField DataField="studname" HeaderText="Name" 
                SortExpression="studname" />
            <asp:BoundField DataField="regno" HeaderText="Reg. No." 
                SortExpression="regno" />
            <asp:BoundField DataField="gender" HeaderText="Gender" 
                SortExpression="gender" />
            <asp:BoundField DataField="admission_year" HeaderText="Admission Year" 
                SortExpression="admission_year" />
            <asp:BoundField DataField="course_name" HeaderText="Course" 
                SortExpression="course_name"/>
           
            <asp:BoundField DataField="contactno" HeaderText="Contact No." 
                SortExpression="contactno" />
            <asp:BoundField DataField="email_id" HeaderText="Email Id" 
                SortExpression="email_id" />
                 <asp:TemplateField>
               <HeaderTemplate>Action</HeaderTemplate>
                  <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server"  CommandName="edit" CommandArgument='<%# Eval("studid") %>' ImageUrl="~/images/edit.png" Height="22px" Width="22px"/>
                 &nbsp;|&nbsp;
                  <asp:ImageButton ID="btndel" runat="server"  CommandName="del" CommandArgument='<%# Eval("studid") %>' ImageUrl="~/images/del.png" Height="22px" Width="22px" OnClientClick="return val()"/>
                   </ItemTemplate>
               </asp:TemplateField>
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
        
        
        
        SelectCommand="SELECT tbl_student.studid, tbl_student.studname, tbl_student.regno, tbl_student.gender, tbl_student.admission_year, tbl_course.course_name, tbl_student.contactno, tbl_student.email_id FROM tbl_course INNER JOIN tbl_student ON tbl_course.courseid = tbl_student.courseid WHERE (tbl_student.colgid = @colgid)" >
        <SelectParameters>
            <asp:SessionParameter Name="colgid" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
