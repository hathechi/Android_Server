const mongoose = require('mongoose')

let useSchema = new mongoose.Schema({
    // _id: { type: mongoose.Schema.Types.ObjectId },
    name: { type: String },
    category: { type: String },
    price: { type: Number },
    image: { type: Array },
    description: { type: String }
});
const Product = mongoose.model('products', useSchema);
module.exports = Product;