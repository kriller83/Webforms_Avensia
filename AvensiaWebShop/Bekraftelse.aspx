<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bekraftelse.aspx.cs" Inherits="AvensiaWebShop.Bekraftelse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Confirmation - FlyCycle</title>
    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <link href="css/Bekraftelsesida.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />
</head>
<body>
    <form id="formConfirm" runat="server">
        <div class="container">
            <div class="row orderHead">
                <div class="col-md-1 loggo">
                    <a href="Hem.aspx">
                        <img class="center-block" src="Images/loggo_cropped_85x65.png" />
                    </a>
                </div>
                <div class="col-md-7">
                    <h1>Order confirmation</h1>
                    <h3 class="orderId">
                        <asp:Literal ID="legendText" runat="server">Order</asp:Literal>
                    </h3>

                </div>
                <div class="col-md-4 text-left">
                    <div class="row smallTopMenu">
                        <div class="col-md-6 text-right">
                            <div>
                                <a href="/Hem.aspx">Home</a>
                            </div>
                            <div>
                                <a href="/Kundsidor/Logout.aspx">Logout</a>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div>
                                <a href="/Hem.aspx#Villkor">Terms</a>
                            </div>
                            <div>
                                <a href="/Kontakt.aspx">Contact</a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row mainCont">
                <div class="col-md-1"></div>
                <div class="col-md-10 orderDetails">
                    <div class="row address">

                        <div id="adressbox" class="col-md-4">
                            <p>
                                Name:
                                    <asp:Literal ID="name" runat="server">name</asp:Literal>
                                <br />
                                Adress:
                                    <asp:Literal ID="adress" runat="server">Adress</asp:Literal>
                            </p>
                        </div>
                    </div>

                    <div class="row products">
                        <div id="orderdProductsList" class="col-md-12">
                            <asp:Repeater ID="repProductList" ItemType="AvensiaWebShop.Models.SalesOrderDetail" runat="server">
                                <HeaderTemplate>
                                </HeaderTemplate>

                                <ItemTemplate>
                                    <div class="row oneProduct">
                                        <div class="col-md-8 prodName">
                                            <div class="produkt"><%#(Container.ItemIndex +1) %>. <%#Item.Product.Name %> </div>
                                        </div>
                                        <div class="col-md-2 prodPrice text-right">
                                            <p class="produktPris">
                                                <%#string.Format($"{Item.OrderQty}") %> st
                                            </p>
                                        </div>
                                        <div class="col-md-2 prodPrice text-right">
                                            <p class="produktPris">
                                                <%#string.Format($"{Item.LineTotal:N2}") %> kr
                                            </p>
                                        </div>
                                    </div>
                                </ItemTemplate>

                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:Repeater>

                            <div class="row oneProduct">
                                <div class="col-md-10 prodName">
                                    <div class="produkt">
                                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:Literal ID="ltFreigtLabel" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                <div class="col-md-2 prodPrice text-right">
                                    <p class="produktPris">
                                        <asp:Literal ID="ltFreightPrice" runat="server"></asp:Literal>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 col-md-push-9 prodTotalPrice">
                            <p id="prisParag">
                                <span class="pull-left">Total:</span>
                                &nbsp;
                                <span class="pull-right">
                                    <asp:Literal ID="pris" runat="server"></asp:Literal></span>
                            </p>
                        </div>
                    </div>
                    <div class="row ">

                        <div class="col-md-3 col-md-push-9 addInfo text-right">
                            <span class="pull-left">Tax included:
                            </span>
                            &nbsp;
                    <span class="pull-right">
                        <asp:Literal ID="ltTax" runat="server"></asp:Literal>
                        kr
                    </span>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-10 col-md-push-1 infoAboutMail">
                        
                        <asp:Panel ID="panelMail" runat="server">
                            <p>
                                Confirmation sent to <span><asp:Literal ID="mail" runat="server"></asp:Literal>.</span>
                            </p>
                        </asp:Panel>

                        <asp:Panel ID="panelMailError" CssClass="errorTextRed" runat="server" Visible="False">
                            <p>
                                Problems arose while sending the confirmation mail. Please print this page as reference. 
                            </p>
                        </asp:Panel>
                        
                        <p>
                            Thank you,<br />
                            <span class="companyName">Fly</span>Cycle Team
                        </p>
                    </div>
                    <div class="col-md-1"></div>
                </div>
                <div class="row orderFooter">
                    <div id="foretagsInfo" class="col-md-12">
                        <span class="companyName">Fly</span>Cycle | Sveavägen 18, 215 67 Helsingborg | 044 - 89 48 57
                    <br />
                        Copyright 2016 <span class="companyName">Fly</span>Cycle. All rights reserved.
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
