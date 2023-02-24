var player;

var lib = 
{
    rand: function(min, max)
    {
        return min + Math.floor(Math.random()*max);
    },

    fadeInOut: function(duration, elementId, min, max)
    {
        var halfDuration = duration / 2;

        setTimeout(function()  
        {
            var element = document.getElementById(elementId);
            element.style.opacity = min;

            setTimeout(function()  
            {
                element.style.opacity = max;

            }, halfDuration);  

        }, halfDuration);
    },
}

if(config.MUSIC.enable)
{
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";

    var ytScript = document.getElementsByTagName('script')[0];
    ytScript.parentNode.insertBefore(tag, ytScript);

    var musicIndex = lib.rand(0, config.MUSIC.music.length);
    var title = "n.a.";
}

function onYouTubeIframeAPIReady() 
{
    var videoId = config.MUSIC.music[musicIndex];

    player = new YT.Player('player', {
        width: '1',
        height: '',
        playerVars: {
            'autoplay': 0,
            'controls': 0,
            'disablekb': 1,
            'enablejsapi': 1,
        },
        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange,
            'onError': onPlayerError 
        }
    });
}

function onPlayerReady(event) 
{
    title = event.target.getVideoData().title;
    player.setVolume(config.MUSIC.Volume);
}

function onPlayerStateChange(event) 
{
    if(event.data == YT.PlayerState.PLAYING)
    {
        title = event.target.getVideoData().title;
    }

    if (event.data == YT.PlayerState.ENDED) 
    {
        musicIndex++;
        play();
    }
}

function onPlayerError(event)
{
    var videoId = config.MUSIC.music[musicIndex];

    switch (event.data) 
    {
        case 2:
            console.log("Invalid video url!");
            break;
        case 5:
            console.log("HTML 5 player error!");
        case 100:
            console.log("Video not found!");
        case 101:
        case 150:
            console.log("Video embedding not allowed. [" + videoId + "]" );
            break;
        default:
            console.log("Looks like you got an error bud.")
    }

    skip();
}

function skip()
{
    musicIndex++;
    play();
}

function play() 
{
    title = "n.a.";

    var idx = musicIndex % config.MUSIC.music.length;
    var videoId = config.MUSIC.music[idx];

    player.loadVideoById(videoId, 0, "tiny");
    player.playVideo();
}

function resume()
{
    player.playVideo();
}

function pause() 
{
    player.pauseVideo();
}

function stop() 
{
    player.stopVideo();
}

function setVolume(volume)
{
    player.setVolume(volume)
}