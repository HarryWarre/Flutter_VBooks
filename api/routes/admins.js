const AdminController = require('../controller/adminController')
const router = require('express').Router()

router.post('/createAdmin', AdminController.createAdmin)

router.put("/updateAdmin/:_id", AdminController.updateAdmin);

router.get("/getAdmin", AdminController.getAdmin)

router.get("/byRole/:role", AdminController.getAdminByRole) // truyền vào số

router.delete("/delete/:_id", AdminController.deleteAdmin)

router.post('/login', AdminController.loginAdmin)

router.post('/logout', AdminController.logoutAdmin)

module.exports = router