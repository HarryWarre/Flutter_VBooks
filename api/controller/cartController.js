const Cart = require("../models/cart");

module.exports = {
  createCart: async (req, res) => {
    const { accountId, productId, quantity } = req.body;

    try {
      const Carts = await new Cart({ accountId, productId, quantity });
      const saveCart = await Carts.save();
      res
        .status(200)
        .json({
          message: "Tạo giỏ hàng thành công",
          success: true,
          cart: saveCart,
        });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  getCartByAccountId: async (req, res) => {
    const { accountId } = req.params;
    try {
      const carts = await Cart.find({ accountId: accountId });

      res.status(200).json({ success: true, carts: carts });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  getCart: async (req, res) => {
    await Cart.find()
      .then((info) => res.json(info))
      .catch((err) => res.json(err));
  },

  editCart: async (req, res) => {
    const { _id } = req.params;
    const { quantity } = req.body;

    try {
      const updatedCart = await Cart.findByIdAndUpdate(
        _id,
        { $set: { quantity: quantity } },
        { new: true, runValidators: true } // `new: true` để trả về tài liệu đã cập nhật
      );

      if (!updatedCart) {
        return res.status(404).json({ message: "Không tìm thấy giỏ hàng" });
      }

      res
        .status(200)
        .json({
          success: true,
          message: "Cập nhật thành công",
          cart: updatedCart,
        });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  deleteCart: async (req, res) => {
    const { _id } = req.params;
    console.log(_id);
    try {
      const deletedCart = await Cart.findByIdAndDelete(_id);
      if (deletedCart) {
        res.json({ success: true, message: "Xóa giỏ hàng thành công" });
      } else {
        res.json({ success: false, message: "Không tìm thấy giỏ hàng" });
      }
    } catch (error) {
      res
        .status(500)
        .json({
          success: false,
          message: "Xoá giỏ hàng thất bại",
          error: error.message,
        });
    }
  },
};
