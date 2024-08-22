<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ColgReg.aspx.cs" Inherits="intercollege.ColgReg" %>

<script runat="server">
    System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (con.State != System.Data.ConnectionState.Open)
            con.Open();
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
        cmd.Connection = con;

        string filename = string.Empty;
        string imagename = string.Empty;
        string imgFileType = string.Empty;

        if (FileUploadimage.HasFile)
        {
            imagename = DateTime.Now.ToString("MM-dd-yyyy_HHmmss");
            imgFileType = System.IO.Path.GetExtension(FileUploadimage.FileName).ToString().ToLower();
            FileUploadimage.SaveAs(Server.MapPath("~/uploads/colimg/" + imagename + imgFileType));
        }


        string pass = RandomString(8);

        cmd.Parameters.AddWithValue("@clgid", Convert.ToInt32(ddlcollege.SelectedValue.ToString()));
        cmd.Parameters.AddWithValue("@addr", txtadd.Text);
        cmd.Parameters.AddWithValue("@contact", txtcon.Text);
        cmd.Parameters.AddWithValue("@alt", txtalt.Text);
        cmd.Parameters.AddWithValue("@email", txtemail.Text);
        cmd.Parameters.AddWithValue("@long", txtlon.Text);
        cmd.Parameters.AddWithValue("@lat", txtlan.Text);
        cmd.Parameters.AddWithValue("@colgcode", txtcolgcode.Text);
        cmd.Parameters.AddWithValue("@imagename", "uploads/colimg/" + imagename + imgFileType);
        cmd.Parameters.AddWithValue("@status", "Active");

        cmd.Parameters.AddWithValue("@pass", TextBox1.Text);

        cmd.CommandText = "insert into tblcolg_detail(colg_id,address,contact,contact2,email_id,photopath,lattitude,longitude,colg_pass,status,colg_code) "
        + "values(@clgid,@addr,@contact,@alt,@email,@imagename,@lat,@long,@pass,@status,@colgcode)";

        int i = cmd.ExecuteNonQuery();
        if (i > 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Registration success!! Confirmation mail will be sent once univerisity verify the Account');", true);
            clearform();
        }
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style3
        {
          
        }
        .style7
        {
            width: 189px;
            height: 26px;
        }
        .style8
        {
         
            height: 26px;
        }
        .style9
        {
            width: 189px;
            height: 45px;
        }
        .style10
        {
            
            height: 45px;
        }
        .style11
        {
            width: 136px;
            height: 28px;
        }
        .style12
        {
           
            height: 28px;
        }
        .style15
        {
            width: 136px;
            height: 19px;
        }
        .style16
        {

            height: 19px;
        }
        .style17
        {
            width: 189px;
            height: 27px;
        }
        .style18
        {
          
            height: 27px;
        }
        .style21
        {
            width: 136px;
            height: 40px;
        }
        .style22
        {
           
            height: 40px;
        }
     .style23
     {
         width: 136px;
     }
     .style26
     {
         width: 136px;
         height: 63px;
     }
     .style27
     {
         height: 63px;
     }
     .style28
     {
         width: 189px;
         height: 63px;
     }
    </style>
    <script type="text/javascript">
        function validatecontact(contact)
        {
            if (contact.length != 10) {
                alert("invalid Mobile Number");
                document.getElementById("txtcon").value = "";
                document.getElementById("txtcon").focus();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">College Registration</h1>
     <table class="style1">
            <tr>
                <td class="style11" valign="top">
                    College Name</td>
                <td class="style12">
                    <asp:DropDownList ID="ddlcollege" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="SqlDataSource1" DataTextField="colgname" DataValueField="colgid" 
                        Height="30px" Width="200px" >
                    <asp:ListItem Value="0">-- Select College --</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                        SelectCommand="SELECT  p.colgid, p.colgname FROM tbl_College as p where NOT EXISTS (SELECT *
                   FROM   tblcolg_detail as od  WHERE  p.colgid = od.colg_id) " >                        
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="Select College" ForeColor="#CC0000" 
                        ControlToValidate="ddlcollege" Font-Size="Small" ValidationGroup="reg" 
                        InitialValue="0"></asp:RequiredFieldValidator>
                </td>
                <td class="style17">
                    College Reg Code</td>
                <td class="style18">
                    <asp:TextBox ID="txtcolgcode" runat="server" Height="30px" Width="200px" 
                        AutoPostBack="True" ontextchanged="txtcolgcode_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtcolgcode"
                        ErrorMessage="Enter College Code" Font-Size="Small" ForeColor="Red" 
                        ValidationGroup="reg"></asp:RequiredFieldValidator>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
           
            <tr>
                <td class="style23" valign="top">
                    Contact no</td>
                <td class="style3">
                    <asp:TextBox ID="txtcon" runat="server" Height="30px" Width="200px" onchange="validatecontact(this.value)" ClientIDMode="static"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ErrorMessage="Enter Contact Number" ForeColor="#CC0000" 
                        ControlToValidate="txtcon" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="txtcon" ErrorMessage="Only 10 digis allowed" 
                        ValidationExpression="\d{10}"></asp:RegularExpressionValidator>
                </td>
                <td class="style7">
                    College image</td>
                <td class="style8">
                        &nbsp;<asp:FileUpload ID="FileUploadimage" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="FileUploadimage"
                            ErrorMessage="Upload Photo" Font-Size="Small" ForeColor="Red" 
                            ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style26" valign="top">
                    Alternate no</td>
                <td class="style27">
                    <asp:TextBox ID="txtalt" runat="server" Height="30px" Width="200px"></asp:TextBox>
                    <br />
                    <p>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                            ControlToValidate="txtalt" ErrorMessage="Only 10 digis allowed" 
                            ValidationExpression="\d{10}"></asp:RegularExpressionValidator>
                    </p> 
                </td>
             <td class="style9" valign="top">
                    Password</td>
                <td class="style10">
                    <asp:TextBox ID="TextBox1" runat="server" Height="30px" Width="200px" 
                        TextMode="Password"></asp:TextBox>   
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ErrorMessage="Enter Password" ForeColor="#CC0000" 
                        ControlToValidate="TextBox1" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
               
                 <td class="style9" valign="top">
                    Longitude</td>
                <td class="style10">
                    <asp:TextBox ID="txtlon" runat="server" Height="30px" Width="200px"></asp:TextBox>   
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ErrorMessage="Enter Longitude" ForeColor="#CC0000" 
                        ControlToValidate="txtlon" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
                <td class="style28" valign="top">
                    Lattitude</td>
                <td class="style27">
                    <asp:TextBox ID="txtlan" runat="server" Height="30px" Width="200px"></asp:TextBox>   
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ErrorMessage="Enter Lattitude" ForeColor="#CC0000" 
                        ControlToValidate="txtlan" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
            </tr>
            
           
           
             <tr>
                <td class="style21" valign="top">
                    Address</td>
                <td class="style22">
                    <asp:TextBox ID="txtadd" runat="server" TextMode="MultiLine" Rows="3" 
                        Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ErrorMessage="Enter Address" ForeColor="#CC0000" 
                        ControlToValidate="txtadd" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
                 <td class="style15" valign="top">
                    Email id
                </td>
                <td class="style16">
                    <asp:TextBox ID="txtemail" runat="server" Height="30px" Width="200px" 
                        AutoPostBack="True" ontextchanged="txtemail_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ErrorMessage="Enter Email Id" ForeColor="#CC0000" 
                        ControlToValidate="txtemail" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txtemail" ErrorMessage="Invalid Email Id" ForeColor="Red" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        Font-Size="Small" ValidationGroup="reg"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
               
                <td  colspan="4" align="center">
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" 
                        onclick="btnsubmit_Click" ValidationGroup="reg" BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" />
&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btncancel" runat="server" Text="Cancel" 
                        onclick="btncancel_Click" BackColor="#26A718" Font-Bold="True" 
                        ForeColor="White" Height="30px" Width="100px" />
                </td>
            </tr>
        </table>
</asp:Content>
