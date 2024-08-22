<%@ Page Title="" Language="C#" MasterPageFile="~/collegemaster.master" AutoEventWireup="true" CodeBehind="event_detail.aspx.cs" Inherits="intercollege.event_detail" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<script runat="server">

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["clgconn"].ConnectionString);
        if (con.State != System.Data.ConnectionState.Open)
            con.Open();
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
        cmd.Connection = con;
        cmd.Parameters.AddWithValue("@event_id", Convert.ToInt32(ddlevent.SelectedValue.ToString()));
        cmd.Parameters.AddWithValue("@event_schedule", txtevent.Text);
        cmd.CommandText = "insert into tblevent_result(event_id,event_result) values(@event_id,@event_schedule)";

        int i = cmd.ExecuteNonQuery();
        if (i > 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "info", "alert('success!! ');", true);

        }
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     
     <h1 class="abbr">Update Event Result</h1>

    <table style="width: 100%" height="600px">
        <tr>
            <td style="width: 206px" valign="middle">
                &nbsp;Select Event</td>
            <td valign="middle">
                &nbsp; 
                <asp:DropDownList ID="ddlevent" runat="server" DataSourceID="SqlDataSource1" AppendDataBoundItems="true"
                    DataTextField="event_name" DataValueField="event_id" class="form-control" 
                    Width="95%" >
                    <asp:ListItem Value="0">--  Select Event  --</asp:ListItem>

                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                    SelectCommand="SELECT [event_id], [event_name] FROM [tblevent_notice] WHERE ([colgid] = @colgid)">
                    <SelectParameters>
                        <asp:SessionParameter Name="colgid" SessionField="id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="ddlevent" ErrorMessage="Select Event" 
                    ForeColor="Red" InitialValue="0" ValidationGroup="aaa"></asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
            <td style="width: 206px">
                &nbsp;Result</td>
            <td>
                &nbsp; <asp:TextBox ID="txtevent" runat="server"  TextMode="MultiLine" Columns="120" Rows="20" class="form-control"></asp:TextBox>
                <cc1:HtmlEditorExtender ID="txtevent_HtmlEditorExtender" runat="server" 
                    TargetControlID="txtevent" EnableSanitization="false">
                </cc1:HtmlEditorExtender>
            </td>
        </tr>
        <tr>
            <td style="width: 206px; height: 47px">
                </td>
            <td style="height: 47px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtevent" ErrorMessage="Enter Result" 
                    ForeColor="Red" ValidationGroup="aaa"></asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
            <td style="width: 206px">
                &nbsp;</td>
            <td>
                &nbsp;<asp:Button ID="btnsubmit" runat="server" Text="SUBMIT" 
                    onclick="btnsubmit_Click" BackColor="#26A718" class="form-control"
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                    ValidationGroup="aaa" /></td>
        </tr>
    </table>

    
</asp:Content>
