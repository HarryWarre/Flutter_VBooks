const router = require('express').Router()
const AccountController = require('../controller/accountController')

router.post('/register', AccountController.register)

module.exports = router