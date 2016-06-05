<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kassa.aspx.cs" Inherits="AvensiaWebShop.Kassa" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="css/kassa.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12"></div>
            <h1 class="text-center">Shopping cart</h1>
        </div>
    </div>

    <div class="container-fluid">
        <div class="verticalLine"></div>
    </div>

    <asp:Panel ID="panelBasketWIthItems" runat="server" Visible="False">

        <div class="container">
            <div class="row basket">
                <div class="col-md-12">
                    <asp:Repeater ID="repBasket" runat="server" ItemType="AvensiaWebShop.CustomClasses.CartItem" OnItemCommand="repBasket_ItemCommand">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:HiddenField ID="hfArticleID" Value='<%#Item.ProductID %>' runat="server" />
                            <asp:HiddenField ID="hfOrginalAmount" Value='<%#Item.Quantity %>' runat="server" />
                            <div class="row cartRow">
                                <div class="col-md-2">
                                    <img src="/Media.ashx?image=<%#Item.ProductImage %>" />
                                </div>
                                <div class="col-md-4 cartElement">
                                    <p>
                                        <%#Item.ProductName %>
                                    </p>
                                </div>
                                <div class="col-md-2 text-right cartElement">
                                    <asp:Label ID="lblQuantityError" CssClass="txtValidation" runat="server" Text="Label" Visible="False"></asp:Label>
                                    <asp:TextBox ID="txtQuantity" runat="server" Text='<%#Item.Quantity %>' OnTextChanged="OnTextChangedArticleAmount" AutoPostBack="True"></asp:TextBox>
                                </div>

                                <div class="col-md-2 text-right cartElement">
                                    <label><%#string.Format($"{Item.Price:N2}") %> kr</label>
                                </div>

                                <div class="col-md-2 text-right cartElement">
                                    <label><%#string.Format($"{Item.LineSum:N2}") %> kr</label>
                                    <asp:Button ID="btnRemoreItem" CssClass="removeItemButton" runat="server" Text="X" CausesValidation="false" CommandName="RemoveItem" CommandArgument='<%#Item.ProductID %>' />
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>

                </div>
            </div>
            <div class="row cartSum">
                <div class="col-md-1 col-md-push-9 text-right">Sum: </div>
                <div class="col-md-2 col-md-push-9 text-right">
                    <span>
                        <asp:Literal ID="LtCartSum" runat="server" Text="Summa: "></asp:Literal>
                        kr
                    </span>
                </div>
            </div>
        </div>

        <div class="container-fluid verticalLine">
        </div>
    </asp:Panel>

    <asp:Panel ID="panelBasketEmpty" runat="server" Visible="False">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h2>Your cart is empty</h2>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="panelRegister" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="text-center">Checkout</h1>
                </div>
            </div>
            <div class="row kassaInfo">
                <div class="col-md-5 col-md-push-1 orderForm">
                    <fieldset>
                        <legend>Adress:</legend>
                        <%--<div>
                            <label>Social Security Number:</label><br />
                        <asp:TextBox ID="txtPersNr" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                            ControlToValidate="txtPersNr"
                            ErrorMessage="Enter your personnummer"></asp:RequiredFieldValidator>
                        <br />
                        <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                            ControlToValidate="txtPersNr"
                            ErrorMessage="Must be 10-12 numbers"
                            ValidationExpression="[0-9-]{10,13}$"></asp:RegularExpressionValidator>
                        </div>--%>

                        <div>
                            <label>First name:</label><br />
                            <asp:TextBox ID="txtFNamn" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Enter your first name"
                                ControlToValidate="txtFNamn"></asp:RequiredFieldValidator>
                            <br/>
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="At least 2 chars letters only"
                                ControlToValidate="txtFNamn"
                                ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$"></asp:RegularExpressionValidator>
                        </div>
                        <div>
                            <label>Adress:</label><br />
                            <asp:TextBox ID="txtAdress" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                                ControlToValidate="txtAdress"
                                ErrorMessage="Enter your adress"></asp:RequiredFieldValidator>
                            <br/>
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ControlToValidate="txtAdress"
                                ErrorMessage="At least 2 chars letters only"
                                ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$"></asp:RegularExpressionValidator>
                        </div>
                        <div>
                            <label>Zip code:</label><br />
                            <asp:TextBox ID="txtPostNr" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Enter your Zip code"
                                ControlToValidate="txtPostNr"></asp:RequiredFieldValidator>
                            <br/>
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Must be 5-6 numbers"
                                ControlToValidate="txtPostNr"
                                ValidationExpression="[0-9\s]{5,6}$"></asp:RegularExpressionValidator>
                        </div>
                        <div>
                            <label>E-mail:</label><br />
                            <asp:TextBox ID="txtEPost" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Enter your e-mail"
                                ControlToValidate="txtEPost"></asp:RequiredFieldValidator>
                            <br/>
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Tex support@flycyckel.se"
                                ControlToValidate="txtEPost"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-5 col-md-push-1 orderForm">
                    <fieldset>
                        <legend>&nbsp;</legend>
                        <div>
                            <label>Surename:</label><br />
                            <asp:TextBox ID="txtENamn" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Enter your last name"
                                ControlToValidate="txtENamn"></asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="At least 2 chars letters only"
                                ControlToValidate="txtENamn"
                                ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$"></asp:RegularExpressionValidator>
                        </div>
                        <div>
                            <label>C/o:</label><br />
                            <asp:TextBox ID="txtCoAdress" runat="server"></asp:TextBox>
                            <br />
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Enter your C/o adress At least 2 chars letters only"
                                ControlToValidate="txtCoAdress"
                                ValidationExpression="[a-zA-Z0-9].{1,25}$"></asp:RegularExpressionValidator>
                        </div>
                        <div>
                            <label>City:</label><br />
                            <asp:TextBox ID="txtOrt" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Enter your city"
                                ControlToValidate="txtOrt"></asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="At least 2 chars letters only"
                                ControlToValidate="txtOrt"
                                ValidationExpression="[a-zA-ZåäöÅÄÖ].{1,25}$"></asp:RegularExpressionValidator>
                        </div>
                        <div>
                            <label>Phone number:</label><br />
                            <asp:TextBox ID="txtTeleNr" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Enter your telephone number"
                                ControlToValidate="txtTeleNr"></asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator CssClass="txtValidation" runat="server"
                                ErrorMessage="Must be between 5-12 numbers"
                                ControlToValidate="txtTeleNr"
                                ValidationExpression="[0-9]{5,12}$"></asp:RegularExpressionValidator>
                        </div>
                    </fieldset>
                </div>
            </div>

            <div class="row">
                <div class="col-md-5 col-md-push-1">
                    <fieldset>
                        <legend>Form of payment:
                        </legend>
                        <asp:RadioButtonList ID="rblPaymentOptions" runat="server"></asp:RadioButtonList>
                    </fieldset>
                </div>
                <div class="col-md-5 col-md-push-1  ">
                    <fieldset>
                        <legend>Delivery:</legend>
                        <asp:RadioButtonList ID="rblDeliveryOptions" runat="server" OnSelectedIndexChanged="rblDeliveryOptions_SelectedIndexChanged" AutoPostBack="True"></asp:RadioButtonList>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-md-11 col-md-push-1 totalSum ">
                    <span>Total Sum:
                        <asp:Literal ID="ltTotalPriceWithFreight" runat="server"></asp:Literal>
                        kr
                    </span>
                </div>
            </div>
            <div class="row">
                <div class="col-md-11 col-md-push-1">
                    <asp:Button ID="btnConfirmOrder" CssClass="btn btn-primary" runat="server" Text="Submit order" OnClick="btnConfirmOrder_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
