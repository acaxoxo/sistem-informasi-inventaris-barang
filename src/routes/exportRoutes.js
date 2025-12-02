const express = require('express');

const router = express.Router();
const exportController = require('../controllers/exportController');

// Middleware to check if user is logged in
const isAuthenticated = (req, res, next) => {
  if (req.session && req.session.user) {
    return next();
  }
  return res.redirect('/login');
};

// Export routes
router.get('/export/stock', isAuthenticated, exportController.exportStock);
router.get('/export/barangmasuk', isAuthenticated, exportController.exportBarangMasuk);
router.get('/export/barangkeluar', isAuthenticated, exportController.exportBarangKeluar);

module.exports = router;
