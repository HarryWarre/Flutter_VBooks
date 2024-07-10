const mongoose = require('mongoose')

const FavoriteSchema = new mongoose.Schema(
    {
        accountId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "account", 
            required: true 
        },
        productId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "product", 
            required: true 
        }
    }
);

module.exports = mongoose.model("Favourite", FavoriteSchema)