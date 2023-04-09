var express = require('express');
var app = express();



app.get("/statis", function (req, res) {
    res.render("statis_screen")
})


module.exports = app;