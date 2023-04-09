const mongoose = require('mongoose')
let useSchema = new mongoose.Schema({
    _id: { type: mongoose.Schema.Types.ObjectId },
    username: {
        type: String,
        require: true
    },
    pass: {
        type: String,
        require: true
    },
    role: {
        type: String,
        require: true
    },
    email: {
        type: String,
        require: true
    },
    date: {
        type: Number,
        require: true
    }
});
const User = mongoose.model('logins', useSchema);
module.exports = User;