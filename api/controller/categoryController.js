const mongoose = require('mongoose');
const Category = require('../models/category');
const Product = require('../models/product')

module.exports = {
    createCategory: async (req, res) => {
        const { name } = req.body;

        if (!name) {
            return res.status(400).json({ success: false, msg: 'Tên không được để trống' });
        }

        const newCategory = new Category({ name });

        try {
            const savedCategory = await newCategory.save();
            res.status(200).json(savedCategory);
        } catch (err) {
            res.status(500).json(err);
        }
    },
    updateCategory: async (req, res) => {
        const { name, desc } = req.body;
        const categoryId = req.params._id;

        if (!mongoose.Types.ObjectId.isValid(categoryId)) {
            return res.status(400).json({ message: 'Invalid category ID' });
        }

        try {
            const updatedCategory = await Category.findByIdAndUpdate(
                categoryId,
                {
                    $set: {
                        name: name,
                        desc: desc,
                    },
                },
                { new: true } // Trả về tài liệu đã cập nhật
            );
            if (updatedCategory) {
                res.status(200).json(updatedCategory);
            } else {
                res.status(404).json({ message: 'Category not found' });
            }
        } catch (err) {
            res.status(500).json(err);
        }
    },
    
    getCategory: async (req, res) => {
        try {
            const categories = await Category.aggregate([
                {
                    $lookup: {
                        from: 'products', // Tên của collection chứa sản phẩm
                        localField: '_id', // Khóa chính của bảng categories
                        foreignField: 'catId', // Khóa ngoại của bảng products
                        as: 'products' // Tên của mảng chứa sản phẩm kết hợp trong kết quả
                    }
                }
            ]);
            res.json(categories);
        } catch (err) {
            res.status(500).json(err);
        }
    },
     
    deleteCategory: async (req, res) => {
        const categoryId = req.params._id;

        if (!mongoose.Types.ObjectId.isValid(categoryId)) {
            return res.status(400).json({ message: 'ID không tồn tại' });
        }

        try {
            
            const productsUsingCategory = await Product.findOne({ catId: categoryId });

            if (productsUsingCategory) {
                await console.log(productsUsingCategory)
                return res.status(400).json({ success: false, msg: 'Không thể xoá thể loại đang được sử dụng trong sản phẩm' });
            }
            else{
                const deletedCategory = await Category.findByIdAndDelete(categoryId);
            if (deletedCategory) {
                res.json({ success: true, msg: 'Xoá thể loại thành công' });
            } else {
                res.json({ success: false, msg: 'Thể loại không tìm thấy' });
            }
            }          
        } catch (err) {
            console.log(err)
            res.status(500).json({ success: false, msg: 'Xoá thể loại thất bại' });
        }
    },

    searchCategory: async (req, res) => {
        const { keyword } = req.query;
        try {
            const categories = await Category.find({
                name: { $regex: keyword, $options: 'i' }, // Tìm kiếm theo tên danh mục (không phân biệt chữ hoa chữ thường)
            });
            if (categories.length > 0) {
                res.json(categories);
            } else {
                res.json({ message: 'Không tìm thấy danh mục nào' });
            }
        } catch (err) {
            res.status(500).json(err);
        }
    },
};
