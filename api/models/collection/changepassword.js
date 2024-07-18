const mongoose = require('mongoose')


const ChangePassword = new mongoose.Schema({
    email: { type: String, required: true, unique: true},
    otp: { type: String, required: true },
    otpExpires: { type: Date, required: true }
})

ChangePassword.methods.generateOTP = function() {
    this.otp = Math.floor(10000 + Math.random() * 90000).toString(); // 5 digit OTP
    this.otpExpires = Date.now() + 3600000; // 1 hour 
};

module.exports = mongoose.model('ChangePassword', ChangePassword)