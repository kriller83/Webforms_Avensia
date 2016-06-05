<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Artikel.aspx.cs" Inherits="AvensiaWebShop.Artikel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="css/artikel.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="ProductInfoContent" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <div class="row productInfo">
        <div class="col-md-7 text-center">
                <h1 class="center-block">Apollo barn cyckel</h1>
            <div>
                <asp:Image ID="Image1" runat="server" src="Images/products/Barn_Bla.png.jpg" CssClass="productImage" />
            </div>
        </div>
        <div class="col-md-5">
            <h2>3500 kr</h2>
            <p>
                Passar barn mellan sex och åtta år. Rekommenderad längd: 115-125 cm. Finns i två olika färgvarianter. Har både fot- och handbroms samt 3 växlar.
            </p>
            <h3>Färg</h3>
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Röd</asp:ListItem>
                <asp:ListItem>Blå</asp:ListItem>
                <asp:ListItem>Svart</asp:ListItem>
            </asp:DropDownList><br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="-" Enabled="False"/>
            <asp:TextBox ID="TextBox1" runat="server" Text="1"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" Text="+" Enabled="False"/><br />
            <br />
            <asp:Button ID="Button3" runat="server" Text="Köp" />
        </div>
    </div>
</asp:Content>
