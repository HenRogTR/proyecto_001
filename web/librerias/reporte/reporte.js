/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {

});

$(function() {
    var tabs = $('#tabs').tabs();
    tabs.find('.ui-tabs-nav').sortable({
        axis: 'x',
        stop: function() {
            tabs.tabs('refresh');
        }
    });
});

function fPaginaActual() {
}
;