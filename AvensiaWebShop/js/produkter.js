$(document).ready(function () {
    $(".txtArticleAmount").attr("disabled", "disabled");

    $("#btnArticlePlusAmount").click(function () {
        var $textbox = $(".txtArticleAmount");
        var boxValue = parseInt($textbox.val());

        $textbox.val(boxValue + 1);
        $(".txtArticleAmount").attr("value", boxValue + 1);
    });

    $("#btnArticleMinusAmount").click(function () {
        var $textbox = $(".txtArticleAmount");
        var boxValue = parseInt($textbox.val());

        if (boxValue > 1) {
            $textbox.val(boxValue - 1);
            $(".txtArticleAmount").attr("value", boxValue - 1);
        }
    });

    $(".btnAddToCart").click(function() {
        $(".txtArticleAmount").removeAttr("disabled");
    });
});

