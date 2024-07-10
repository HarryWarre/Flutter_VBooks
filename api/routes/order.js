const router = require('express').Router()
const OrderController = require('../controller/orderController')

router.post('/add', OrderController.addOrder)

router.get('/:userId', OrderController.getOrderById)

router.patch('/edit/:userId', OrderController.editOrderById)

module.exports = router