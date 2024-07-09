const mongoose = require('mongoose')
const Admin = require('../models/admin')

module.exports = {
    createAdmin: async (req,res) => {
        const { email, password, role } = req.body

        try{
            const newAdmin = new Admin({email, password, role})
            const savedAdmin = await newAdmin.save()
            res.status(200).json(savedAdmin)
        }catch(err){
            res.status(500).json(err)
        }
    },
    updateAdmin: async (req, res) => {
        const { password, role} = req.body
        console.log(password)
        console.log(role)
        try{
            const updateAdmin = await Admin.findByIdAndUpdate(
                req.params._id, 
                {
                    $set: 
                    {
                        password: password,
                        role: role
                    },
                    
                },
                {new: true}
            )
            console.log(updateAdmin)
            res.status(200).json(updateAdmin)
        }catch(err){
            res.status(500).json(err)
        }
    },
    getAdmin: async (req, res) => {
        await Admin.find()
        .then(info => res.json(info))
        .catch(err => res.json(err))
    },

    getAdminByRole: async (req, res) => {
        const { role } = req.params; // Lấy vai trò từ đường dẫn URL
    
        try {
            const admins = await Admin.find({ role: role });
    
            if (!admins || admins.length === 0) {
                return res.status(404).json({ message: "Không tìm thấy admin với vai trò này" });
            }
    
            res.status(200).json(admins);
        } catch (err) {
            console.error("Lỗi khi lấy danh sách admin theo vai trò:", err);
            res.status(500).json(err);
        }
    },
    
    deleteAdmin: async (req, res) => {
        const id = req.params._id

        try{
            const deletedAdmin = await Admin.findByIdAndDelete(id)
            if(!deletedAdmin){
                return res.status(404).json({message: 'Không thể tim thấy admin này'})
            }
            res.json({success: true, message: 'Xóa thành công'})
        }catch(err){
            res.status(500).json(err)
        }
    }
}