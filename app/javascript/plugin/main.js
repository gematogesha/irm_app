document.addEventListener("turbo:load", () => {

    console.log('plugin/main load');

    $(function () { // Dropdown toggle
        $('.theme__title').click(function () {
            $(this).next('.document__list').slideToggle();
            $(this).children('i').toggleClass('fa-chevron-down fa-chevron-up');
        });

        $(document).click(function (e) {
            var target = e.target;
            if (!$(target).is('.theme__title') && !$(target).parents().is('.theme__title'))
            //{ $('.dropdown').hide(); }
            { $('.document__list').slideUp(); }
            $(this).children('i').toggleClass('fa-chevron-up fa-chevron-down');
        });


        $('.button__menu').click(function () {
            $('.nav-small').slideToggle();
            $(this).children('i').toggleClass('fa-bars fa-xmark');
        });

        $(document).click(function (e) {
            var target = e.target;
            if (!$(target).is('.button__menu') && !$(target).parents().is('.button__menu'))
            //{ $('.dropdown').hide(); }
            { $('.nav-small').slideUp(); }
            $(this).children('i').toggleClass('fa-xmark fa-bars');
        });

    });

    console.log("turbo loaded");
});