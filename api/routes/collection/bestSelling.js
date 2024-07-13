const router = require("express").Router();
const BestSelling = require("../../controller/collection/bestSellingController");

router.get("/getBestSelling", BestSelling.getBestSelling);

module.exports = router;
