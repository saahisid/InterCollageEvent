<%@ Page Title="" Language="C#" MasterPageFile="~/Login.master" AutoEventWireup="true" CodeBehind="manageCourse.aspx.cs" Inherits="intercollege.manageCourse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
    function val() {
        var flag = confirm("Are You Sure, Do you want to delete this record?");
        if (!flag)
            return false;
        else
            return true;
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">Manage Course</h1>
<table width="50%" align="center">
            <tr>
                <td style="width: 115px" valign="top">
                    <b>Course</b></td>
                <td>
                    <asp:TextBox ID="txtcou" runat="server" class="form-control" 
                        AutoPostBack="True" ontextchanged="txtcou_TextChanged"></asp:TextBox>
&nbsp;&nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="Enter Course" ControlToValidate="txtcou" ForeColor="Red" 
                        ValidationGroup="addd"></asp:RequiredFieldValidator>
                    &nbsp;
                   
                </td>
            </tr>
            <tr>
                <td style="height: 45px; width: 115px;">
                    </td>
                <td style="height: 45px"> <asp:Button ID="btnadd" runat="server" Text="Add" 
                        onclick="btnadd_Click1" BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                        ValidationGroup="addd"/>
                    </td>
            </tr>
            <tr>
                <td style="height: 47px; width: 115px;">
                    </td>
                <td style="height: 47px">
                    </td>
            </tr>
            <tr>
                <td style="height: 30px; text-align: center;" colspan="2">
                    <b>View Course</b></td>
               
            </tr>
            <tr>
                <td style="height: 30px; width: 115px;">
                    &nbsp;</td>
                <td style="height: 30px">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gvcourse" runat="server" CellPadding="4" ForeColor="#333333" 
                        GridLines="None" AutoGenerateColumns="False" DataKeyNames="courseid" 
                        DataSourceID="SqlDataSource1" Width="400px" AllowPaging="True" 
                        onrowcommand="gvcourse_RowCommand" HorizontalAlign="Center">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="courseid" HeaderText="courseid" 
                                InsertVisible="False" ReadOnly="True" SortExpression="courseid" Visible="false"/>
                            <asp:BoundField DataField="course_name" HeaderText="Course Name" 
                                SortExpression="course_name" />
                            <asp:BoundField DataField="colg_id" HeaderText="colg_id" 
                                SortExpression="colg_id" Visible="false"/>
                                <asp:TemplateField>
                                <HeaderTemplate>Action</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="btndel" runat="server"  CommandName="del" CommandArgument='<%# Eval("courseid") %>' ImageUrl="~/images/del.png" Height="22px" Width="22px" OnClientClick="return val()"/>
                                </ItemTemplate>
                                </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" 
                            Height="40px" HorizontalAlign="Center" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" Height="35px" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                        SelectCommand="SELECT * FROM [tbl_course]">
                    </asp:SqlDataSource>
                </td>
              
            </tr>
        </table>
</asp:Content>
