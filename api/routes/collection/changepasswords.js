const express = require('express');
const router = express.Router();
const passwordController = require('../../controller/collection/changepasswordController'); // adjust the path if necessary

// Route to request password reset OTP
router.post('/forgot-password', passwordController.forgotPassword);

// Route to reset password using OTP
router.post('/reset-password', passwordController.resetPassword);

module.exports = router;
