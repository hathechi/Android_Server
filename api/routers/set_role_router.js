var express = require('express');
const User = require('../models/user');
var app = express();



app.get("/role", function (req, res) {
    res.render("set_role_screen")
})


module.exports = app;