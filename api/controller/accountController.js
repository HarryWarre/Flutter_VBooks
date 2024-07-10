const Account = require('../models/account');

module.exports = {
    register: async (req, res) => {
        const { email, password, fullName, address, phoneNumber, bod, sex } = req.body;

        try {
            // Kiểm tra xem email đã tồn tại chưa
            const existingAccount = await Account.findOne({ email: email });
            if (existingAccount) {
                return res.status(400).json({ success: 'false', message: 'Email đã tồn tại' });
            }

            const newAccount = new Account({ email, password, fullName, address, phoneNumber, bod, sex });
            const savedAccount = await newAccount.save();
            res.status(200).json({ success: 'true', message: 'Tạo thành công', account: savedAccount });
        } catch (err) {
            res.status(500).json(err);
        }
    },
    login: async (req, res) => {
        const { email, password } = req.body;

        try {
            const account = await Account.findOne({ email: email });
            if (!account) {
                return res.status(404).json({ success: 'false', message: 'Tài khoản không tồn tại' });
            }

            if (account.password !== password) {
                return res.status(400).json({ success: 'false', message: 'Mật khẩu không đúng' });
            }

            res.status(200).json({ success: 'true', message: 'Đăng nhập thành công' });
        } catch (err) {
            res.status(500).json(err);
        }
    }
}
