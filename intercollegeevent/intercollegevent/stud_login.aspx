<%@ Page Title="" Language="C#" MasterPageFile="~/collegeevent.Master" AutoEventWireup="true" CodeBehind="stud_login.aspx.cs" Inherits="intercollege.stud_login" %>

<script runat="server">

  
   
    

    protected void txtregno_TextChanged(object sender, EventArgs e)
    {
       
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        if (con.State != System.Data.ConnectionState.Open)
            con.Open();
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
        cmd.Connection = con;
        cmd.Parameters.AddWithValue("@regno", txtregno.Text);
        cmd.CommandText = "Select * from tbl_student where regno=@regno";
        System.Data.DataTable dt = new System.Data.DataTable();
        System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
        da.Fill(dt);
        int studid = 0;
        if (dt.Rows.Count > 0)
        {
            studid = Convert.ToInt32(dt.Rows[0][0].ToString());
            string contact = dt.Rows[0]["contactno"].ToString();
            string numbers = "1234567890";

            string characters = numbers;
            int length = 5;
            string otp = string.Empty;
            for (int i = 0; i < length; i++)
            {
                string character = string.Empty;
                do
                {
                    int index = new Random().Next(0, characters.Length);
                    character = characters.ToCharArray()[index].ToString();
                } while (otp.IndexOf(character) != -1);
                otp += character;
            }
            Label2.Text = otp;
           
            

       //     bindSMS(contact, otp);
            Session["otp"] = otp;
            Session["dt"] = dt;
            otp_msg.Visible = true;
            txtotp.Visible = true;
            txtregno.Enabled = false;
            
            
        }
            
        else
            
        {
            
            
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Registration No. doesn't Exist');", true);
            
            txtregno.Text = "";
            
            txtregno.Focus();
        }
        
    }

    protected void btnlogin_Click(object sender, EventArgs e)
    {
        string OTP = txtotp.Text;
        string regno = txtregno.Text;

        string session_otp = Session["otp"].ToString();
        if (OTP == session_otp)
        {
            System.Data.DataTable dtt = new System.Data.DataTable();
            dtt = (System.Data.DataTable)Session["dt"];
            Session["type"] = "stud";
            Session["id"] = dtt.Rows[0][1].ToString();
            Session["uname"] = dtt.Rows[0][2].ToString();

            Response.Redirect("colgEvent.aspx");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Invalid OTP. Please Try Again');", true);
            txtotp.Text = "";
            txtotp.Focus();
        }
    }

   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="abbr">Student Login</h1>

    <table style="width: 50%; height: 274px;" align="center">


        <tr>
            <td style="width: 183px">
                Registration No.
            </td>
            <td>
               &nbsp;<asp:TextBox ID="txtregno" 
                    runat="server" Height="30px" Width="200px" AutoPostBack="True" 
                    ontextchanged="txtregno_TextChanged"></asp:TextBox>
            </td>
             
        </tr>
       
        <tr>
            <td style="width: 183px; height: 163px;">
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </td>
            <td style="height: 163px">
            <p  id="otp_msg" runat="server" visible ="false" style="color: #FF0000">Please write 
                the following captcha</p>
                <p runat="server" visible ="false" style="color: #FF0000">
                    &nbsp;</p>
            <br />
                &nbsp;<asp:TextBox ID="txtotp" runat="server" TextMode="Password" visible ="false"></asp:TextBox>
            </td>
             
        </tr>
       
        <tr>
        <td style="width: 183px">&nbsp;</td>
        <td align="center">&nbsp;<asp:Button ID="btnlogin" runat="server" Text="Login" 
                BackColor="#5875B1" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                onclick="btnlogin_Click" />&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 183px">
              
            </td>
            <td style="text-align:right;">
                &nbsp;</td>
           
        </tr>
    </table>
</asp:Content>
