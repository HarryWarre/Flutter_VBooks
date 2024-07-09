const mongoose = require('mongoose')

const AdminSchema = new mongoose.Schema(
    {
        email: { type: String, required: true, unique: true },
        password: { type: String, required: true },
        role: { type: Number, required: true, default: 2 }
    }
)

module.exports = mongoose.model('admin', AdminSchema)
