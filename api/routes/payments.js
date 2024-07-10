const PaymentController = require('../controller/paymentController')
const router = require('express').Router()

router.post('/createPayment',PaymentController.createPayment)

router.get('/getPayment', PaymentController.getPayment)

router.get('/getByPayment/:name?',PaymentController.getByPayment)

module.exports = router