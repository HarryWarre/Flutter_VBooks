const Account = require('../../models/account')
const ChangePassword = require('../../models/collection/changepassword')
const nodemailer = require('nodemailer')
const bcrypt = require('bcrypt')
const doten = require('dotenv')

doten.config()

exports.forgotPassword = async (req, res) => {
    try{
        const account = await Account.findOne({email: req.body.email})
        if(!account) return res.status(404).json({message: 'Email không tồn tại', success: false})

        const passwordReset = new ChangePassword({email: req.body.email})
        passwordReset.generateOTP()
        await passwordReset.save()

        const transporter = nodemailer.createTransport({
            service: 'Gmail',
            auth: {
                user: process.env.AUTH_USER,
                pass: process.env.AUTH_PASSWORD,
            }   
        })

        const mailOptions = {
            to: account.email,
            from: 'passwordreset@yourdomain.com',
            subject: 'Password Reset OTP',
            text: `You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n
            Your OTP for password reset is ${passwordReset.otp}. This OTP is valid for one hour.\n\n
            If you did not request this, please ignore this email and your password will remain unchanged.\n`
        };

        transporter.sendMail(mailOptions, (err) => {
            if (err) return res.status(500).send('Error sending email');
            res.status(200).send('An email has been sent to ' + account.email + ' with the OTP.');
        });

    }catch(e){
        res.status(500).send(e.message);
    }
}

exports.resetPassword = async (req, res) => {
    try {
        const { otp, oldPassword, newPassword} = req.body

        const passwordReset = await ChangePassword.findOne({
            otp,
            otpExpires: { $gt: Date.now() }
        })

        if(!passwordReset) return res.status(400).send('Mã OTP đã hết hạn')

        const account = await Account.findOne({ email: passwordReset.email })
        if (!account) return res.status(404).send('No account with that email found.')
    
        const isMatch = await bcrypt.compare(oldPassword, account.password)
        if (!isMatch) return res.status(400).send('Old password is incorrect.')

        account.password = newPassword
        await account.save()

        await ChangePassword.deleteOne({otp});
        res.status(200).json('Đổi mật khẩu thành công')
        
    } catch (e) {
        res.status(500).json(e.message)
    }
}