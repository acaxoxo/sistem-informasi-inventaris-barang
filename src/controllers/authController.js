const bcrypt = require('bcrypt');
const { body, validationResult } = require('express-validator');
const user = require('../queries/usersQuery');

const login = async (req, res) => {
  try {
    const rawEmail = (req.body.email || '').trim();
    const password = req.body.password || '';
    const emailLower = rawEmail.toLowerCase();

    const record = await user.getUserByEmailLower(emailLower);
    if (!record) {
      return res.render('login', { title: 'Login', loginFail: 'Email atau kata sandi salah.' });
    }

    const checkPass = await bcrypt.compare(password, record.password);
    if (!checkPass) {
      return res.render('login', { title: 'Login', loginFail: 'Email atau kata sandi salah.' });
    }

    req.session.user = { email: record.email, role: record.role };
    return res.redirect('/');
  } catch (e) {
    return res.render('login', { title: 'Login', loginFail: 'Email atau kata sandi salah.' });
  }
};

const logout = (req, res) => {
  req.session = null;
  res.render('login', { title: 'Login', logout: 'Keluar berhasil.' });
};

// Render register page
const getRegister = (req, res) => {
  if (req.session && req.session.user) {
    return res.redirect('/');
  }
  return res.render('register', { title: 'Daftar', form: { email: '' }, errors: [] });
};

// Handle registration
const postRegister = [
  body('email')
    .isEmail()
    .withMessage('Email tidak valid.')
    .bail()
    .custom(async (value) => {
      const duplicate = await user.email2(value.toLowerCase());
      if (duplicate) {
        throw new Error('Email sudah terdaftar.');
      }
      return true;
    }),
  body('password')
    .isLength({ min: 6 })
    .withMessage('Kata sandi minimal 6 karakter.'),
  body('confirmPassword')
    .custom((value, { req }) => {
      if (value !== req.body.password) {
        throw new Error('Konfirmasi kata sandi tidak cocok.');
      }
      return true;
    }),
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).render('register', {
        title: 'Daftar',
        errors: errors.array(),
        form: { email: req.body.email },
      });
    }

    try {
      const { email } = req.body;
      const hashed = await bcrypt.hash(req.body.password, 10);

      await user.addUser(email, hashed, 'user');

      // Auto login after successful registration
      req.session.user = { email, role: 'user' };
      return res.redirect('/');
    } catch (e) {
      // On unexpected server/DB error, re-render with a generic message
      // Use 200 to keep page load smooth while surfacing the issue to the user
      return res.status(200).render('register', {
        title: 'Daftar',
        errors: [{ msg: 'Terjadi kesalahan pada server. Coba lagi nanti.' }],
        form: { email: req.body.email },
      });
    }
  },
];

module.exports = {
  login,
  logout,
  getRegister,
  postRegister,
};
