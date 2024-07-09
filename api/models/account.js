const mongoose = require('mongoose')

const AccountSchema = new mongoose.Schema(
    {
        email: { type: String, required: true, unique: true },
        password: { type: String, required: true },
        fullName: { type: String, required: true },
        address: { type: String, required: true },
        phoneNumber: { type: String, required: true },
        bod: {type: Date, required: true},
        sex: {type: Number, required: true}
    }
);

module.exports = mongoose.model("account", AccountSchema)