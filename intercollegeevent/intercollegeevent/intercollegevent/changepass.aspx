<%@ Page Title="" Language="C#" MasterPageFile="~/collegemaster.master" AutoEventWireup="true" CodeBehind="changepass.aspx.cs" Inherits="intercollege.changepass" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
 SqlConnection cn;
    SqlCommand cmd;
    SqlDataReader dr;
    protected void btnupdate_Click(object sender, EventArgs e)
    {
      cn = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        string opwd = txtusername.Text;
        string npwd = txtpass.Text;
       int unm =  Convert.ToInt32(Session["id"].ToString());
        cn.Open();
        cmd = new SqlCommand("Select * from tblcolg_detail where colg_id=" + unm + " and colg_pass='" + txtusername.Text + "'",cn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows == false)
        {
            dr.Close();
            cn.Close();
            Label1.Text = "Invalid Old Password";
             Label1.ForeColor = System.Drawing.Color.Red;
            txtusername.Focus();
        }
        else
        {
            dr.Close();
            cmd = new SqlCommand("Update tblcolg_detail Set colg_pass='" + npwd + "' Where colg_id=" + unm , cn);
            cmd.ExecuteNonQuery();
            Label1.Text = " Password changed";
            cn.Close();
           
        }
    }
    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">Update Password</h1>
    <p class="abbr">
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </p>
    <table style="width: 50%; height: 215px;" align="center">
        <tr>
            <td style="width: 183px">
                Current Password
            </td>
            <td>
               &nbsp;<asp:TextBox ID="txtusername"
                    runat="server" Height="30px" Width="200px" EnableViewState="true"
                    ontextchanged="txtusername_TextChanged" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtusername" ForeColor="Red"
                    ErrorMessage="Enter Current Password" ValidationGroup="cnge" Height="33px"></asp:RequiredFieldValidator>
            </td>
             
        </tr>
        <tr>
            <td style="width: 183px">
                New
               Password
            </td>
            <td>
                &nbsp;<asp:TextBox ID="txtpass" runat="server" TextMode="Password" 
                    Height="30px" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtpass" ForeColor="Red"
                    ErrorMessage="Enter New Password" ValidationGroup="cnge" Height="27px"></asp:RequiredFieldValidator>
            </td>
             
        </tr>
        <tr>
            <td style="width: 183px">
                Retype Password</td>
            <td>
                &nbsp;<asp:TextBox ID="txtcpass" runat="server"  Height="30px" Width="200px" 
                    TextMode="Password"></asp:TextBox>
                &nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToValidate="txtpass" ControlToCompare="txtcpass" ForeColor="Red"
                    ErrorMessage="Invalid Password" ValidationGroup="cnge" Height="25px"></asp:CompareValidator>
            </td>
             
        </tr>
        <tr>
        <td style="width: 183px">&nbsp;</td>
        <td>&nbsp;<asp:Button ID="btnupdate" runat="server" Text="Update" 
              BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                onclick="btnupdate_Click" ValidationGroup="cnge" />&nbsp;&nbsp;<asp:Button ID="btncancel"
            runat="server" Text="Cancel" onclick="btncancel_Click"  BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px"/></td>
        </tr>
       
    </table>
</asp:Content>
