<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Produkter.aspx.cs" Inherits="AvensiaWebShop.Produkter" %>

<%@ Import Namespace="AvensiaWebShop.Controller" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script src="js/produkter.js"></script>
    <link href="css/products-categoryView.css" rel="stylesheet" />
    <link href="css/products-productListView.css" rel="stylesheet" />
    <link href="css/products-productView.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <asp:Panel ID="panelH1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="text-center">
                        <asp:Literal ID="ltPageHeader" runat="server">
                        </asp:Literal>
                    </h1>
                </div>
            </div>
        </div>
        <div class="container-fluid verticalLine">
        </div>
    </asp:Panel>

    <div class="container">
        <asp:Panel ID="panelNoProducts" CssClass="col-md-8 col-md-push-2" runat="server">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h2>We have bean looking around but did not find any thing matching your search.                       
                    </h2>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="panelCategories" CssClass="categoryView" runat="server">
                <div class="row">
                    <asp:Panel ID="PanelCategoryMenu" CssClass="" runat="server">
                        <nav class="nav categoryMenu col-md-2">
                            <asp:Repeater ID="repSubMenu" runat="server">
                                <HeaderTemplate>
                                    <ul>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li>
                                        <a href='Produkter.aspx?<%=WebShopController.UrlQueryKeyCategoryID %>=<%=CategoryIDQueryString %>&<%=WebShopController.QueryKeyProductCategoryID %>=<%#Eval("ProductCategoryID") %>'><%#Eval("Name") %></a>
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>
                        </nav>
                    </asp:Panel>
                    <asp:Panel ID="panelCategoryDescription" CssClass="col-md-8" runat="server">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Image ID="imgCategoryImage" runat="server" />
                            </div>
                        </div>
                        <div class="row categoryDescripitonRow">
                            <div class="col-md-12">
                                <asp:Literal ID="ltCategoryDescripton" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="panelProductList" CssClass="col-md-8" runat="server">
                        <div id="productListView">
                            <div class="row filterRow">
                                <div class="col-md-12">
                                    <div class="text-center">
                                        <asp:DropDownList ID="ddlColor" runat="server" Visible="False" OnSelectedIndexChanged="filterDdl_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                        <asp:DropDownList ID="ddlSize" runat="server" Visible="False" OnSelectedIndexChanged="filterDdl_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                        <asp:DropDownList ID="ddlOrderBy" runat="server" Visible="true" OnSelectedIndexChanged="filterDdl_SelectedIndexChanged" AutoPostBack="True">
                                            <asp:ListItem Text="Name" Value="name"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlSortorder" runat="server" Visible="true" OnSelectedIndexChanged="filterDdl_SelectedIndexChanged" AutoPostBack="True">
                                            <asp:ListItem Text="Ascending" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Descending" Value="-1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div id="chosenCategoryList" class="row">
                                <div class="col-md-12">
                                    <asp:Repeater ID="repProductList" runat="server" OnItemCommand="repProductList_ItemCommand">
                                        <HeaderTemplate>
                                        </HeaderTemplate>


                                        <ItemTemplate>
                                            <div class='row productListRow'>
                                                <div class="col-md-4 testingx productListItem">
                                                    <a href="/Produkter.aspx?<%=WebShopController.UrlQueryKeyCategoryID %>=<%=CategoryIDQueryString %>&<%=WebShopController.QueryKeyProductModelID %>=<%#Eval("ProductModelID") %>">
                                                        <img src="<%#($"/Media.ashx?image={Eval("LargePhotoFileName")}") %>" />
                                                    </a>

                                                </div>
                                                <div class="col-md-8">
                                                    <div class="row">
                                                        <div class="col-md-9 productListItemName">
                                                            <a href="/Produkter.aspx?<%=WebShopController.UrlQueryKeyCategoryID %>=<%=CategoryIDQueryString %>&<%=WebShopController.QueryKeyProductModelID %>=<%#Eval("ProductModelID") %>">
                                                                <h4><%#Eval("ProductModel") %></h4>
                                                            </a>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="productListItemPrice">
                                                                <%#string.Format($"{Eval("ListPrice"):N2}") %> kr
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <a href="/Produkter.aspx?<%=WebShopController.UrlQueryKeyCategoryID %>=<%=CategoryIDQueryString %>&<%=WebShopController.QueryKeyProductModelID %>=<%#Eval("ProductModelID") %>">
                                                                <div class="productListItemDescription">
                                                                    <%# Eval("Description") %>
                                                                </div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>



                                        <%--<ItemTemplate>
                                            <%#(Container.ItemIndex != 0 && Container.ItemIndex % 3 ==0) ? "</div>":string.Empty  %>
                                            <%#(Container.ItemIndex % 3 ==0) ? "<div class='row productListRow'>":string.Empty  %>
                                            <div class="col-md-4 testingx productListItem">
                                                <a href="/Produkter.aspx?<%=WebShopController.UrlQueryKeyCategoryID %>=<%=CategoryIDQueryString %>&<%=WebShopController.QueryKeyProductModelID %>=<%#Eval("ProductModelID") %>">
                                                    <img src="<%#($"/Media.ashx?image={Eval("LargePhotoFileName")}") %>" />
                                                    <h4><%#Eval("ProductModel") %></h4>
                                                    <p>
                                                        <%# Eval("Description") %>
                                                    </p>
                                                    <p>
                                                        <%#string.Format($"{Eval("ListPrice"):N2}") %> kr
                                                    </p>
                                                </a>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </div>
                                        </FooterTemplate>--%>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="col-md-2 banner">
                        <asp:Repeater ID="repCampaign" runat="server" ItemType="AvensiaWebShop.Models.Kampanj">
                            <HeaderTemplate></HeaderTemplate>
                            <ItemTemplate>
                                <div class="row">
                                    <div class="col-md-12 annons">
                                        <asp:HyperLink ID="HyperLink1" runat="server" ImageUrl='<%#"Images/Annonser/"+Item.KampanjImageName%>' NavigateUrl="<%#Item.KampanjURL%>">HyperLink</asp:HyperLink>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate></FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>

        </asp:Panel>

        <asp:Panel ID="panelProductView" runat="server">
            <asp:HiddenField ID="hfActiveProduct" Value="-1" runat="server" />
            <div id="productView" class="row productInfo">
                <div class="row productInfo">
                    <div class="col-md-6 text-center">
                        <div>
                            <asp:Image ID="imgMainImage" CssClass="mainProductImage" runat="server" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h1 class="center-block">
                            <asp:Literal ID="ltArticleName" runat="server"></asp:Literal>
                        </h1>
                        <p>
                            <asp:Literal ID="ltArticleDescription" runat="server"></asp:Literal>
                        </p>
                        <div>
                            Artikelnumer:
                        <asp:Literal ID="ltArticleNumber" runat="server"></asp:Literal>
                        </div>

                        <asp:Panel ID="panelArticleOptions" runat="server" Visible="False">
                            <div class="artikleRow"></div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="atricleOptions">
                                        <label>Options</label>
                                    </div>
                                    <asp:DropDownList ID="ddlArticleChoises" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlArticleChoises_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                            </div>
                        </asp:Panel>

                        <div class="artikleRow"></div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row artiklePrice">
                                    <div class="col-md-12 artiklePrice">
                                        <label>
                                            <asp:Label ID="lbArticlePrice" runat="server" Text="Active Price"></asp:Label>
                                            kr
                                        </label>
                                    </div>
                                </div>
                                <asp:Panel ID="panelArticleOriginalPrice" CssClass="artikleOrignialPrice" runat="server">
                                    <div class="row">
                                        <div class="col-md-12 artiklePrice">
                                            <label class="artikleOrignialPrice">
                                                <asp:Literal ID="ltArticleOrginalPrice" runat="server" Text="Orinal Price"></asp:Literal>
                                                kr
                                            </label>
                                        </div>
                                    </div>
                                </asp:Panel>

                                <input type="button" id="btnArticleMinusAmount" value="-" />
                                <asp:TextBox ID="txtArticleAmount" CssClass="txtArticleAmount text-center" runat="server" Text="1" Enabled="true"></asp:TextBox>
                                <input type="button" id="btnArticlePlusAmount" value="+" />
                                <asp:Button ID="btnAddToCart" CssClass="btnAddToCart" runat="server" Text="Köp" OnClick="btnAddToCart_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

