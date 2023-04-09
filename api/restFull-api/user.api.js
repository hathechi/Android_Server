var express = require('express');
const User = require('../models/user');
var app = express();


//get one -- login
app.post("/signin", async function (req, res) {
    try {
        const check = await User.findOne({ email: req.body.email_login })
        if (check == null) {
            res.json({ check, status: false, message: 'email wrong' });
        } else {
            if (check.pass === req.body.password_login) {
                res.json({ check, status: true, message: 'login success' });
            } else {
                res.json({ check, status: false, message: 'password wrong' })
            }
        }

    } catch (error) {
        res.json({ status: false, message: 'something wrong' })
    }
})

//Dang ky moi tai khoan
app.post("/signup", async (req, res) => {
    try {
        const check = await User.findOne({ email: req.body.email })
        // console.log(check);
        if (check == null) {
            const data = {
                username: req.body.username,
                pass: req.body.pass,
                role: req.body.role,
                email: req.body.email,
            }
            console.log(data);
            res.json({ status: true, message: 'register success' });
            await User.insertMany([data])
        } else {
            res.json({ status: false, message: 'Email already used' });
        }
    } catch (error) {
        res.json({ status: false, message: error });
    }
})
// get Theo khoảng ngày để thống kê
app.post("/statis", async (req, res) => {
    try {
        await User.find({ date: { $gte: req.body.thanOrEqual, $lte: req.body.lessOrEqual } }).then(data => {

            res.json(data)
        })

    } catch (error) {
        return res.send(error)
    }
})
// --------------------setRole ----------------
app.get('/role', async (req, res) => {
    await User.find({}).then((user) => {
        return res.json(user);
    })
})
app.put('/setRole/:id', async (req, res) => {
    console.log(req.body);
    await User.findByIdAndUpdate(req.params.id, req.body);
    User.find({ _id: req.params.id }).then((item) => {
        res.json(item);
    });
})
app.delete('/deleteUser/:id', async (req, res) => {
    console.log(req.body);
    await User.findByIdAndDelete(req.params.id);
    User.find().then((item) => {
        res.json(item);
    });
})


module.exports = app;

 // port: 3000/api/product

/*
restful:
get : /api/product
get one : /api/product/{id}
post : /api/product
put : /api/product/{id}
delete : /api/product/{id}
 


*/