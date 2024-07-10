const CartController = require('../controller/cartController')
const router = require('express').Router()

router.post('/add', CartController.createCart)

router.get('/:accountId', CartController.getCartByAccountId);

router.get('/', CartController.getCart)

router.patch('/edit/:_id', CartController.editCart);

router.delete('/delete/:_id', CartController.deleteCart)

module.exports = router