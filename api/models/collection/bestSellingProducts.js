const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BestSellingProductSchema = new Schema({
  productId: { type: Schema.Types.ObjectId, ref: "Product", required: true },
  salesCount: { type: Number, default: 0 },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("BestSellingProduct", BestSellingProductSchema);
