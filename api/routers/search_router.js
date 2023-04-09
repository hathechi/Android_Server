var express = require('express');

var Product = require('../models/product');
var app = express();


app.post("/search", async function (req, res) {
    try {
        console.log(req.body.inputSearch);
        await Product.find({ name: { $regex: req.body.inputSearch, $options: 'i' } }).then((item) => {
            const products = item.map((item) => item.toJSON());
            console.log(products);
            return res.render("home", { itemProduct: products })
            // return res.json(products);
        })
    } catch (error) {
        return res.send(error)
    }

})




module.exports = app;