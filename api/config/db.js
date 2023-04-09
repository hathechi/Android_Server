const mongoose = require('mongoose')
// ---------Connect MongoDB-----------
const uri = "mongodb+srv://thechi1832000:8613876354053@cluster0.rnh3kip.mongodb.net/AndroidServer?retryWrites=true&w=majority";


async function connect() {
    try {
        await mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });
        console.log("Connected to MongoDB");
    } catch (error) {
        console.error(error);
    }
}
// connect();

module.exports = connect();
