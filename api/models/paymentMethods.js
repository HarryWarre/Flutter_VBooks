const mongoose = require('mongoose');

const PaymentMethodSchema = new mongoose.Schema(
    {
        id: { type: Number, required: true, unique: true },
        name: { type: String, required: true }
    }
);

module.exports = mongoose.model("paymentmethod", PaymentMethodSchema);
