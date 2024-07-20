const Account = require('../../models/account');
const ChangePassword = require('../../models/collection/changepassword');
const nodemailer = require('nodemailer');
const bcrypt = require('bcrypt');
const dotenv = require('dotenv');

dotenv.config();

exports.forgotPassword = async (req, res) => {
    try {
        const account = await Account.findOne({ email: req.body.email });
        if (!account) return res.status(404).json({ message: 'Email không tồn tại', success: false });

        const passwordReset = new ChangePassword({ email: req.body.email });
        passwordReset.generateOTP();
        await passwordReset.save();

        const transporter = nodemailer.createTransport({
            service: 'Gmail',
            auth: {
                user: process.env.AUTH_USER,
                pass: process.env.AUTH_PASSWORD,
            }
        });

        const mailOptions = {
            to: account.email,
            from: 'passwordreset@yourdomain.com',
            subject: 'Đổi mật khẩu',
            text: `Bạn nhận được mail này là bởi vì bạn hoặc một ai đó đã đề nghị đổi mật khẩu 
            \nMã OTP của bạn là ${passwordReset.otp}. Mã này sẽ có hiệu lực trong 1 giờ. 
            \nNếu bạn không gửi yêu cầu đổi mật khẩu, xin đừng quan tâm đến mail này và mật khẩu sẽ không bị đổi`
        };

        transporter.sendMail(mailOptions, (err) => {
            if (err) return res.status(500).json('Error sending email');
            res.status(200).json({message: 'Email đã chuyển tới ' + account.email + ' với mã OTP.', success: true});
        });

    } catch (e) {
        res.status(500).json(e.message);
    }
}

exports.resetPassword = async (req, res) => {
    try {
        const { otp,  newPassword } = req.body;

        const passwordReset = await ChangePassword.findOne({
            otp,
            otpExpires: { $gt: Date.now() }
        });

        if (!passwordReset) return res.status(400).json({message: 'Mã OTP đã hết hạn', success: false});

        const account = await Account.findOne({ email: passwordReset.email });
        if (!account) return res.status(404).json({message: 'Email này không tồn tại.' , success: false});


        account.password = newPassword;
        await account.save()
        console.log(account)
        await ChangePassword.deleteOne({ otp });
        res.status(200).json({message: 'Đổi mật khẩu thành công'});

    } catch (e) {
        res.status(500).json({message: e.message});
    }
}
