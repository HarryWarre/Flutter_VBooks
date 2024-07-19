const mongoose = require('mongoose');

const ChangePasswordSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true },
    otp: { type: String, required: true },
    otpExpires: { type: Date, default: Date.now, expires: 3600 } // hạn sử dụng 1h
});

ChangePasswordSchema.methods.generateOTP = function() {
    this.otp = Math.floor(10000 + Math.random() * 90000).toString(); // 5 digit OTP
    this.otpExpires = Date.now() + 3600000; // 1 tiếng
};

module.exports = mongoose.model('ChangePassword', ChangePasswordSchema);
