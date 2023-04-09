var express = require('express');
const Category = require('../models/category')
var Product = require('../models/product');
var app = express();
var multer = require('multer');

var storage = multer.diskStorage({
    destination: (req, file, res) => {
        res(null, './upload/upload')
    },
    filename: (req, file, res) => {
        res(null, file.originalname)
    }
});
var upload = multer({ storage: storage, limits: { fieldSize: 4000 } });


app.get("/detail_product/:id", async function (req, res) {
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
            console.log(products);
            return res.render("detail_product", { itemProduct: products })
            // res.end();
        })
    } catch (error) {
        return res.send(error)
    }

})
app.get("/admin", async function (req, res) {
    await Product.find().then(data => {
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
        // console.log(products.itemProduct)
        Category.find().then(data => {
            const categorys = {
                itemCategory: data.map((item) => {
                    return {
                        _id: item.id,
                        name_category: item.name_category,
                    }
                })
            }

            res.render('admin', {
                itemProduct: products.itemProduct,
                itemCategory: categorys.itemCategory
            })
        })
    })
})



app.get('/edit_product/:id', async (req, res) => {
    // console.log(req.params.id);
    try {
        await Product.findOne({ _id: req.params.id }).then((item) => {
            const products = {
                _id: item.id,
                name: item.name,
                category: item.category,
                price: item.price,
                image: item.image,
                description: item.description,
            }
            Category.find().then(data => {
                const categorys = {
                    itemCategory: data.map((item) => {
                        return {
                            _id: item.id,
                            name_category: item.name_category,
                        }
                    })
                }
                console.log("EDIT: ", categorys.itemCategory);
                res.render('edit', { itemProduct: products, itemCategory: categorys.itemCategory })
            })
        })
    } catch (error) {
        return res.send(error)
    }
})

app.post('/add_product', upload.array('image', 5), async (req, res) => {
    let arrImage = [];
    await req.files.forEach((item) => {
        arrImage.push(item.filename)

    })
    console.log(arrImage);

    const product = {
        name: req.body.name,
        category: req.body.select,
        price: req.body.price,
        image: arrImage,
        description: req.body.description,
    }
    console.log(product);
    //Up data database
    await Product.insertMany([product])

    await Product.find().then(data => {
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
        // console.log(products.itemProduct)
        return res.render('admin', { itemProduct: products.itemProduct })
    })
})


app.post('/edit/:id', upload.array('image', 5), async (req, res) => {
    console.log("ID: ", req.params.id);
    const item = await Product.findOne({ _id: req.params.id })
    let arrImage = [];


    if (req.files != null) {
        await req.files.forEach((item) => {
            arrImage.push(item.filename)
        })
        console.log(arrImage);
        if (arrImage.length > 0) {
            req.body.image = arrImage
        }
    } else {
        req.body.image = item.image;
    }
    console.log(req.body);
    await Product.findByIdAndUpdate(req.params.id, req.body).then((error, data) => {
        // console.log(data);
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
            return res.render('admin', { itemProduct: products.itemProduct })
        })
    })
})

let id;
app.get('/delete_product/:id', async (req, res) => {
    id = req.params.id
    console.log(id);
    // res.end();
})

app.post('/delete2', async (req, res) => {
    await Product.findByIdAndDelete(id).then((error) => {
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
            return res.render('admin', { itemProduct: products.itemProduct })
        })
    })
})

module.exports = app;