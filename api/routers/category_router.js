var express = require('express');
const Category = require('../models/category')
var Product = require('../models/product');
var app = express();


app.get("/category_screen", function (req, res) {
    Category.find().then(data => {
        const categorys = {
            itemCategory: data.map((item) => {
                return {
                    _id: item.id,
                    name_category: item.name_category,
                }
            })
        }
        // console.log(categorys);
        return res.render("category_screen", { itemCategory: categorys.itemCategory })
    })

})
app.post("/add_category", async function (req, res) {
    const category = {
        name_category: req.body.name_category
    }
    console.log(category);
    await Category.insertMany([category]);
    Category.find().then(data => {
        const categorys = {
            itemCategory: data.map((item) => {
                return {
                    _id: item.id,
                    name_category: item.name_category,
                }
            })
        }
        console.log(categorys);
        return res.render("category_screen", { itemCategory: categorys.itemCategory })
    })
})

app.get('/edit_category/:id', async (req, res) => {
    // console.log(req.params.id);
    try {
        await Category.findOne({ _id: req.params.id }).then((item) => {
            const categorys = {
                _id: item.id,
                name: item.name_category,
            }
            // console.log(categorys);
            return res.render('edit_category', { itemCategory: categorys })
        })
    } catch (error) {
        return res.send(error)
    }
})
app.post('/edit_item_category/:id', async (req, res) => {
    console.log(req.params.id);
    console.log(req.body);
    try {
        await Category.findByIdAndUpdate(req.params.id, req.body).then((error, data) => {
            Category.find().then(data => {
                const categorys = {
                    itemCategory: data.map((item) => {
                        return {
                            _id: item.id,
                            name_category: item.name_category,
                        }
                    })
                }
                // console.log(categorys);
                return res.render("category_screen", { itemCategory: categorys.itemCategory })

            })
        })

    } catch (error) {
        return res.send(error)
    }
})
app.post('/delete_category/:id', async (req, res) => {
    // console.log(req.params.id);
    try {
        await Category.findByIdAndDelete(req.params.id).then((error) => {
            Category.find().then(data => {
                const categorys = {
                    itemCategory: data.map((item) => {
                        return {
                            _id: item.id,
                            name_category: item.name_category,
                        }
                    })
                }
                return res.render("category_screen", { itemCategory: categorys.itemCategory })
            })
        })

    } catch (error) {
        return res.send(error)
    }
})

module.exports = app;