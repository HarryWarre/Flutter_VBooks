const Account = require('../models/account')

module.exports = {
    register: async (req, res) => {
        const { email, password, fullName, address, phoneNumber, bod, sex} = req.body

        try{
            const newAccount = new Account({email, password, fullName, address, phoneNumber, bod, sex})
            const savedAccount = newAccount.save()
            res.status(200).json({success: 'true', message: 'Tạo thành công'})
            console.log(savedAccount)
        }
        catch(err)
        {
            res.status(500).json(err)
        }
    }
}