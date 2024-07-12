const Product = require("../models/product");

module.exports = {
  createProduct: async (req, res) => {
    const { name, price, img, desc, catId, publisherId } = req.body;

    const newProduct = new Product({
      name,
      price,
      img,
      desc,
      catId,
      publisherId,
    });

    try {
      const savedProduct = await newProduct.save();
      console.log(savedProduct);
      res.status(201).json(savedProduct);
    } catch (err) {
      res.status(500).json(err);
    }
  },
  //////
  updateProduct: async (req, res) => {
    try {
      const updateProduct = await Product.findByIdAndUpdate(
        req.params._id,
        {
          $set: {
            name: req.body.name,
            price: req.body.price,
            img: req.body.img,
            desc: req.body.desc,
            catId: req.body.catId,
            publisherId: req.body.publisherId,
          },
        },
        { new: true }
      );
      if (updateProduct) {
        console.log(updateProduct.toJSON());
        res.status(200).json(updateProduct);
      } else {
        res.status(404).json({ message: "Error" });
      }
    } catch (err) {
      res.status(500).json(err);
    }
  },
  //////////
  getProduct: async (req, res) => {
    await Product.find()
      .then((info) => res.json(info))
      .catch((err) => res.json(err));
  },

  getProductByIdCat: async (req, res) => {
    const { catId } = req.params;

    try {
      const products = await Product.find({ catId });
      res.json(products);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  },

  deleteProduct: async (req, res) => {
    try {
      const deleteProduct = await Product.findByIdAndDelete(req.params._id);
      if (deleteProduct) {
        console.log(deleteProduct.toJSON());
        res.json({ success: true, msg: "Xoá sản phẩm thành công" });
      } else {
        console.log(deleteProduct.toJSON());
        res.json({ success: false, msg: "Sản phẩm không tìm thấy" });
      }
    } catch (err) {
      res.status(500).json({ success: false, msg: "Xoá sản phẩm thất bại" });
    }
  },

  searchProduct: async (req, res) => {
    const { keyword } = req.query;
    try {
      const products = await Product.find({
        $or: [
          { name: { $regex: keyword, $options: "i" } }, // Tìm kiếm theo tên (không phân biệt chữ hoa chữ thường)
          { desc: { $regex: keyword, $options: "i" } }, // Tìm kiếm theo mô tả (không phân biệt chữ hoa chữ thường)
        ],
      });
      if (products.length > 0) {
        res.json(products);
      } else {
        res.json({ message: "Không tìm thấy sản phẩm nào" });
      }
    } catch (err) {
      res.status(500).json(err);
    }
  },
};
