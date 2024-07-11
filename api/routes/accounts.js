const router = require('express').Router()
const AccountController = require('../controller/accountController')

router.post('/register', AccountController.register)

router.post('/login', AccountController.login)

router.get('/', AccountController.getAllAcount)

router.delete('/delete/:_id', AccountController.deleteAccount)
module.exports = router