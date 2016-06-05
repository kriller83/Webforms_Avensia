<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeneralError.aspx.cs" Inherits="AvensiaWebShop.Errorrpage.GeneralError" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>General Error Norris</title>
    <script src="/Scripts/jquery-1.9.1.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />

    <link href="/css/site.css" rel="stylesheet" />
    <script src="/js/siteMaster.js"></script>
    <link href="/css/siteMaster.css" rel="stylesheet" />
    <link href="/css/404.css" rel="stylesheet" />
    <link href="/css/generalError.css" rel="stylesheet" />
</head>
<body>
    <header class="container">
        <div class="row">
            <div class="col-md-3">
                <a href="../Hem.aspx">
                    <img id="logga" class="center-block" src="../Images/loggo_croped.png" />
                </a>
            </div>
            <div class="col-md-6 text-center">
                <div class="row">
                    <div class="col-md-12">
                        <div class="loggatext">
                            <a class="maintitle" href="../Hem.aspx"><span>Fly</span>Cycle
                              Error
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <br />
    <br />
    <form id="form404" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-push-4">
                    <div class="errorImage">
                        <img src="http://www.chanstickers.com/sites/default/files/2523917961_ab53ecfed0.jpg" />
                    </div>
                </div>
            </div>
                <div class="row">
                    <div class="col-md-8 col-md-push-2 text-center">
                        <p class="errorText">
                            Something went wrong. Please give us a call so we can help you get the bike you deserve.                       
                        </p>
                        <p>
                            To help us improve the site. Go to the <a href="/Kontakt.aspx">contact page</a> and write us a line explaning what you tryed to do and past this string in the form [<%=DateTime.Now.ToString("O") %>].
                        </p>
                        <div>
                            <asp:Literal ID="ltErrorText" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <p id="errorText">Press this button to return to the Startpage.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2 col-md-push-5 text-center">
                    <div class="btn-group btn-group-justified" role="group" aria-label="...">
                        <div class="btn-group" role="group">
                            <a class="btn btn-default" href="../Hem.aspx">Return to Startpage</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <footer class="container">
        <div class="row">
            <div class="col-md-3">
            </div>
            <div class="col-md-6">
                <div class="row text-center">
                    <div class="col-md-12">
                        <span class="companyName">Fly</span>Cycle | Sveavägen 18, 215 67 Helsingborg | 044 - 89 48 57
                    </div>
                    <div class="col-md-12">
                        Copyright 2016 <span class="companyName">Fly</span>Cycle. All rights reserved.
                    </div>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>
