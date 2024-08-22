<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="adminlogin.aspx.cs" Inherits="intercollege.adminlogin" %>

<script runat="server">

   
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">Admin Login</h1>
    <table style="width: 50%; height: 215px;" align="center">
        <tr>
            <td style="width: 183px">
                User Name
            </td>
            <td>
               &nbsp;<asp:TextBox ID="txtusername" 
                    runat="server" Height="30px" Width="200px" 
                    ontextchanged="txtusername_TextChanged"></asp:TextBox>
            </td>
             
        </tr>
        <tr>
            <td style="width: 183px">
               Password
            </td>
            <td>
                &nbsp;<asp:TextBox ID="txtpass" runat="server" TextMode="Password" 
                    Height="30px" Width="200px"></asp:TextBox>
            </td>
             
        </tr>
        <tr>
        <td style="width: 183px">&nbsp;</td>
        <td>&nbsp;<asp:Button ID="btnlogin" runat="server" Text="Login" 
                onclick="btnlogin_Click" BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" />&nbsp;&nbsp;<asp:Button ID="btncancel"
            runat="server" Text="Cancel" onclick="btncancel_Click"  BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px"/></td>
        </tr>
        
    </table>
</asp:Content>
