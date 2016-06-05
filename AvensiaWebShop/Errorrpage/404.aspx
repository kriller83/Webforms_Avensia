<%@  Language="C#" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="AvensiaWebShop.Errorrpage._404" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error Norris</title>
    <script src="/Scripts/jquery-1.9.1.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    
    <link href="/css/site.css" rel="stylesheet" />
    <script src="/js/siteMaster.js"></script>
    <link href="/css/siteMaster.css" rel="stylesheet" />
    <link href="/css/404.css" rel="stylesheet" />
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
                              404
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
                <div class="col-md-4">
                    <img src="chuckEdit.jpg" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <p class="errorText">Press this button to return to the Startpage.</p>
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
