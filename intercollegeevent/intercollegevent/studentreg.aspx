<%@ Page Title="" Language="C#" MasterPageFile="~/collegeevent.Master" AutoEventWireup="true" CodeBehind="studentreg.aspx.cs" Inherits="intercollege.studentreg1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<script runat="server">

   
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 314px;
        }
    .style7
    {
        width: 314px;
        height: 58px;
    }
    .style8
    {
        height: 58px;
    }
    .style9
    {
        width: 314px;
        height: 48px;
    }
    .style10
    {
        height: 48px;
    }
    .style11
    {
        width: 314px;
        height: 77px;
    }
    .style12
    {
        height: 77px;
    }
    .style13
    {
        width: 314px;
        height: 42px;
    }
    .style14
    {
        height: 42px;
    }
        .style15
        {
            width: 314px;
            height: 41px;
        }
        .style16
        {
            height: 41px;
        }
        
        
        
       
    </style>
    <script type="text/javascript">
        function validateRB() {
            var rbmale = document.getElementById("radmale");
            var rbfemale = document.getElementById("radfemale");

            if (!rbmale.checked && !rbfemale.checked) {
                alert('Select Gender.');

                if (document.getElementById("textcon").value.length != 10) {
                    alert("Invalid Mobile Number");
                }
            }
        }
    </script>
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h1 class="abbr">Student Registration</h1>
  <table class="style1">
            <tr>
                <td class="style15">
                    College</td>
                <td class="style16">
                
            </tr>
            <tr>
                <td class="style2">
                    Student name</td>
                <td>
                    <asp:TextBox ID="txtstuname" runat="server"  
                        CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="Enter student name" ForeColor="#CC0000" 
                        ControlToValidate="txtstuname" Font-Size="Small" ValidationGroup="reg" 
                        Height="30px"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Registration number</td>
                <td>
                    <asp:TextBox ID="txtreg" runat="server" 
                        ontextchanged="txtreg_TextChanged" AutoPostBack="true" 
                        CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ErrorMessage="Enter registration Number" ForeColor="#CC0000" 
                        ControlToValidate="txtreg" Font-Size="Small" ValidationGroup="reg" 
                        Height="24px"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style13">
                    Gender</td>
                <td class="style14">
                    <asp:RadioButton ID="radmale" runat="server" Text="Male" GroupName="gender" 
                        ClientIDMode="Static"/>
&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:RadioButton ID="radfemale" runat="server" Text="Female" GroupName="gender" 
                        ClientIDMode="Static"/>
&nbsp;&nbsp;&nbsp;

                  

                    </td>
            </tr>
            <tr>
                <td class="style11">
                    Admission year</td>
                <td class="style12">
                    <asp:DropDownList ID="lstyear" runat="server" 
                        CssClass="form-control">
                        <asp:ListItem Value="0">-- Select Year --</asp:ListItem>
                        <asp:ListItem>2020-21</asp:ListItem>
                        <asp:ListItem>2022-23</asp:ListItem>
                        <asp:ListItem>2021-22</asp:ListItem>
                        <asp:ListItem>2019-20</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="lstyear" ErrorMessage="Select year" Font-Size="Small" 
                        ForeColor="Red" ValidationGroup="reg" Height="26px" InitialValue="0"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Select course</td>
                <td>
                    <asp:DropDownList ID="lstcousre" runat="server" DataSourceID="SqlDataSource1" AppendDataBoundItems="true"
                        DataTextField="course_name" DataValueField="courseid" 
                        CssClass="form-control">
                        <asp:ListItem Value="0">--Select Course--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:clgconn %>" 
                        SelectCommand="SELECT [courseid], [course_name] FROM [tbl_course]">                       
                    </asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ErrorMessage="Select course" ForeColor="#CC0000" 
                        ControlToValidate="lstcousre" InitialValue="0" Font-Size="Small" 
                        ValidationGroup="reg" Height="20px"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style9">
                    Contact number</td>
                <td class="style10">
                    <asp:TextBox ID="textcon" runat="server" onchange="validatecontact(this.value)" ClientIDMode="static"
                        CssClass="form-control"></asp:TextBox>
                    <cc1:FilteredTextBoxExtender ID="textcon_FilteredTextBoxExtender" 
                        runat="server" BehaviorID="textcon_FilteredTextBoxExtender" 
                        FilterType="Numbers" TargetControlID="textcon">
                    </cc1:FilteredTextBoxExtender>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ErrorMessage="Enter contact number" ForeColor="#CC0000" 
                        ControlToValidate="textcon" Font-Size="Small" ValidationGroup="reg" 
                        Height="28px"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="textcon" ErrorMessage="enter only 10 digits" 
                        ValidationExpression="\d{10}"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="style7">
                    Email id</td>
                <td class="style8">
                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" ontextchanged="txtemail_TextChanged" 
                        ></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txtemail" ErrorMessage="Invalid Emailid" Font-Size="Small" 
                        ForeColor="#CC0000" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        ValidationGroup="reg" Height="33px"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="txtemail" ErrorMessage="enter email"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" ValidationGroup="reg" BackColor="#5875B1" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                        onclick="btnsubmit_Click" OnClientClick="validateRB()" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <asp:Button ID="btncancle" runat="server" Text="cancel" BackColor="#5875B1" 
                        Font-Bold="True" ForeColor="White" Height="30px" Width="100px" 
                        onclick="btncancle_Click" />
                </td>
            </tr>
        </table>
</asp:Content>
