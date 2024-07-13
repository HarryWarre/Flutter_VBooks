const FeaturedProduct = require("../../models/collection/bestSellingProducts");

module.exports = {
  getFearturedProduct: async (req, res) => {
    try {
      const featuredProducts = await FeaturedProduct.find().populate(
        "productId"
      );
      res.json(featuredProducts.map((fp) => fp.productId));
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },
};
