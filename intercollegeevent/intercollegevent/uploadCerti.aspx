<%@ Page Title="" Language="C#" MasterPageFile="~/collegeevent.Master" AutoEventWireup="true" CodeBehind="uploadCerti.aspx.cs" Inherits="intercollege.uploadCerti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     
     <h1 class="abbr">Update Event Certificate</h1>
 <table style="width: 100%"  >
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
                    
                    SelectCommand="SELECT event_id, event_name FROM tblevent_notice WHERE (colgid = @colgid) AND (event_date &lt; { fn CURDATE() })">
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
                &nbsp;Certificate</td>
            <td>
                &nbsp;    <asp:FileUpload ID="UP_IMAGE" runat="server" Multiple="Multiple" 
                    accept=".png,.jpg,.jpeg" CssClass="form-control" Width="100%"/>
                         <span style="color: #0000FF; font-weight: bold">Can upload more than one file at a time</span><br />
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="UP_IMAGE"
                    ErrorMessage="Please Select Certificate" ForeColor="Red"></asp:RequiredFieldValidator>
               
            </td>
        </tr>
        <tr>
            <td style="width: 206px; height: 47px">
            Select College
                </td>
            <td style="height: 47px">
                <asp:DropDownList ID="ddlcollege" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="SqlDataSource2" DataTextField="colgname" 
                    DataValueField="colgid" Width="95%" CssClass="form-control" >
                    <asp:ListItem Value="0">-- Select College --</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ErrorMessage="Select College" ForeColor="#CC0000" 
                        ControlToValidate="ddlcollege" Font-Size="Small" ValidationGroup="aaa" 
                        InitialValue="0"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                    SelectCommand="SELECT * FROM [tbl_college] where colgname=@a">
                    <SelectParameters>
                        <asp:SessionParameter Name="a" SessionField="uname" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </td>
        </tr>
       
        <tr>
            <td style="width: 206px">
                &nbsp;</td>
            <td>
                &nbsp;<asp:Button ID="btnsubmit" runat="server" Text="SUBMIT" 
                    onclick="btnsubmit_Click" BackColor="#009688" class="form-control"
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                    ValidationGroup="aaa" /></td>
        </tr>
    </table>

    <h2 align="center">View</h2>
    
    <asp:GridView ID="GridView1" runat="server" Width="97%" CellPadding="4" 
        ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource3" DataKeyNames="fileid" 
        onrowcommand="GridView1_RowCommand">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="fileid" HeaderText="fileid" visible="false"
                SortExpression="fileid" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="event_name" HeaderText="Event Name" 
                SortExpression="event_name" />
            <asp:BoundField DataField="event_date" HeaderText="Conducted On" 
                SortExpression="event_date" />
            <asp:BoundField DataField="certificate" HeaderText="Certificate" 
                SortExpression="certificate" />
                <asp:TemplateField>
               <HeaderTemplate>Action</HeaderTemplate>
                  <ItemTemplate>
                    
                  <asp:ImageButton ID="btndel" runat="server"  CommandName="del" CommandArgument='<%# Eval("fileid") %>' ImageUrl="~/images/del.png" Height="22px" Width="22px" OnClientClick="return val()"/>
                   </ItemTemplate>
                   </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#7C6F57" Height="40px" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" 
            Height="40px" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" Height="40px" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />

    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
        
        SelectCommand="SELECT tblcertficate.fileid, tblevent_notice.event_name, tblevent_notice.event_date, tblcertficate.certificate FROM tblcertficate INNER JOIN tbl_College ON tblcertficate.colgid = tbl_College.colgid INNER JOIN tblevent_notice ON tbl_College.colgid = tblevent_notice.colgid AND tblcertficate.eventid = tblevent_notice.event_id WHERE (tblcertficate.colgid = @id)">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
