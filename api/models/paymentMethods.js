const mongoose = require('mongoose');

const PaymentMethodSchema = new mongoose.Schema(
    {
        name: { type: String, required: true }
    }
);

module.exports = mongoose.model("PaymentMethod", PaymentMethodSchema);
