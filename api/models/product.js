const mongoose = require('mongoose')


const ProductSchema = new mongoose.Schema(
    {
        name: {type: String},
        price: {type: Number},
        img: {type: String},
        desc: {type: String},
        catId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "category",
        },
    }
)

module.exports = mongoose.model("product", ProductSchema)
