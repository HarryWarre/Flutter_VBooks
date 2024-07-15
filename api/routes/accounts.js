const router = require('express').Router()
const AccountController = require('../controller/accountController')

router.post('/register', AccountController.register)

router.post('/login', AccountController.login)

router.get('/', AccountController.getAllAcount)

router.delete('/delete/:id', AccountController.deleteAccount)

router.put('/update/:id', AccountController.updateAccount)

router.get('/:id', AccountController.getAccountInfoById)

module.exports = router