const categoryController = require("../controller/categoryController")
const router = require("express").Router()

router.post("/createCategory", categoryController.createCategory)
router.put("/updateCategory/:_id", categoryController.updateProduct)
router.get("/getCategory",categoryController.getCategory)
router.delete("/deleteCategory/:_id", categoryController.deleteCategory)
module.exports = router

