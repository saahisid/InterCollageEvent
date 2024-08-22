<%@ Page Title="" Language="C#" MasterPageFile="~/stud.master" AutoEventWireup="true" CodeBehind="postcandidate.aspx.cs" Inherits="intercollege.postcandidate" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">

   
    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["type"] == null)
        {
            Response.Redirect("index.aspx");
        }
        TextBox1.Text = Request.QueryString["eid"].ToString();
        TextBox2.Text = Request.QueryString["ename"].ToString();
        TextBox11.Text = Request.QueryString["col"].ToString();
        TextBox3.Text = Request.QueryString["cid"].ToString();
        TextBox5.Text = Session["id"].ToString();
        TextBox4.Text = Session["uname"].ToString();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        if (con.State != System.Data.ConnectionState.Open)
            con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
         string filename = string.Empty;
            string imagename = string.Empty;
            string imgFileType = string.Empty;
           
            if (FileUploadidproof.HasFile)
            {
                imagename = DateTime.Now.ToString("MM-dd-yyyy_HHmmss");
                imgFileType = System.IO.Path.GetExtension(FileUploadidproof.FileName).ToString().ToLower();
                FileUploadidproof.SaveAs(Server.MapPath("~/uploads/colimg/" + imagename + imgFileType));
            }
        cmd.Parameters.AddWithValue("@eventid",Convert.ToInt32 ( TextBox1.Text));
        cmd.Parameters.AddWithValue("@eventname", TextBox2.Text);
        cmd.Parameters.AddWithValue("@collegeid", Convert.ToInt32 (TextBox3.Text));

        cmd.Parameters.AddWithValue("@collegename", (TextBox11.Text));
        cmd.Parameters.AddWithValue("@studentname", TextBox4.Text);
        cmd.Parameters.AddWithValue("@sid", Convert.ToInt32 (TextBox5.Text));
        cmd.Parameters.AddWithValue("@idp", "uploads/colimg/" + imagename + imgFileType);
        cmd.Parameters.AddWithValue("@amount", Convert.ToInt32(TextBox6.Text));
        cmd.Parameters.AddWithValue("@account", Convert.ToInt32(TextBox7.Text));
        cmd.Parameters.AddWithValue("@cvv", Convert.ToInt32(TextBox9.Text));
        cmd.Parameters.AddWithValue("@bankname", TextBox10.Text);
        cmd.CommandText = "insert into dbo.tbl_candidate values(@eventid,@eventname,@collegeid,@collegename,@studentname,@sid,@idp,@amount,@account,@cvv,@bankname)";
        int j = cmd.ExecuteNonQuery();
      
           
         //3333.
       ScriptManager.RegisterClientScriptBlock(this, GetType(), "ïnfo", "alert('Success!! Participant Posted')", true);
        }
    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <p>
    </p>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">Post Candidate</h1>

        <table class="style1" width="70%" align="center">
            <tr>
                <td class="style2">
                    Event ID</td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2" style="height: 34px">
                    Event NAME</td>
                <td style="height: 34px">
                    <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2" style="height: 56px">
                    College Id</td>
                <td style="height: 56px">
                    <asp:TextBox ID="TextBox3" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2" style="height: 56px">
                    College Name</td>
                <td style="height: 56px">
                    <asp:TextBox ID="TextBox11" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
             <tr>
                <td class="style2" style="height: 56px">
                    Student&nbsp; Name</td>
                <td style="height: 56px">
                    <asp:TextBox ID="TextBox4" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
             <tr>
                <td class="style2" style="height: 56px">
                    Student Id</td>
                <td style="height: 56px">
                    <asp:TextBox ID="TextBox5" runat="server" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Id proof</td>
                <td>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                    <asp:FileUpload ID="FileUploadidproof" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="FileUploadidproof"  
                        ErrorMessage="ID PROOF" ForeColor="Red" Font-Size="Small" Height="28px"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td class="style2" style="height: 56px">
                    Amount</td>
                <td style="height: 56px">
                    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="TextBox6" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="TextBox6" ErrorMessage="Enter only digits" 
                        ValidationExpression="\d{1,8}"></asp:RegularExpressionValidator>
                </td>
            </tr>
             <tr>
                <td class="style2" style="height: 56px">
                    CARD No</td>
                <td style="height: 56px">
                    <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="TextBox7" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
             
            <tr>
                <td class="style2">
                    CVV</td>
                <td>
                    <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                        ControlToValidate="TextBox9" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ControlToValidate="TextBox9" ErrorMessage="ENTER ONLY 3 DIGITS" 
                        ValidationExpression="\d{3}"></asp:RegularExpressionValidator>
                </td>
            </tr>
             <tr>
                <td class="style2">
                    Bank Name</td>
                <td>
                    <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                        ControlToValidate="TextBox10" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnsubmit" runat="server" Text="submit" 
                        onclick="btnsubmit_Click" BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px"  />
&nbsp;&nbsp;
                    <asp:Button ID="btncancel" runat="server" Text="Cancel" BackColor="#26A718" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" />
                </td>
            </tr>
        </table>
        <br />
        <hr />
          <br />
    </asp:Content>
