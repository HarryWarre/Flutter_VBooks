const mongoose = require('mongoose')


const PublisherSchema = new mongoose.Schema(
    {
        name: {type: String},
        email: {type: String},
        address: {type: String},
    }
)

module.exports = mongoose.model("Publisher", PublisherSchema)
