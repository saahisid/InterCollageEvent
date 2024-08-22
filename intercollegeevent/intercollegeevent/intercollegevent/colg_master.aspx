<%@ Page Title="" Language="C#" MasterPageFile="~/Login.master" AutoEventWireup="true" CodeBehind="colg_master.aspx.cs" Inherits="intercollege.colg_master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">Add College </h1>
<table width="50%" align="center">
            <tr>
                <td style="width: 115px; height: 43px;">
                    <b>College Name</b></td>
                <td style="height: 43px">
                    <asp:TextBox ID="txtcollege" runat="server" Height="30px" Width="200px" 
                       ></asp:TextBox>
&nbsp;&nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="Enter college" ControlToValidate="txtcollege" ForeColor="Red" 
                        ValidationGroup="addd" Font-Size="Small" Height="19px"></asp:RequiredFieldValidator>
                    &nbsp;
                   
                </td>
            </tr>
                 <tr>
                <td style="width: 115px; height: 55px;">
                    <b>College Reg code</b></td>
                <td style="height: 55px">
                    <asp:TextBox ID="txtcolgcode" runat="server" Height="30px" Width="200px" 
                        AutoPostBack="True" ontextchanged="txtcolgcode_TextChanged"></asp:TextBox>
                   &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtcolgcode"
                        ErrorMessage="Enter College Reg code" Font-Size="Small" ForeColor="Red" 
                        ValidationGroup="addd" Height="16px"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
            <td style="height: 59px"></td>
            <td style="height: 59px"> <asp:Button ID="btnadd" runat="server" Text="Add" onclick="btnadd_Click1" BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                        ValidationGroup="addd"/></td>
            </tr>
            <tr>
                <td style="height: 25px; width: 115px;">
                    </td>
                <td style="height: 25px">
                    </td>
            </tr>
            <tr>
                <td style="text-align: center;" colspan="3">
                   <h5><b>View College</b></h5> </td>
               
            </tr>
            <tr>
                <td style="height: 30px; width: 115px;">
                    &nbsp;</td>
                <td style="height: 30px">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gvcollege" runat="server" CellPadding="4" ForeColor="#333333" 
                        GridLines="None" AutoGenerateColumns="False" DataKeyNames="colgid" 
                        DataSourceID="SqlDataSource1" Width="450px" AllowPaging="True" 
                        onrowcommand="gvcollege_RowCommand" >
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="colgid" HeaderText="colgid" visible="false"
                                InsertVisible="False" ReadOnly="True" SortExpression="colgid"/>
                            <asp:BoundField DataField="colgname" HeaderText="College Name" 
                                SortExpression="colgname" />
                                  <asp:BoundField DataField="college_code" HeaderText="College Code" 
                                SortExpression="college_code"/>
                                
                                 <asp:TemplateField>
                                <HeaderTemplate>Action</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="btndel" runat="server"  CommandName="del" CommandArgument='<%# Eval("colgid") %>' ImageUrl="~/images/del.png" Height="22px" Width="22px" OnClientClick="return val()"/>
                                </ItemTemplate>
                                </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" 
                            Height="30px" HorizontalAlign="Center" />
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
                        SelectCommand="SELECT [colgid], [colgname], [college_code] FROM [tbl_College]">
                    </asp:SqlDataSource>
                </td>
              
            </tr>
        </table>
</asp:Content>
