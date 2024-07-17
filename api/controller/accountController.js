const Account = require('../models/account');
const AccountService = require('../service/accountservice');

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
                return res.status(404).json({ success: false, message: 'Tài khoản không tồn tại' });
            }
            
            const isMatch = await account.comparePassword(password);
            if (!isMatch) {
                return res.status(404).json({success: false, message: 'Sai mật khẩu'})
            }
            console.log(isMatch)

            let tokenData = {
                _id: account._id,
                email: account.email,
                fullName: account.fullName,
                address: account.address,
                phoneNumber: account.phoneNumber,
                bod: account.bod,
                sex: account.sex
            };
            console.log(tokenData)
            const token = await AccountService.generateToken(tokenData, "secretKey", '1h');
            res.status(200).json({ success: true, token: token });

        } catch (err) {
            console.log(err); // Log lỗi để xác định nguyên nhân
            res.status(500).json({ success: false, message: 'Đăng nhập không thành công' });
        }
    },
    getAllAcount: async (req, res) => {
        await Account.find()
                .then(info => res.json(info))
                .catch(err => res.json(err))
    },
    getAccountInfoById: async (req, res) => {
        const id = req.params.id; // Lấy id từ params
    
        try {           
            const account = await Account.findById(id);
    
            if (!account) {
                return res.status(404).json({ success: false, message: 'Không tìm thấy tài khoản' });
            }
               
            res.status(200).json({ success: true, account: account });
    
        } catch (err) {
            console.log(err); // Log lỗi để xác định nguyên nhân
            res.status(500).json({ success: false, message: 'Lỗi khi lấy thông tin tài khoản' });
        }
    },
     updateAccount: async (req, res) => {
        const id = req.params.id; // Giả sử bạn truyền id người dùng trong URL
        const { fullName, address, phoneNumber, bod, sex } = req.body; // Lấy các trường từ request body
    
        try {
            // Lấy thông tin người dùng hiện tại từ cơ sở dữ liệu
            const user = await Account.findById(id);
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
    
            // Cập nhật các trường chỉ khi chúng tồn tại trong request body
            if (fullName) {
                user.fullName = fullName;
            }
            if (address) {
                user.address = address;
            }
            if (phoneNumber) {
                user.phoneNumber = phoneNumber;
            }
            if (bod) {
                user.bod = new Date(bod); // Chuyển đổi bod thành đối tượng Date
            }
            if (sex) {
                user.sex = sex;
            }
    
            // Lưu người dùng cập nhật vào cơ sở dữ liệu
            await user.save();
    
            res.status(200).json({ message: 'Account updated successfully', user });
        } catch (error) {
            console.error(error);
            res.status(500).json({ message: 'Server error' });
        }
    },

    deleteAccount: async (req, res) => {
        const id  = req.params
        console.log(id)
        try{
            const deletedAccount = await Account.findByIdAndDelete(id)
            if(!deletedAccount){
                return res.status(404).json({message: 'Không thể tìm thấy tài khoản này'})
            }
            res.json({success: true, message: 'Xóa thành công'})
        }catch(err){
                res.status(500).json(err)
        }
    }
}
