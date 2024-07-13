const router = require("express").Router();
const FeaturedProduct = require("../../controller/collection/fearturedController");

router.get("/getFearturedProduct", FeaturedProduct.getFearturedProduct);

module.exports = router;
