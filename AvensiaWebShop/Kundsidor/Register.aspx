<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="AvensiaWebShop.Kundsidor.Register" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="/css/register.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12"></div>
            <h1 class="text-center">Register</h1>
        </div>
    </div>

    <div class="container-fluid">
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-12 registerForm">
                <div class="row">
                    <div class="col-md-6 text-right">
                        First name:
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="inputs"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Enter your first name"
                            ControlToValidate="txtFirstName"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="At least 2 chars letters only"
                            ControlToValidate="txtFirstName"
                            ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 text-right">
                        Last name:
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="inputs"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Enter your first name"
                            ControlToValidate="txtLastName"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="At least 2 chars letters only"
                            ControlToValidate="txtLastName"
                            ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 text-right">
                        E-mail / Username:
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="inputs"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Enter your e-mail"
                            ControlToValidate="txtUserName"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Tex support@flycyckel.se"
                            ControlToValidate="txtUserName"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 text-right">
                        Password:
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="inputs" TextMode="Password"></asp:TextBox>
                         <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Choose a password"
                            ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="txtValidation" runat="server"
                            ErrorMessage="Must have one uppercase one lower case and one number"
                            ControlToValidate="txtPassword"
                            ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{6,15}$"></asp:RegularExpressionValidator>
                       
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 text-right">
                        Confirm password:
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="inputs" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Confirm your password"
                            ControlToValidate="txtConfirmPassword"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="txtValidation" runat="server" ErrorMessage=""
                            ControlToValidate="txtConfirmPassword"
                            ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{6,15}$"></asp:RegularExpressionValidator>
                        <asp:CompareValidator ID="CompareValidator2" CssClass="txtValidation"
                            runat="server"
                            ErrorMessage="Password does not match"
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword"></asp:CompareValidator>

                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-md-push-6">
                        <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-info" OnClick="btnRegister_Click" Text="Register" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-md-push-6 text-left txtValidation">

                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
