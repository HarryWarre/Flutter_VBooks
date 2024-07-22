const OrderDetail = require("../models/orderDetail");

module.exports = {
  createOrderDetail: async (req, res) => {
    const { orderId, productId, quantity, unitPrice } = req.body;
    console.log(orderId);
    try {
      const newOrderDetail = await new OrderDetail({
        orderId,
        productId,
        quantity,
        unitPrice,
      });
      const savedOrderDetail = await newOrderDetail.save();
      res.status(200).json({
        message: "Thêm thành công",
        success: true,
        orderdetails: savedOrderDetail,
      });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  getOrderDetailsByOrderId: async (req, res) => {
    const orderId = req.params.orderId;
    console.log(`Fetching order details for orderId: ${orderId}`);
    try {
      const orderDetails = await OrderDetail.find({ orderId: orderId }).exec();
      console.log("Order Details:", orderDetails);
      if (!orderDetails || orderDetails.length === 0) {
        return res
          .status(404)
          .json({ message: "Không tìm thấy chi tiết đơn hàng" });
      }
      res.status(200).json({ success: true, orderDetails: orderDetails });
    } catch (err) {
      console.error("Error fetching order details:", err);
      res.status(500).json(err);
    }
  },

  getAllOrderDetail: async (req, res) => {
    // dùng cho admin
    await OrderDetail.find()
      .then((info) => res.json(info))
      .catch((err) => res.json(err));
  },
};
