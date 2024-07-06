const Product = require('../models/product')

module.exports = {
    createProduct: async (req, res)=> {
        const newProduct = new Product({
            name: req.body.name,
            price: req.body.price,
            img: req.body.img,
            des: req.body.des,
            catId: req.body.catId,
        })
        try{
            const savedProduct = newProduct.save();
            console.log(savedProduct)
            res.status(201).json(savedProduct);
        }catch(err){
            res.status(500).json(err);
        }
    }

}