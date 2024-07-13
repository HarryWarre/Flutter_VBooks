const mongoose = require("mongoose");
const BestSelling = require("../../models/collection/bestSellingProducts");

module.exports = {
  getBestSelling: async (req, res) => {
    try {
      const bestSellingProducts = await BestSelling.find()
        .sort({ salesCount: -1 })
        .limit(10)
        .populate("productId");
      res.json(bestSellingProducts.map((bp) => bp.productId));
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },
};
