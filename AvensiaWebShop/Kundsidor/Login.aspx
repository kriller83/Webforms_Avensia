<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AvensiaWebShop.Kundsidor.Login" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="/css/login.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12"></div>
            <h1 class="text-center">Login</h1>
        </div>
    </div>

    <div class="container-fluid">
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-12 loginForm">
                <div class="row">
                    <div class="col-md-6 text-right">
                        E-mail / Username:
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="loginInput"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Enter your e-mail"
                            ControlToValidate="txtUserName"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 text-right">
                        Password:<br />
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="loginInput" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ErrorMessage="Enter your password"
                            ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-md-push-6">
                        <asp:Button ID="btnLogIn" runat="server" CssClass="btn btn-info" OnClick="btnLogIn_Click" Text="Logga in" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-md-push-6">
                        <asp:Label ID="lblStatus" CssClass="text-danger" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
