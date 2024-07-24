const router = require('express').Router()
const OrderController = require('../controller/orderController')

router.get('/all', OrderController.getAllOrders);

router.post('/add', OrderController.addOrder)

router.get('/:userId', OrderController.getOrderById)

router.patch('/edit/:userId', OrderController.editOrderById)

router.put('/update/:orderId', OrderController.updateOrderStatus);

module.exports = router