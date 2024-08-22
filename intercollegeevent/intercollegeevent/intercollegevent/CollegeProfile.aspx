<%@ Page Title="" Language="C#" MasterPageFile="~/collegemaster.master" AutoEventWireup="true" CodeBehind="CollegeProfile.aspx.cs" Inherits="intercollege.CollegeProfile" %>
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
     .style29
     {
         height: 41px;
     }
         
       

    </style>
             
     <script type="text/javascript">
         function validatecontact(contact) {
             if (contact.length != 10) {
                 alert("invalid Mobile Number");
                 document.getElementById("txtcon").value = "";
                 document.getElementById("txtcon").focus();
             }
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="abbr">College Profile</h1>
    <asp:Panel ID="tblprof1" runat="server" Enabled="false">
    
     <table class="style1">
            <tr>
                <td class="style11" valign="top">
                    College Name</td>
                <td class="style12" style="padding-right: 20px">
                   <strong>   <% Response.Write(Session["uname"].ToString()); %></strong>
                </td>
                <td class="style17">
                    College Code</td>
                <td class="style18">
                    <asp:TextBox ID="txtcolgcode" runat="server" CssClass="form-control" 
                        Enabled="False"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtcolgcode"
                        ErrorMessage="Enter College Code" Font-Size="Small" ForeColor="Red" 
                        ValidationGroup="reg"></asp:RequiredFieldValidator>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
           
            <tr>
                <td class="style23" valign="top">
                    Contact no</td>
                <td class="style3" style="padding-right: 20px">
                    <asp:TextBox ID="txtcon" runat="server" CssClass="form-control" onchange="validatecontact(this.value)"></asp:TextBox>
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
                        &nbsp;<asp:FileUpload ID="FileUploadimage" runat="server" 
                            CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="FileUploadimage"
                            ErrorMessage="Upload Photo" Font-Size="Small" ForeColor="Red" 
                            ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style26" valign="top">
                    Alternate no</td>
                <td class="style27" style="padding-right: 20px">
                    <asp:TextBox ID="txtalt" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ControlToValidate="txtalt" ErrorMessage="Only 10 digis allowed" 
                        ValidationExpression="\d{10}"></asp:RegularExpressionValidator>
                    <br />
                    <p>&nbsp;</p> 
                </td>
              <td colspan="2" align="center">
                  <asp:Image ID="Image1" runat="server" width="100px" Height="100px"/>
                </td>
            </tr>
            <tr>
               
                 <td class="style9" valign="top">
                    Longitude</td>
                <td class="style10" style="padding-right: 20px">
                    <asp:TextBox ID="txtlon" runat="server" CssClass="form-control"></asp:TextBox>   
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ErrorMessage="Enter Longitude" ForeColor="#CC0000" 
                        ControlToValidate="txtlon" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
                <td class="style28" valign="top">
                    Lattitude</td>
                <td class="style27">
                    <asp:TextBox ID="txtlan" runat="server" CssClass="form-control"></asp:TextBox>   
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ErrorMessage="Enter Lattitude" ForeColor="#CC0000" 
                        ControlToValidate="txtlan" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
            </tr>
            
           
           
             <tr>
                <td class="style21" valign="top">
                    Address</td>
                <td class="style22" style="padding-right: 20px">
                    <asp:TextBox ID="txtadd" runat="server" TextMode="MultiLine" Rows="3" 
                        CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ErrorMessage="Enter Address" ForeColor="#CC0000" 
                        ControlToValidate="txtadd" Font-Size="Small" ValidationGroup="reg"></asp:RequiredFieldValidator>
                </td>
                 <td class="style15" valign="top">
                    Email id
                </td>
                <td class="style16">
                    <asp:TextBox ID="txtemail" runat="server" 
                        AutoPostBack="True" readonly="true" 
                        CssClass="form-control" Enabled="False"></asp:TextBox>
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
               
                <td  colspan="4" align="center" class="style29">
                </td>
            </tr>
            
        </table>
        </asp:Panel>
        <div id="up_prof" width="100%" style="text-align:center" runat="server" >
     
                <asp:Button ID="btnupdateprofile" runat="server" Text="Update Profile" 
                    BackColor="#94304F" ForeColor="White" 
                    ValidationGroup="Update Profile"  Height="30px" 
                    Width="150px" onclick="btnupdateprofile_Click1"  />&nbsp;
 </div>
  <div id="update_div" width="100%" style="text-align:center;" runat="server" visible="false">
             <asp:Button ID="Button1" runat="server" Text="Update" 
                    BackColor="#94304F" ForeColor="White" 
                    ValidationGroup="Update"  Height="30px" 
                    Width="100px" onclick="btnupdate_Click" />&nbsp;&nbsp;&nbsp;
              <asp:Button ID="btncancel" runat="server" Text="Cancel" 
                   BackColor="#94304F" ForeColor="White" 
                    ValidationGroup="Cancel"  Height="30px" 
                    Width="100px" onclick="btncancel_Click"/>
                    </div>
</asp:Content>
