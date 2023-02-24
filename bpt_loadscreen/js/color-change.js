function updateColors()
{
    // color background
    document.documentElement.style.setProperty("--header-color", config.BASE.color.background);


    // color servername
    const servername = Object.values(config.BASE.color.servername);

    document.documentElement.style.setProperty("--text-color", servername[0]);
    document.documentElement.style.setProperty("--dud-color", servername[1])


    // cursor
    document.documentElement.style.setProperty("--cursor-dot", config.BASE.color.cursor_dot);
    document.documentElement.style.setProperty("--cursor-ring", config.BASE.color.cursor_ring);


    // color logs
    document.documentElement.style.setProperty("--log-color", config.BASE.color.logs);


    // color music text
    document.documentElement.style.setProperty("--music-color", config.BASE.color.music_text);


    // color music icons
    document.documentElement.style.setProperty("--music-icons", config.BASE.color.music_icons);


    // color nav
    const nav_background = Object.values(config.BASE.color.nav_background);
    const nav_text = Object.values(config.BASE.color.nav_text);

    document.documentElement.style.setProperty("--nav-icon", config.BASE.color.music_icons);
    document.documentElement.style.setProperty("--nav-background", nav_background[0]);
    document.documentElement.style.setProperty("--nav-background-back", nav_background[1]);
    document.documentElement.style.setProperty("--nav-underline", config.BASE.color.nav_underline);
    document.documentElement.style.setProperty("--nav-text", nav_text[0]);
    document.documentElement.style.setProperty("--nav-text-highlight", nav_text[1]);


    // color loadingbar
    const loadingbar_background = Object.values(config.BASE.color.loadingbar_background);

    document.documentElement.style.setProperty("--bg-first", loadingbar_background[0]);
    document.documentElement.style.setProperty("--bg-second", loadingbar_background[1]);
    document.documentElement.style.setProperty("--bg-third", loadingbar_background[2]);
    document.documentElement.style.setProperty("--bg-fourth", loadingbar_background[3]);

    const loadingbar_text = Object.values(config.BASE.color.loadingbar_text);

    document.documentElement.style.setProperty("--text-first", loadingbar_text[0]);
    document.documentElement.style.setProperty("--text-second", loadingbar_text[1]);
    document.documentElement.style.setProperty("--text-third", loadingbar_text[2]);
    document.documentElement.style.setProperty("--text-fourth", loadingbar_text[3]);


    // color waves
    const waves_color = Object.values(config.BASE.color.waves);

    document.documentElement.style.setProperty("--waves-first", waves_color[0]);
    document.documentElement.style.setProperty("--waves-second", waves_color[1]);
    document.documentElement.style.setProperty("--waves-third", waves_color[2]);
    document.documentElement.style.setProperty("--waves-fourth", waves_color[3]);
}

updateColors();