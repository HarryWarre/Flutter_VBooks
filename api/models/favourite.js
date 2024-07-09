const mongoose = require('mongoose')

const FavoriteSchema = new mongoose.Schema(
    {
        accountId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "Account", 
            required: true 
        },
        productId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "Product", 
            required: true 
        }
    }
);

module.exports = mongoose.model("Favourite", FavoriteSchema)