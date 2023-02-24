(function($) { "use strict";

    $(window).mousemove(function(e) {     
        $(".cursor1").css({
            left: e.pageX,
            top: e.pageY
        })    
    })

    document.getElementsByTagName("body")[0].addEventListener("mousemove", function(n) {
        t.style.left = n.clientX + "px", 
        t.style.top = n.clientY + "px", 
        e.style.left = n.clientX + "px", 
        e.style.top = n.clientY + "px", 
        i.style.left = n.clientX + "px", 
        i.style.top = n.clientY + "px"
    });
    var t = document.getElementById("cursor"),
        e = document.getElementById("cursor2"),
        i = document.getElementById("cursor3");
    function n(t) {
        e.classList.add("hover"), i.classList.add("hover")
    }
    function s(t) {
        e.classList.remove("hover"), i.classList.remove("hover")
    }
    s();
    for (var r = document.querySelectorAll(".hover-target"), a = r.length - 1; a >= 0; a--) {
        o(r[a])
    }
    function o(t) {
        t.addEventListener("mouseover", n), t.addEventListener("mouseout", s)
    }
    

    function navlist()
    {
        if (config.NAV.enable)
        {
            const el = document.querySelector('.nav__list');

            let output = '';

            for (let i = 0; i < Object.keys(config.NAV.list).length; i++)
            {
                output += `<li class="nav__list-item"><a class="hover-target" href="#" onclick="window.invokeNative('openUrl', '${Object.values(config.NAV.list)[i][1]}')">${Object.values(config.NAV.list)[i][0]}</a></li>`;
            }

            el.innerHTML = output;
        }
        else
        {
            const nav = document.querySelector('.nav-but-wrap');

            nav.style.display = "none";
        }

    }


    var app = function () {
        var body = undefined;
        var menu = undefined;
        var menuItems = undefined;
        var init = function init() {
            body = document.querySelector('body');
            menu = document.querySelector('.menu-icon');
            menuItems = document.querySelectorAll('.nav__list-item');
            applyListeners();
            navlist();
        };
        var applyListeners = function applyListeners() {
            menu.addEventListener('click', function () {
                return toggleClass(body, 'nav-active');
            });
        };
        var toggleClass = function toggleClass(element, stringClass) {
            if (element.classList.contains(stringClass)) element.classList.remove(stringClass);else element.classList.add(stringClass);
        };
        init();
    }();

    
    $("#switch").on('click', function () {
        if ($("body").hasClass("light")) {
            $("body").removeClass("light");
            $("#switch").removeClass("switched");
        }
        else {
            $("body").addClass("light");
            $("#switch").addClass("switched");
        }
    });      
              
})(jQuery);