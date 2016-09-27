require('./main.css');
Chart = require('chartjs')
var Elm = require('./Main.elm');


var app = Elm.Main.fullscreen();

app.ports.chartdata.subscribe(function () {

});
