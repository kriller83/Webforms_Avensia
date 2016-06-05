<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Hem.aspx.cs" Inherits="AvensiaWebShop.Hem" %>

<%@ Import Namespace="AvensiaWebShop.Controller" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script src="js/hem.js"></script>
    <link href="css/hem.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="ContentCarousell" ContentPlaceHolderID="ContentPlaceHolderCarousell" runat="server">
    <div class="container-fluid carusellContainer">
        <div id="myCarousel" class="carousel slide mainImage" data-ride="carousel">
            <div class="carousel-inner">
                <div class="item active">
                    <img src="Images/adventure_wide_cropped_H500.jpg" alt="..." />
                </div>
                <div class="item">
                    <img src="Images/Sportsman_on_road_cropped500.jpg" />
                </div>
                <div class="item">
                    <img src="Images/Purple-Bicycle_cropped500.jpg" />
                </div>
                <div class="item">
                    <img src="Images/mountain-bike-ride_cropped500.jpg" alt="..." />
                </div>
            </div>
            <!-- kontrollerna -->
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center sellingText">
                <h1>We believe cycling is fun, and want to help you get there quickly.</h1>
                <p>
                    When you find a small shop, where the owners learn your name, and still get world class service and amazing bikes, then you've found something special.
                </p>
            </div>
        </div>
        <div class="row promotionsMain">
            <div class="col-md-10">
                <asp:Repeater ID="repPopularItems" runat="server">
                    <HeaderTemplate>
                        <div class="row puffRow">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <%#(Container.ItemIndex != 0 && Container.ItemIndex % 3 ==0) ? "</div>":string.Empty  %>
                        <%#(Container.ItemIndex != 0 && Container.ItemIndex % 3 ==0) ? "<div class='row puffRow'>":string.Empty  %>
                        <div class="col-md-4 puff">
                            <a class="prodDescriptionLink" href="Produkter.aspx?<%=WebShopController.QueryKeyProductModelID %>=<%#Eval("ProductModelID") %>">
                                <div id="transition" class="border">


                                    <div id="divToChange" class="prodDescription">
                                        <p><%# Eval("ProductModel") %></p>
                                    </div>
                                    <img src='<%#($"/Media.ashx?image={Eval("LargePhotoFileName")}") %>' />

                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>

            </div>
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
    </div>

    <div class="container-fluid verticalLine parlaxBorderTop">
    </div>

    <div class="parallax-window" data-parallax="scroll" data-image-src="Images/Road_Biker.jpeg">
    </div>

    <div class="container-fluid verticalLine parlaxBorderBottom">
    </div>

    <div class="container">
        <div id="Fillosofi" class="row sellingText">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6 text-center ">
                    <h1>Our philosophy</h1>
                </div>
                <div class="col-md-3 text-right">
                    <%--<a href="#body" class="smoothScroll">Till toppen</a>--%>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <p>
                        From a leaky shed to Helsingborg's best Place for local business, <span class="companyName">Fly</span>Cycle has slowly been pedalling away to help people enjoy bicycles and to make the bicycle a functional, comfortable, versatile and hassle free part of your lifestyle and/or daily routine. We also aim to show Helsingborg how a bicycle can simplify the way we commute, explore more on weekends and most importantly how a bicycle can put a smile on your face.
                    </p>
                    <p>
                        One of our favourite things to do for our customers is what we call the dream bike build. We already spend hours poring over the latest and greatest in bike parts, custom wheels, new frame builders and the powerhouse builders of old - so why not take advantage of that. We are your search engine, and a more reliable place to ask "Will this work?" than any of the forums online, and we take pride in bringing some of our favourite companies and parts to your attention. At the end of the build process you've got a completely unique bicycle to your needs, your style and that will be with you for years to come.
                    </p>
                    <p>
                        We pride ourselves on treating our customers, our community and the environment with the respect they deserve. We source products made by local independent businesses where we can, or international companies which strive for not only quality but sustainability in their manufacturing processes, and who we have built strong relationships with. Read more about the brands we stock and their individual philosophies in the "BRANDS" tab. 
                    </p>
                    <p>
                        RIDE HEAPS! 
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid verticalLine parlaxBorderTop">
    </div>

    <div class="parallax-window" data-parallax="scroll" data-image-src="Images/mountain-bike-downhill.jpg">
    </div>

    <div class="container-fluid verticalLine parlaxBorderBottom">
    </div>

    <div class="container">
        <div id="Villkor" class="row sellingText">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6 text-center ">
                    <h1>Terms</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <p>
                        Our goal is to provide the best value every day. If you find a lower advertised price, we will match it at the time of your purchase, or refund you the difference  for up to 90 days. The comparison item needs to be the same model, year, color, size and currently be in stock. For retail purchases we match to any retailer located within 25 miles of our store. For on-line purchases, we match to any authorized, domestic online or catalog retailer. Show us the advertisement or provide the web address and we’ll gladly refund you the  difference. Performance receipt required.
                    </p>
                    <p>
                        Availability: All products are subject to availability and prior sale. All prices appearing in our catalogs or Web site are subject to change without prior notice. Performance is not responsible for printing errors or other errors appearing in our catalogs or Web site. All orders are subject to acceptance by Performance, inc.
                    </p>
                    <p>
                        Notice: Some suppliers suggest retail prices and/or market their products to consumers at a set retail price. This is commonly referred to as an MSRP.  You may see MSRP prices on our website, in print or in-store.
                    </p>
                    <p>
                        Web site: Prices on our Web site are in effect until they are removed from the page unless otherwise noted. Clearance items have limited quantities, sizes/colors may no longer be available, and these items may not be available in our retail stores.
                    </p>
                    <p>
                        Payment: Our website and catalog prices are in swedish kronor (SEK). You may use American Express, MasterCard, Visa, Discover Card or mail us a money order or personal check drawn on U.S. funds. Here is a link to Olsen & Associates Currency Conversion service: http://www.oanda.com/currency/converter/.
                    </p>
                    <p>
                        Promotions: Discounts are applied to the lowest-priced item.
                    </p>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <a href="#body" class="smoothScroll">Back to the top</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
