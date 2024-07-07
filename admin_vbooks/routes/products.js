const router = require('express').Router()
const productController = require('../controller/productController')

router.post('/createProduct', productController.createProduct)
router.put('/updateProduct/:_id', productController.updateProduct)
router.get('/getProduct', productController.getProduct)
router.delete('/deleteProduct/:_id', productController.deleteProduct)
module.exports = router