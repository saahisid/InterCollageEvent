<%@ Page Title="" Language="C#" MasterPageFile="~/collegeevent.Master" AutoEventWireup="true" CodeBehind="manageEnotice.aspx.cs" Inherits="intercollege.manageEnotice" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<script runat="server">

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
    int eventid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string))
        {
            Response.Redirect("index.aspx");
        }
        if (!string.IsNullOrEmpty(Request.QueryString["event"] as string))
        {
            eventid = Convert.ToInt32(Request.QueryString["event"].ToString());
            if (!IsPostBack)
            {
                filleventdata(eventid);
            }
        }

    }

    public void filleventdata(int eventid)
    {
        if (con.State != ConnectionState.Open)
            con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.Parameters.AddWithValue("@eventid", eventid);
        cmd.CommandText = "Select * from tblevent_notice where event_id=@eventid";
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {
            txtevent.Text = dt.Rows[0]["event_name"].ToString();
            txtdes.Text = dt.Rows[0]["event_desc"].ToString();
           // txtevedate.Text = (dt.Rows[0]["event_date"]).ToString();
            ddlcolg.SelectedValue = dt.Rows[0]["colgid"].ToString();

            if (dt.Rows[0]["event_type"].ToString().Trim() == "Sports")
            {
                rbsports.Checked = true;
                rbculture.Checked = false;
                rbothers.Checked = false;
            }
            else if (dt.Rows[0]["event_type"].ToString().Trim() == "Culture")
            {
                rbsports.Checked = false;
                rbculture.Checked = true;
                rbothers.Checked = false;
            }
            else
            {
                rbsports.Checked = false;
                rbculture.Checked = false;
                rbothers.Checked = true;
            }

            btnsubmit.Text = "Update";
        }

    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (con.State != ConnectionState.Open)
            con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        string event_type = string.Empty;
        if (rbculture.Checked)
            event_type = "Culture";
        else if (rbsports.Checked)
            event_type = "Sports";
        else
            event_type = "Other";

        string filename = string.Empty;
        if (up_file.HasFile)
        {
            filename = up_file.FileName;
            up_file.SaveAs(Server.MapPath("~/uploads/" + filename));
        }
        else
        {
            if (btnsubmit.Text == "Update")
            {
                filename = filecopy.HRef;
                txtevedate.Text = "";
            }
        }

        cmd.Parameters.AddWithValue("@evenname", txtevent.Text);
        cmd.Parameters.AddWithValue("@descrition", txtdes.Text);
        cmd.Parameters.AddWithValue("@eventdate", DateTime.ParseExact(txtevedate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
        cmd.Parameters.AddWithValue("@eventupload", "uploads/" + filename);
        cmd.Parameters.AddWithValue("@colname", Convert.ToInt32(ddlcolg.SelectedValue.ToString()));
        cmd.Parameters.AddWithValue("@event_type", event_type);
        cmd.Parameters.AddWithValue("@status", "Active");

        if (btnsubmit.Text == "Update")
        {
            cmd.Parameters.AddWithValue("@event", eventid);
            cmd.CommandText = "update tblevent_notice set event_name=@evenname,event_desc=@descrition,event_date=@eventdate,event_file=@eventupload,colgid=@colname,event_type=@event_type where event_id=@event";
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! Record Updated.');window.location='ManageEvents.aspx';", true);
            }
        }
        else
        {
            cmd.CommandText = "insert into tblevent_notice(event_name,event_desc,event_date,event_file,colgid,status,event_type) values(@evenname,@descrition,@eventdate,@eventupload,@colname,@status,@event_type)";
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! Record Added.')", true);
                clearform();
            }
        }


    }

    public void clearform()
    {
        txtdes.Text = "";
        txtevedate.Text = "";
        txtevent.Text = "";
        ddlcolg.SelectedIndex = 0;
    }

        

      
    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <h1 class="abbr">Manage Event</h1>
 <table class="style1" width="75%" align="center">
            <tr>
                <td class="style2">
                    Event name&nbsp;</td>
                <td>
                    <asp:TextBox ID="txtevent" runat="server"   
                        CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtevent" ErrorMessage="Enter Event Name" 
                        ForeColor="#CC0000" ValidationGroup="add" Font-Size="Small"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Description</td>
                <td>
                    <asp:TextBox ID="txtdes" runat="server" TextMode="MultiLine" Rows="3" 
                          CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtdes" ErrorMessage="Enter Description" 
                        ForeColor="#CC0000" ValidationGroup="add" Font-Size="Small"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Event date
                </td>
                <td>
                    <asp:TextBox ID="txtevedate" runat="server"   
                        CssClass="form-control"></asp:TextBox>
                    <cc1:calendarextender ID="txtevedate_CalendarExtender" runat="server" Format="dd/MM/yyyy"
                        BehaviorID="txtevedate_CalendarExtender" TargetControlID="txtevedate">
                    </cc1:calendarextender>
                    <asp:comparevalidator ID="Comparevalidator1" runat="server" 
  errormessage="The date must be greater than today" Operator="GreaterThan"
  controltovalidate="txtevedate" type="string" ValidationGroup="add" Font-Size="Small" ForeColor="Blue" 
                        Height="32px" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="txtevedate" ErrorMessage="Enter Event Date" 
                        ForeColor="#CC0000" ValidationGroup="add" Font-Size="Small"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2" style="height: 54px">
                    Upload event copy</td>
                <td style="height: 54px">
                    <asp:FileUpload ID="up_file" runat="server" accept=".pdf,.PDF" 
                        CssClass="form-control"/>  <a id="filecopy" runat="server" target="_blank" visible="false">View</a>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="up_file" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Select college
                </td>
                <td>
                    <asp:DropDownList ID="ddlcolg" runat="server" DataSourceID="SqlDataSource1" AppendDataBoundItems="true"
                        DataTextField="colgname" DataValueField="colgid"   CssClass="form-control">
                    <asp:ListItem Value="0">-- Select --</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                        
                        SelectCommand="SELECT [colgid], [colgname] FROM [tbl_College] where colgname=@a">
                        <SelectParameters>
                            <asp:SessionParameter Name="a" SessionField="uname" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="ddlcolg" ErrorMessage="Select College" 
                        ForeColor="#CC0000" InitialValue="0" ValidationGroup="add" 
                        Font-Size="Small"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2" style="height: 54px">
                    Event Type</td>
                <td style="height: 54px">
                    <asp:RadioButton ID="rbsports" runat="server" Text="Sport" 
                       GroupName="eventtype" />
&nbsp;<asp:RadioButton ID="rbculture" runat="server"  Text="Culture" GroupName="eventtype" 
                        Checked="True" />
&nbsp;
                    <asp:RadioButton ID="rbothers" runat="server" Text="Other" 
                        GroupName="eventtype" />
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" 
                        ValidationGroup="add" onclick="btnsubmit_Click" BackColor="#5875B1" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btncancle" runat="server" Text="Cancel" BackColor="#5875B1" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" />
                </td>
            </tr>
        </table>
</asp:Content>
