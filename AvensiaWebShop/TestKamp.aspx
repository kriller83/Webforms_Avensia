<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="KampanjerTest.aspx.cs" Inherits="AvensiaWebShop.KampanjerTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderCarousell" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">
        <div class="col-md-2">
            <div class="row">
                <div class="col-md-12">
                    <asp:HyperLink ID="Campaign_1" runat="server"></asp:HyperLink>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <asp:HyperLink ID="Campaign_2" runat="server"></asp:HyperLink>
                </div>
            </div>

        </div>
    </div>
    <asp:Repeater ID="repCampaign" runat="server" ItemType="AvensiaWebShop.Models.Kampanj">
        <HeaderTemplate></HeaderTemplate>
        <ItemTemplate>
            <div class="row">
                <div class="col-md-12">
                    <asp:HyperLink ID="HyperLink1" runat="server" ImageUrl="Images/Annonser/<%#Item.KampanjImageName%>" NavigateUrl="<%#Item.KampanjURL%>">HyperLink</asp:HyperLink>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate></FooterTemplate>
    </asp:Repeater>

</asp:Content>
