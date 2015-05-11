var confirmOnPageExit = function (e)
{
    // If we haven't been passed the event get the window.event
    e = e || window.event;

    var message = 'Sei sicuro di voler lasciare la pagina senza salvare?';

    // For IE6-8 and Firefox prior to version 4
    if (e)
    {
        e.returnValue = message;
    }

    // For Chrome, Safari, IE8+ and Opera 12+
    return message;
};

function save_warning() {
    window.onbeforeunload = confirmOnPageExit;
}

function disable_save_warning() {
    window.onbeforeunload = null;
}