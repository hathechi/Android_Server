var express = require('express');
const Category = require('../models/category')
var Product = require('../models/product');
var app = express();


// get all
app.get("/", (req, res) => {
    Product.find().then(data => {
        const products = {
            itemProduct: data.map((item) => {
                return {
                    _id: item.id,
                    name: item.name,
                    category: item.category,
                    price: item.price,
                    image: item.image,
                    description: item.description,
                }
            })
        }
        res.json(products.itemProduct)
    })
        .catch(error => console.error(error));
})

// get one
app.get("/:id", async (req, res) => {
    try {
        console.log((req.params.id));
        await Product.findOne({ _id: req.params.id }).then((item) => {
            const products = {
                _id: item.id,
                name: item.name,
                category: item.category,
                price: item.price,
                image: item.image,
                description: item.description,
            }
            return res.json(products)
        })
    } catch (error) {
        return res.send(error)
    }
})

//lấy theo category ;
app.get("/category/:category", async (req, res) => {
    try {
        console.log((req.params.category));
        await Product.find({ category: req.params.category }).then((item) => {

            return res.json(item)
        })
    } catch (error) {
        return res.send(error)
    }
})
// update
app.put("editProduct/:id", async (req, res) => {
    await Product.findByIdAndUpdate(req.params.id, req.body).then((error, data) => {
        console.log(data);
        Product.findById(req.params.id).then(data => {
            return res.json(data)
        })
    })
})
// post
app.post("/", async (req, res) => {

    const product = {
        name: req.body.name,
        category: req.body.select,
        price: req.body.price,
        image: req.body.image,
        description: req.body.description,
    }
    console.log(product);
    //Up data database
    await Product.insertMany([product]).then((data) => {
        res.json(data)
    })

    // await Product.find().then(data => {
    //     const products = {
    //         itemProduct: data.map((item) => {
    //             return {
    //                 _id: item.id,
    //                 name: item.name,
    //                 category: item.category,
    //                 price: item.price,
    //                 image: item.image,
    //                 description: item.description,
    //             }
    //         })
    //     }
    //     // console.log(products.itemProduct)
    //     return res.json(products.itemProduct)
    // })
})


// delete
app.delete("/:id", async (req, res) => {
    await Product.findByIdAndDelete(req.params.id)
    res.status(202).json({ message: "deleted" })
})
module.exports = app;
