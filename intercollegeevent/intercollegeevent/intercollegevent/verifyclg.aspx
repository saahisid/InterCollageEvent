<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="verifyclg.aspx.cs" Inherits="intercollege.verifyclg" %>

<script runat="server">

    protected void gvclg_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "aprve")
            {
                int colgid = Convert.ToInt32(e.CommandArgument.ToString());
                updatestatus("Active", colgid);

            }
            else if (e.CommandName == "deny")
            {
                int colgid = Convert.ToInt32(e.CommandArgument.ToString());
                updatestatus("Disapproved", colgid);
            }

        }

        public void updatestatus(string status, int clgid)
    {
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
    
            if (con.State != System.Data.ConnectionState.Open)
                con.Open();
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@clgid", clgid);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.CommandText = "update tblcolg_detail set status=@status where colg_id=@clgid";
            int i = cmd.ExecuteNonQuery();

            if (i > 0)
            {

                cmd.CommandText = "Select * from tblcolg_detail where colg_id=@clgid";
                System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                da.Fill(dt);
                string email = dt.Rows[0]["email_id"].ToString();
                string pass = dt.Rows[0]["colg_pass"].ToString();
                // var fromAddress = "intercoad@gmail.com";
                //  var toAddress = email ;
                const string fromPassword = "9768200910";
                DateTime Date = DateTime.Now;
                string subject = "'Inter College Event Calender - Account Information'";
                string body = "From: Inter College Event Calender \n";
                if (status == "Active")
                {
                    body += "Congradulations!! Your Account is verified by University and its Activated on  " + Date + "\n";
                    body += "Your Login Email is " + email + "\n";
                    body += "Your Login Password is " + pass + "\n";
                    body += "Please make changes to your password as soon as you log in.\n";
                }
                else if (status == "Disapproved")
                {
                    body += "Your Account is verified by University and its Disapproved on  " + Date + "\n";
                    body += "Please Contact University Admin for Furthure details\n";
                }

                body += "Thank you";

                string to = email; //To address    
                string from = "adnansayed465@gmail.com"; //From address    
                System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage(from, to);

                //string mailbody = "OTP  " + otp;
                message.Subject = "Email from INTERCOLLEGE EVENT MANAGMENT ADMIN ";
                message.Body = body;
                message.BodyEncoding = Encoding.UTF8;
                message.IsBodyHtml = true;
                System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587); //Gmail smtp    
                System.Net.NetworkCredential basicCredential1 = new
                System.Net.NetworkCredential("adnansayed465@gmail.com", "9768200910");
                client.EnableSsl = true;

                client.UseDefaultCredentials = false;
                client.Credentials = basicCredential1;
                try
                {
                    client.Send(message);
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Mail Send...');", true);
                }

                catch (Exception ex)
                {
                    throw ex;
                } 
            //    ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('Record Updated...');", true);
                gvclg.DataBind();
            }
        }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">Verify College</h1>
    <asp:GridView ID="gvclg" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="colgid" DataSourceID="SqlDataSource1" CellPadding="4" 
        ForeColor="#333333" GridLines="None" Width="100%" 
    onrowcommand="gvclg_RowCommand" ShowHeaderWhenEmpty="True" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="colgid" HeaderText="colgid" InsertVisible="False" 
                ReadOnly="True" SortExpression="colgid" visible="false"/>

            <asp:BoundField DataField="clinfo_id" HeaderText="clinfo_id" InsertVisible="False" 
                ReadOnly="True" SortExpression="clinfo_id" visible="false"/>

            <asp:BoundField DataField="colgname" HeaderText="College Name" 
                SortExpression="colgname" />
           
            <asp:BoundField DataField="idproof" HeaderText="idproof" 
                SortExpression="idproof" visible="false"/>
            <asp:BoundField DataField="address" HeaderText="Address" 
                SortExpression="address" />
            <asp:BoundField DataField="contact" HeaderText="Contact" 
                SortExpression="contact" />
            <asp:BoundField DataField="email_id" HeaderText="Email Id" 
                SortExpression="email_id" />
                <asp:BoundField DataField="colg_code" HeaderText="College Code" 
                SortExpression="colg_code" />
           
             <asp:TemplateField>
            <HeaderTemplate>Verify</HeaderTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="lbapprove" runat="server" CommandArgument='<%# Eval("colgid") %>' CommandName="aprve">Approve</asp:LinkButton>&nbsp;|&nbsp;<asp:LinkButton
                    ID="lbdeny" runat="server" CommandArgument='<%# Eval("colgid") %>' CommandName="deny">Deny</asp:LinkButton>
            </ItemTemplate>
            </asp:TemplateField>  
        </Columns>
        <EmptyDataRowStyle Height="40px" />
        <EmptyDataTemplate>No Data Available</EmptyDataTemplate>
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
        SelectCommand="SELECT tbl_College.colgid,tblcolg_detail.clinfo_id, tbl_College.colgname, tblcolg_detail.address,tblcolg_detail.colg_code,tblcolg_detail.contact, tblcolg_detail.email_id FROM tbl_College INNER JOIN tblcolg_detail ON tbl_College.colgid = tblcolg_detail.colg_id WHERE (tblcolg_detail.status = 'Inactive')">
    </asp:SqlDataSource>
</asp:Content>
