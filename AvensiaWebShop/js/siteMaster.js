$(document).ready(function () {
    pullDownElement();
});

function pullDownElement() {
    $('.pullDown').each(function () {
        var $element = $(this);
        $element.show();
        $element.css('margin-top', $element.parent().height() - $element.height());
    });
}

$(function () {
    $('.smoothScroll').click(function () {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: target.offset().top
                }, 800);
                return false;
            }
        }
    });
});

