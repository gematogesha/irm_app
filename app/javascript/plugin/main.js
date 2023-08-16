document.addEventListener("turbo:load", () => {

    console.log('plugin/main load');

    $(function () {
        $('.theme__title').click(function () {
            if ($(this).is('.active')) {
                $('.document__list').slideUp();
                $(this).children('i').toggleClass('fa-chevron-up fa-chevron-down');
                $(this).removeClass('active')
            } else {
                $(this).next('.document__list').slideToggle();
                $(this).children('i').toggleClass('fa-chevron-down fa-chevron-up');
                $(this).addClass('active')
            }

        });
    });

    $(function () {
        $('.button__menu').click(function () {
            if ($(this).is('.active')) {
                $('.nav-small').animate({ right: '-350' }, 350);
                $('.button__menu').removeClass('active')
            } else {
                $('.nav-small').animate({ right: '0' }, 350);
                $('.button__menu').addClass('active')
            }

        });
    });

    console.log("turbo loaded");

    document.cookie = "width=" + $(window).width();


});