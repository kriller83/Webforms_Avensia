
$(document).ready(function () {

    $(window).scroll(function () {
        if ($(this).scrollTop() > 1200) {
            $('.scrollup').fadeIn();
        } else {
            $('.scrollup').fadeOut();
        }
    });

    $('.scrollup').click(function () {
        $("html, body").animate({
            scrollTop: 0
        }, 800);
        return false;
    });
});