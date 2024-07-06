const mongoose = require('mongoose')

const CategorySchema = new mongoose.Schema(
    {
        name: {type: String, require: true},
        desc: {type: String, require: true},
    }
)

module.exports = mongoose.model("category", CategorySchema)