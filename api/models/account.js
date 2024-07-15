const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const AccountSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    fullName: { type: String, default: "" },
    address: { type: String, default: "" },
    phoneNumber: { type: String, default: "" },
    bod: { type: Date, default: null },
    sex: { type: Number, default: 1 }
});

AccountSchema.pre('save', async function(next) {
    try {
        const account = this;
        if (!account.isModified('password')) return next();

        const salt = await bcrypt.genSalt(10);
        const hashPass = await bcrypt.hash(account.password, salt);

        account.password = hashPass;
        next();
    } catch (err) {
        next(err);
    }
});

AccountSchema.methods.comparePassword = async function(userPassword){
    try {
        const isMatch = await bcrypt.compare(userPassword, this.password)
        return isMatch
    } catch (error) {
        throw error;
    }
}

module.exports = mongoose.model("Account", AccountSchema);
