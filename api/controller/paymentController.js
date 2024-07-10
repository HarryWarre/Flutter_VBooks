const Payment = require('../models/paymentMethods')

module.exports = {
    createPayment: async (req, res) =>{
        const {name} = req.body
        console.log(name)
        try{
            newPayment = new Payment({name}) 
            await newPayment.save()
            res.json({success: true, message: 'Tạo thành công'})
        }catch(err){
            res.status(500).json(err)
            console.log(err)
        }
    },

    getPayment: async (req, res) => {
        await Payment.find()
                     .then(info => res.json(info))
                     .catch(err => res.json(err))                
    },

    getByPayment: async (req, res) => {
        const { name } = req.params // lấy phương thức thanh toán dựa theo tên 
        try {
            console.log(name)
            if(!name){
                this.getPayment(req, res)
            }// if này bị lỗi

            const payments = await Payment.find({ name: { $regex: new RegExp(name, 'i') } });
    
            if (!payments || payments.length === 0) {
                return res.status(404).json({ message: "Không tìm thấy phương thức thanh toán này" });
            }

            res.status(200).json(payments);
        } catch (err) {
            res.status(500).json(err);
        }
    }
    

    
}