const mongoose = require('mongoose')

const AccountSchema = new mongoose.Schema(
    {
        id: { type: Number, required: true, unique: true },
        email: { type: String, required: true, unique: true },
        password: { type: String, required: true },
        fullName: { type: String, required: true },
        address: { type: String, required: true },
        phoneNumber: { type: String, required: true }
    }
);

module.exports = mongoose.model("account", AccountSchema)