<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master"  AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="intercollege.login" %>

<script runat="server">

    protected void btnlogin_Click(object sender, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
     
            con.Open();
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select * from tblcolg_detail inner join tbl_College on tblcolg_detail.colg_id=tbl_College.colgid where email_id='" + txtusername.Text + "' and colg_pass='" + txtpass.Text + "' and status='Active'";

        System.Data.SqlClient.SqlDataReader dt = cmd.ExecuteReader();
      
        if (dt.Read())
        {
           
            Session["type"] = "colg";
            Session["uname"] = dt["colgname"].ToString();
            Session["id"] = dt["colgid"].ToString();
            Response.Redirect("studentreg.aspx");

        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Invalid Login Credentials');", true);
        }
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">College Login</h1>
    <table style="width: 50%; height: 215px;" align="center">
        <tr>
            <td style="width: 183px">
                User Name
            </td>
            <td>
               &nbsp;<asp:TextBox ID="txtusername" 
                    runat="server" Height="30px" Width="200px"></asp:TextBox>
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
        <tr>
            <td style="width: 183px">
                &nbsp;</td>
            <td style="text-align:right;">
                <b>&nbsp; <a id="A1" href="ColgReg.aspx" runat="server" target="_self">Register!</a></b>
            </td>
           
        </tr>
    </table>
</asp:Content>
