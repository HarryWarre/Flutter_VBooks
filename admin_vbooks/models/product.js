const mongoose = require('mongoose')


const ProductSchema = new mongoose.Schema(
    {
        name: {type: String, required: true},
        price: {type: String, required: true},
        img: {type: String, required: true},
        desc: {type: String, required: true},
        catId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "category",
        },
    }
)

module.exports = mongoose.model("product", ProductSchema)
