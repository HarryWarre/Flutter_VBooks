const mongoose = require('mongoose');

const OrderSchema = new mongoose.Schema(
    {
        orderId: { type: Number, required: true, unique: true },
        userId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "Account", 
            required: true 
        },
        orderDate: { type: Date, default: Date.now },
        status: { type: String, required: true },
        paymentMethodId: { 
            type: mongoose.Schema.Types.ObjectId, 
            ref: "PaymentMethod", 
            required: true 
        },
        totalAmount: { type: Number, required: true }
    }
);

module.exports = mongoose.model("Order", OrderSchema);