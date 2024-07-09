const mongoose = require('mongoose');

const OrderDetailSchema = new mongoose.Schema(
    {
        orderId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "Order", 
            required: true 
        },
        productId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "Product", 
            required: true 
        },
        quantity: { type: Number, required: true },
        unitPrice: { type: Number, required: true }
    }
);

module.exports = mongoose.model("OrderDetail", OrderDetailSchema);