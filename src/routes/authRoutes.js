const express = require('express');

const router = express.Router();
const {
  login,
  logout,
  getRegister,
  postRegister,
} = require('../controllers/authController');

router.post('/login', login);
router.get('/logout', logout);
router.get('/register', getRegister);
router.post('/register', postRegister);

module.exports = router;
