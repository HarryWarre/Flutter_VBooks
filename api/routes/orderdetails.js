const router = require("express").Router();
const OrderDetailController = require("../controller/orderdetailsController");

router.post("/add", OrderDetailController.createOrderDetail);

router.get("/", OrderDetailController.getAllOrderDetail);

router.get("/:orderId", OrderDetailController.getOrderDetailsByOrderId);

module.exports = router;
