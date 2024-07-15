const AccountModel = require('../models/account');
const jwt = require('jsonwebtoken');

class AccountService {
    static async generateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
    }
}

module.exports = AccountService;