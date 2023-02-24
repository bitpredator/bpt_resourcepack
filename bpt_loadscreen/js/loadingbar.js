if (!String.format) {
  String.format = function(format) {
    var args = Array.prototype.slice.call(arguments, 1);
    return format.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number] 
        : match
      ;
    });
  };
}

const loadingStages = ["Pre-map", "Map", "Post-map", "Session"];
const technicalNames = ["INIT_BEFORE_MAP_LOADED", "MAP", "INIT_AFTER_MAP_LOADED", "INIT_SESSION"];
var currentLoadingStage = 0;
var loadingWeights = [1.5/10, 4/10, 1.5/10, 3/10];

var loadingTotals = [70, 70, 70, 220];
var registeredTotals = [0, 0, 0, 0];
var stageVisible = [false, false, false, false];

var currentProgress = [0.0, 0.0, 0.0, 0.0];
var currentProgressSum = 0.0;
var currentLoadingCount = 0;

var minScale = 1.03
var maxScale = 1.20
var diffScale = maxScale - minScale
var backgroundPositionEnd = [0,0];

function doProgress(stage)
{
  var idx = technicalNames.indexOf(stage);
    if(idx >= 0)
    {
        registeredTotals[idx]++;
        if(idx > currentLoadingStage)
        {
            while(currentLoadingStage < idx)
            {
                currentProgress[currentLoadingStage] = 1.0;
                currentLoadingStage++;
            }
            currentLoadingCount = 1;
        }
        else
            currentLoadingCount++;
        currentProgress[currentLoadingStage] = Math.min(currentLoadingCount/loadingTotals[idx], 1.0);
        updateProgress();
    }
}

const totalWidth = 99.1;
var progressPositions = [];
var progressMaxLengths = [];
progressPositions[0] = 0.0;

var i = 0;
while(i < currentProgress.length)
{
    progressMaxLengths[i] = loadingWeights[i] * totalWidth;
    progressPositions[i+1] = progressPositions[i] + progressMaxLengths[i];
    i++;
}


function updateProgress()
{
    document.querySelector('#debug').innerHTML = '';
    var i = 0;
    while(i <= currentLoadingStage)
    {
        if((currentProgress[i] > 0 || !currentProgress[i-1]) && !stageVisible[i])
        {
            document.querySelector("#" + technicalNames[i]+"-label").style.display = 'inline-block';

            document.querySelector("#" + technicalNames[i]+"-bar").style.display = 'inline-block';
            stageVisible[i] = true;
        }
        document.querySelector("#" + technicalNames[i]+"-bar").style.width = currentProgress[i]*progressMaxLengths[i] + '%';
        document.querySelector("#" + technicalNames[i]+"-label").style.width = progressMaxLengths[i] + '%';
        if(config.LOG.enable)
        {
            document.querySelector('#debug').innerHTML += String.format('{0}: {1}<br />', technicalNames[i], currentProgress[i]);
        }
        i++;
    }
}

updateProgress();


var count = 0;
var thisCount = 0;

const gstate = {
    elems: [],
    log: []
};

const emoji = {
    INIT_BEFORE_MAP_LOADED: [ '🍉' ],
    INIT_AFTER_MAP_LOADED: [ '🍋', '🍊' ],
    INIT_SESSION: [ '🍐', '🍅', '🍆' ],
};

function printLog(type, str){
    gstate.log.push({ type: type, str: str });
};

Array.prototype.last = function()
{
    return this[this.length - 1];
};

const handlers = {
    startInitFunction(data)
    {
        printLog(1, String.format('Running {0} init functions', data.type));
        if(data.type) doProgress(data.type);
    },

    startInitFunctionOrder(data)
    {
        count = data.count;

        printLog(1, String.format('[{0}] Running functions of order {1} ({2} total)', data.type, data.order, data.count));
        if(data.type) doProgress(data.type);
    },

    initFunctionInvoking(data)
    {
        printLog(3, String.format('Invoking {0} {1} init ({2} of {3})', data.name, data.type, data.idx, count));
        if(data.type) doProgress(data.type);
    },

    initFunctionInvoked(data)
    {
        if(data.type) doProgress(data.type);
    },

    endInitFunction(data)
    {
        printLog(1, String.format('Done running {0} init functions', data.type));
        if(data.type) doProgress(data.type);
    },

    startDataFileEntries(data)
    {
        count = data.count;

        printLog(1, 'Loading map');
        if(data.type) doProgress(data.type);
    },

    onDataFileEntry(data)
    {
        printLog(3, String.format('Loading {0}', data.name));
        doProgress(data.type);
        if(data.type) doProgress(data.type);
    },

    endDataFileEntries()
    {
        printLog(1, 'Done loading map');
    },

    performMapLoadFunction(data)
    {
        doProgress('MAP');
    },

    onLogLine(data)
    {
        printLog(3, data.message);
    }
};

setInterval(function(){
    if(config.LOG.enable)
    {
        document.querySelector('#log').innerHTML = gstate.log.slice(-10).map(
            function(e){
                return String.format("[{0}] {1}", e.type, e.str)
            }
        ).join('<br />');
    }
}, 100);

if (!window.invokeNative)
{
    const newType = name => () => handlers.startInitFunction({type: name});

    const newOrder = (name, idx, count) => () => handlers.startInitFunctionOrder({type: name, order: idx, count });

    const newInvoke = (name, func, i) => () => { handlers.initFunctionInvoking({ type: name, name: func, idx: i }); handlers.initFunctionInvoked({ type: name }); };

    const startEntries = (count) => () => handlers.startDataFileEntries({ count });

    const addEntry = () => () => handlers.onDataFileEntry({ name: 'meow', isNew: true });

    const stopEntries = () => () => handlers.endDataFileEntries({});

    const newTypeWithOrder = (name, count) => () => { newType(name)(); newOrder(name, 1, count)(); };

    const meowList = [];
    for (let i = 0; i < 50; i++) {
        meowList.push(newInvoke('INIT_SESSION', `meow${i+1}`, i+1));
    }

    const demoFuncs = [
        newTypeWithOrder('MAP', 5),
        newInvoke('MAP', 'meow1', 1),
        newInvoke('MAP', 'meow2', 2),
        newInvoke('MAP', 'meow3', 3),
        newInvoke('MAP', 'meow4', 4),
        newInvoke('MAP', 'meow5', 5),
        newOrder('MAP', 2, 2),
        newInvoke('MAP', 'meow1', 1),
        newInvoke('MAP', 'meow2', 2),
        startEntries(6),
        addEntry(),
        addEntry(),
        addEntry(),
        addEntry(),
        addEntry(),
        addEntry(),
        stopEntries(),
        newTypeWithOrder('INIT_SESSION', 50),
        ...meowList,
    ];

    setInterval(() =>
    {
        demoFuncs.length && demoFuncs.shift()();
    }, 120);
}