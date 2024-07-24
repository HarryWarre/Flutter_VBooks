const Order = require("../models/order");

module.exports = {
  addOrder: async (req, res) => {
    const { userId, status, paymentMethodId, totalAmount } = req.body;

    try {
      const addOrders = await new Order({
        userId,
        status,
        paymentMethodId,
        totalAmount,
      });
      const savedOrder = await addOrders.save();
      res.json({ message: "Tạo thành công", success: savedOrder });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  getAllOrders: async (req, res) => {
    try {
      const orders = await Order.find({})
        .populate('userId', 'fullName address phoneNumber')
        .populate('paymentMethodId', 'name');
      res.status(200).json({ success: true, orders });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  getOrderById: async (req, res) => {
    const { userId } = req.params;
    console.log(userId);
    try {
      const orders = await Order.find({ userId: userId })
      .populate('paymentMethodId', 'name');

      console.log(orders);
      res.status(200).json({ success: true, orders: orders });
    } catch (err) {
      res.status(500).json(err);
    }
  },
  editOrderById: async (req, res) => {
    const { userId } = req.params;
    const { status } = req.body;

    try {
      const updateResult = await Order.updateMany(
        { userId: userId },
        { $set: { status: status } }
      );

      if (updateResult.nModified === 0) {
        return res
          .status(404)
          .json({ message: "Không tìm thấy đơn hàng để cập nhật" });
      }

      res.status(200).json({ success: true, message: "Cập nhật thành công" });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  updateOrderStatus: async (req, res) => {
    const { orderId } = req.params;
    const { status } = req.body;

    try {
      const updatedOrder = await Order.findByIdAndUpdate(
        orderId,
        { status },
        { new: true }
      );
      if (!updatedOrder) {
        return res.status(404).json({ message: 'Order not found' });
      }
      res.json({ message: 'Order status updated successfully', updatedOrder });
    } catch (err) {
      res.status(500).json(err);
    }
  },
  
  
};
