const categoryController = require("../controller/categoryController");
const router = require("express").Router();

router.post("/createCategory", categoryController.createCategory);
router.put("/updateCategory/:_id", categoryController.updateCategory);
router.get("/getCategory", categoryController.getCategory);
router.delete("/deleteCategory/:_id", categoryController.deleteCategory);
router.get("/search/", categoryController.searchCategory);
module.exports = router;
