//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require underscore
//= require ./menu

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

function ajax_call(url, method, data) {
    $.ajax({
        method: method,
        url: url,
        dataType: "script",
        data: data
    });
}

function ajax_safe(url, method, data) {
    if (window.onbeforeunload != null) {
        if (confirm("Sei sicuro di voler lasciare la pagina senza salvare?")) {
            ajax_call(url, method, data);
            disable_save_warning();
        }
    } else {
        ajax_call(url, method, data);
    }
}

// ----------
// INSPECTOR
// ----------
var _zum_inspector_selected_tab = null;