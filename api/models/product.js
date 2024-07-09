const mongoose = require('mongoose')


const ProductSchema = new mongoose.Schema(
    {
        name: { type: String, required: true },
        price: { type: Number, required: true },
        img: { type: String },
        desc: { type: String },
        catId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "category",
            required: true
        },
        publisherId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Publisher",
            required: true
        }
    }
);

module.exports = mongoose.model("Product", ProductSchema)
