const router = require("express").Router();
const productController = require("../controller/productController");

router.post("/createProduct", productController.createProduct);
router.put("/updateProduct/:_id", productController.updateProduct);
router.delete("/deleteProduct/:_id", productController.deleteProduct);
router.get("/getProduct", productController.getProduct);
router.get("/search/", productController.searchProduct);
router.get("/findByCatId/:catId", productController.getProductByIdCat);
router.get("/findById/:_id", productController.getProductById)
module.exports = router;
