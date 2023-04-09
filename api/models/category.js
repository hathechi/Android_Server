const mongoose = require('mongoose')
let useSchema = new mongoose.Schema({
    name_category: { type: String }
});
const Category = mongoose.model('category', useSchema);
module.exports = Category;