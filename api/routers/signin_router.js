var express = require('express');
const User = require('../models/user');
var app = express();



app.get("/login", function (req, res) {
    res.render("login")
})


app.post("/signup", async (req, res) => {

    try {
        const check = await User.findOne({ email: req.body.email })
        // console.log(check);
        if (check == null) {
            if (req.body.password != req.body.cfpassword) {
                res.send('2 passwords do not match')
                return;
            }
            var time = new Date();
            const data = {
                username: req.body.username,
                pass: req.body.password,
                role: 'user',
                email: req.body.email,
                date: time.getTime(),
            }

            await User.insertMany([data])
            res.render('login')

        } else {
            // res.send('Email already used')
            res.json({ status: false, error: 'Email already used' });
        }
    } catch (error) {
        // res.send(error)
        res.json({ status: false, error: error });
    }
})
app.post("/signin", async (req, res) => {
    try {
        const check = await User.findOne({ email: req.body.email_login })
        if (check != null) {
            if (check.pass === req.body.password_login) {
                console.log(check.role)
                var roleAdmin = '';
                if (check.role == 'admin') {
                    roleAdmin = 'ADMINISTRATOR'

                } else {
                    roleAdmin = '';
                }

                res.render('home', { role: roleAdmin })
            } else {
                res.send('wrong password')
            }
        } else {
            res.send('Email wrong!!!!');
        }

    } catch (error) {
        res.send('wrong detail')
    }
})



module.exports = app;