<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="forgot.aspx.cs" Inherits="intercollege.forgot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            height: 53px;
        }
        .style3
        {
            height: 33px;
        }
    .style4
    {
        height: 53px;
        width: 129px;
    }
    .style6
    {
         height: 33px;
         width: 129px;
     }
     .style7
     {
         height: 53px;
         font-weight: bold;
     }
     .style8
     {
         height: 53px;
         width: 129px;
         font-weight: bold;
     }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
    <h2 style="text-align: center"><br />&nbsp;&nbsp;&nbsp;Forgot Password</h2>
    <div class="main">
        <div class="container">
			<div class="contact" style="min-height:450px;">
                <table style="width:60%;" align="center" >
                 <tr>
                 <td class="style8">&nbsp;</td>
                 <td class="style7" style="font-size: medium">
                     Please Enter Registered Email Id..</td>
                 </tr>
                  
                 <tr>
                 <td class="style4"><strong>User Name
                 </strong>
                 </td>
                 <td class="style1">
                     <asp:TextBox ID="txtuser" runat="server" Placeholder="Enter email id" 
                         Height="40px" Width="350px" ontextchanged="txtuser_TextChanged" 
                         AutoPostBack="True"></asp:TextBox><asp:RequiredFieldValidator
                         ID="RequiredFieldValidator1" runat="server" 
                         ErrorMessage="Enter Email Id" ForeColor="Red" ValidationGroup="Login" 
                         ControlToValidate="txtuser"></asp:RequiredFieldValidator>
                     </td>
                 </tr>
                  
                  <tr>
                 <td class="style6"></td>
                   <td class="style3">
                       <asp:Button ID="btnlogin" runat="server" Text="Reset" BackColor="#993333" 
                           ForeColor="White" Height="30px" Width="120px" ValidationGroup="Login" 
                           onclick="btnlogin_Click"  />&nbsp;&nbsp;
                        
                      </td>
                 </tr>
                  <tr>
                 <td class="style6">&nbsp;</td>
                   <td class="style3">
                       &nbsp;</td>
                 </tr>
                  <tr>
                 <td class="style6">&nbsp;</td>
                   <td class="style3" align="right">
                       &nbsp;<a href="login.aspx"><strong>Back to Login</strong></a>
                       </td>
                 </tr>
                </table>
             </div>
        </div>
    </div>
    </div>
</asp:Content>
