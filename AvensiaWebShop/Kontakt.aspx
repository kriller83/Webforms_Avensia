<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kontakt.aspx.cs" Inherits="AvensiaWebShop.Kontakt" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="css/kontakt.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-push-3">
                <h1>Kontakt Sida</h1>

            </div>
        </div>
    </div>

    <div class="container-fluid verticalLine">
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-push-3">
                <div>
                    <label>Phone number:</label>
                    <label>0123456789</label>
                </div>
                <div>
                    <label>E-mail:</label>
                    <a href="#">support@flycycle.se</a>
                </div>
                <div>
                    <label>Purchase terms:</label>
                    <a href="/Hem.aspx#Villkor">Here you will find our Conditions of Purchase
                    </a>
                </div>
            </div>
        </div>

        <asp:Panel ID="panelContactForm" CssClass="row" runat="server">
            <div class="col-md-9 col-md-push-3">
                <div class="kontaktForm">
                    <h3>Contact form</h3>
                    <div class="kontaktForm">
                        <label>Category*</label><br />
                        <asp:DropDownList ID="ddlOptions" CssClass="formField ddlKontaktForm" runat="server">
                            <asp:ListItem Value="Alternative"></asp:ListItem>
                            <asp:ListItem Value="Payment"></asp:ListItem>
                            <asp:ListItem Value="Delivery"></asp:ListItem>
                            <asp:ListItem Value="Order"></asp:ListItem>
                            <asp:ListItem Value="Purchase on approval"></asp:ListItem>
                            <asp:ListItem Value="Other"></asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="formAlert" runat="server" ControlToValidate="ddlOptions" InitialValue="Alternativ" ErrorMessage="Select alternativ" Visible="True"></asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="txtFirstName" CssClass="formField" runat="server" placeholder=" First name*"></asp:TextBox>
                        <asp:TextBox ID="txtForLastName" CssClass="formField" runat="server" placeholder=" Surename*"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="formAlert" runat="server"
                            ControlToValidate="txtFirstName"
                            ErrorMessage="First name is required" Visible="True"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="formAlert" runat="server"
                            ControlToValidate="txtForLastName"
                            ErrorMessage="Surename is required" Visible="True"></asp:RequiredFieldValidator><br />

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="formAlert formAlertMarg" runat="server"
                            ControlToValidate="txtFirstName"
                            ErrorMessage="At least 2 chars, only letters"
                            ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$" Visible="True"></asp:RegularExpressionValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="formAlert" runat="server" ControlToValidate="txtForLastName"
                            ErrorMessage="At least 2 chars, only letters"
                            ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$" Visible="True"></asp:RegularExpressionValidator>
                        <br />
                        <asp:TextBox ID="txtEmail" CssClass="formField" runat="server" placeholder="Email*"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="formAlert" runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email is required"
                            SetFocusOnError="True" Visible="True"></asp:RequiredFieldValidator><br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="formAlert" runat="server"
                            ErrorMessage="Invalid Email" ControlToValidate="txtEmail"
                            SetFocusOnError="True"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Visible="True">
                        </asp:RegularExpressionValidator>
                        <br />
                        <br />
                        <asp:TextBox ID="txtMailContent" CssClass="formField txtAreaKontaktForm" runat="server" TextMode="MultiLine" placeholder="Write your message here*"></asp:TextBox>
                        <%--<textarea id="TextAreaForKontaktPage" cols="100" rows="4" placeholder="Här kan du skriva ditt meddelande"></textarea>--%>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" CssClass="formAlert" runat="server"
                            ControlToValidate="txtMailContent"
                            ErrorMessage="Write your message" Visible="True"></asp:RequiredFieldValidator><br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="formAlert" runat="server" ErrorMessage="Invalid entry"
                            ControlToValidate="txtMailContent"
                            ValidationExpression="[a-zA-Z0-9].{1,250}$" Visible="True"></asp:RegularExpressionValidator>
                        <div>
                            <asp:Button ID="SubmitTxtButton" runat="server" Text="Send" OnClick="SubmitTxtButton_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="panelConfirm" CssClass="row" runat="server" Visible="False">
            <div class="col-md-12 col-md-push-3">
                <div class="row kontaktForm">
                    <div class="col-md-12">
                        <h3>Thank you!</h3>
                    </div>
                </div>
                <div class="row kontaktForm">
                    <div class="col-md-12">
                        <p>
                            We are hapy that your charing and will read your mail and take apropriet acction.
                        </p>
                        <p>
                            Many thaks form the <span class="companyName">Fly</span>Cycle team.
                        </p>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="panelError" CssClass="row" runat="server" Visible="false">
            <div class="col-md-12 col-md-push-3">
                <div class="row kontaktForm">
                    <div class="col-md-12">
                        <h3>Some thing went wrong!</h3>
                    </div>
                </div>
            <%--<div class="row kontaktForm">
                    <div class="col-md-12">
                        <p>
                            Your electronic letter seems to have parishes in cyberspace. Please give us a call so we can help you or just sbe a friend in need.
                        </p>
                    </div>
                </div>--%>
            </div>
        </asp:Panel>

    </div>
</asp:Content>
