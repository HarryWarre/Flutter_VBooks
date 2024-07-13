const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const FeaturedProductSchema = new Schema({
  productId: { type: Schema.Types.ObjectId, ref: "Product", required: true },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("FeaturedProduct", FeaturedProductSchema);
