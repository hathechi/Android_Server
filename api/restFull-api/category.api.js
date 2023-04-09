var express = require('express');
const Category = require('../models/category')
var app = express();

app.get("/", async function (req, res) {
    await Category.find().then(category => {
        return res.json(category)
    })

})


app.post("/add_category", async function (req, res) {
    const category = {
        name_category: req.body.name_category
    }
    console.log(category);
    await Category.insertMany([category]);
    Category.find().then(data => {
        return res.statusCode(200).json(data)
    })
})
app.put('/edit_item_category/:id', async (req, res) => {

    try {
        await Category.findByIdAndUpdate(req.params.id, req.body);
        Category.find({ _id: req.params.id }).then((item) => {
            return res.json(item);
        })
    } catch (error) {
        return res.send(error)
    }
})
app.post('/delete_category/:id', async (req, res) => {
    try {
        await Category.findByIdAndDelete(req.params.id);
        Category.find().then((data) => {
            res.json(data);
        })

    } catch (error) {
        return res.send(error)
    }
})
module.exports = app;