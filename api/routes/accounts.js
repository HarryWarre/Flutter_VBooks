const router = require('express').Router()
const AccountController = require('../controller/accountController')

router.post('/register', AccountController.register)

router.post('/login', AccountController.login)

module.exports = router