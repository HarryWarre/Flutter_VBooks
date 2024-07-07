const Product = require('../models/product')

module.exports = {
    createProduct: async (req, res) => {
        const newProduct = new Product({
            name: req.body.name,
            price: req.body.price,
            img: req.body.img,
            desc: req.body.desc,
            catId: req.body.catId,
        }
        )
        try {
            const savedProduct = await newProduct.save();
            console.log(savedProduct)
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
                    },
                }, { new: true }
            );
            if (updateProduct) {
                console.log(updateProduct.toJSON())
                res.status(200).json(updateProduct);
            } else {
                res.status(404).json({ message: 'Category not found' });
            }
        } catch (err) {
            res.status(500).json(err);
        }
    },
    //////////
    getProduct: async (req, res) => {
        await Product.find()
        .then(info => res.json(info))
        .catch(err => res.json(err))
    },

    deleteProduct: async (req, res) => {
        try {
            const deleteProduct = await Product.findByIdAndDelete(req.params._id)
            if(deleteProduct){
                console.log(deleteProduct.toJSON())
                res.json({ success: true, msg: 'Xoá sản phẩm thành công' });
            }else{
                console.log(deleteProduct.toJSON())
                res.json({ success: false, msg: 'Sản phẩm không tìm thấy' });
            }
        }  catch (err) {
            res.status(500).json({ success: false, msg: 'Xoá sản phẩm thất bại' });
        }
    }
}