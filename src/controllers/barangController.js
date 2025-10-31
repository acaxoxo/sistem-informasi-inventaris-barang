const { promisify } = require('util');
const fs = require('fs');
const { body, validationResult } = require('express-validator');
const moment = require('moment');
// const { createCanvas } = require("canvas");
// const JsBarcode = require("jsbarcode");
const stok = require('../queries/stockBarangQuery');
const bmasuk = require('../queries/barangMasukQuery');
const bkeluar = require('../queries/barangKeluarQuery');

// Image upload removed

// Delete File
const unlinkAsync = promisify(fs.unlink);

// Canvas
// const canvas = createCanvas();

const getBarang = async (req, res) => {
  if (req.session.user && req.session.user.role === 'superadmin') {
    const barang = await stok.getBarang();
    res.render('barang', {
      user: req.session.user.email,
      title: 'Stok Barang',
      brg: barang,
      showAdminMenu: true,
    });
  } else if (req.session.user && req.session.user.role === 'admin') {
    const barang = await stok.getBarang();
    res.render('barang', {
      user: req.session.user.email,
      title: 'Stok Barang',
      brg: barang,
      showAdminMenu: false,
    });
  } else if (req.session.user && req.session.user.role === 'operator') {
    const barang = await stok.getBarang();
    res.render('barang', {
      us: req.session.user.email,
      title: 'Stok Barang',
      brg: barang,
    });
  } else if (req.session.user && req.session.user.role === 'viewer') {
    const barang = await stok.getBarang();
    res.render('barang', {
      us: req.session.user.email,
      title: 'Stok Barang',
      brg: barang,
    });
  } else if (req.session.user && req.session.user.role === 'supplier') {
    const barang = await stok.getBarang();
    res.render('barang', {
      us: req.session.user.email,
      title: 'Stok Barang',
      brg: barang,
    });
  } else if (req.session.user && req.session.user.role === 'user') {
    const barang = await stok.getBarang();
    res.render('barang', {
      us: req.session.user.email,
      title: 'Stok Barang',
      brg: barang,
    });
  } else {
    res.status(401);
    res.render('401', { title: '401 Error' });
  }
};

const getBarangDetail = async (req, res) => {
  if (req.session.user && req.session.user.role === 'superadmin') {
    const barang = await stok.getDetail(req.params.id);
    const barangMasuk = await bmasuk.getDetailBarang(req.params.id);
    const barangKeluar = await bkeluar.getDetailBarang(req.params.id);

    res.render('barangDetail', {
      brg: barang,
      user: req.session.user.email,
      title: 'Detail Barang',
      brgm: barangMasuk,
      brgk: barangKeluar,
      moment,
      showAdminMenu: true,
    });
  } else if (req.session.user && req.session.user.role === 'admin') {
    const barang = await stok.getDetail(req.params.id);
    const barangMasuk = await bmasuk.getDetailBarang(req.params.id);
    const barangKeluar = await bkeluar.getDetailBarang(req.params.id);

    res.render('barangDetail', {
      brg: barang,
      user: req.session.user.email,
      title: 'Detail Barang',
      brgm: barangMasuk,
      brgk: barangKeluar,
      moment,
      showAdminMenu: false,
    });
  } else if (req.session.user && req.session.user.role === 'operator') {
    const barang = await stok.getDetail(req.params.id);
    const barangMasuk = await bmasuk.getDetailBarang(req.params.id);
    const barangKeluar = await bkeluar.getDetailBarang(req.params.id);

    res.render('barangDetail', {
      brg: barang,
      us: req.session.user.email,
      title: 'Detail Barang',
      brgm: barangMasuk,
      brgk: barangKeluar,
      moment,
    });
  } else if (req.session.user && req.session.user.role === 'viewer') {
    const barang = await stok.getDetail(req.params.id);
    const barangMasuk = await bmasuk.getDetailBarang(req.params.id);
    const barangKeluar = await bkeluar.getDetailBarang(req.params.id);

    res.render('barangDetail', {
      brg: barang,
      us: req.session.user.email,
      title: 'Detail Barang',
      brgm: barangMasuk,
      brgk: barangKeluar,
      moment,
    });
  } else if (req.session.user && req.session.user.role === 'supplier') {
    const barang = await stok.getDetail(req.params.id);
    const barangMasuk = await bmasuk.getDetailBarang(req.params.id);
    const barangKeluar = await bkeluar.getDetailBarang(req.params.id);

    res.render('barangDetail', {
      brg: barang,
      us: req.session.user.email,
      title: 'Detail Barang',
      brgm: barangMasuk,
      brgk: barangKeluar,
      moment,
    });
  } else if (req.session.user && req.session.user.role === 'user') {
    const barang = await stok.getDetail(req.params.id);
    const barangMasuk = await bmasuk.getDetailBarang(req.params.id);
    const barangKeluar = await bkeluar.getDetailBarang(req.params.id);

    res.render('barangDetail', {
      brg: barang,
      us: req.session.user.email,
      title: 'Detail Barang',
      brgm: barangMasuk,
      brgk: barangKeluar,
      moment,
    });
  } else {
    res.status(401);
    res.render('401', { title: '401 Error' });
  }
};

const addBarang = [
  body('kodebarang').custom(async (value) => {
    const dup = await stok.cekKode(value.toLowerCase());
    if (dup) {
      throw new Error('Tambah barang gagal: kode barang sudah ada.');
    }
    return true;
  }),
  body('namabarang').custom(async (value) => {
    const duplicate = await stok.cekBarang(value.toLowerCase());
    if (duplicate) {
      throw new Error('Tambah barang gagal: nama barang sudah ada.');
    }
    return true;
  }),
  // Image removed from flow
  async (req, res) => {
    if (req.session.user && (req.session.user.role === 'superadmin' || req.session.user.role === 'admin')) {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        // No image cleanup needed

        const barang = await stok.getBarang();

        res.render('barang', {
          title: 'Stok Barang',
          errors: errors.array(),
          user: req.session.user.email,
          brg: barang,
        });
      } else {
        const { namabarang } = req.body;
        const { deskripsi } = req.body;
        const { stock } = req.body;
        const image = null; // image removed
        const penginput = req.session.user.email;
        const { kodebarang } = req.body;

        await stok.addBarang(
          namabarang,
          deskripsi,
          stock,
          image,
          penginput,
          kodebarang,
        );

        // No image cleanup needed

        const barang = await stok.getBarang();

        res.render('barang', {
          title: 'Stok Barang',
          errors: errors.array(),
          us: req.session.user.email,
          brg: barang,
        });
      } else {
        const { namabarang } = req.body;
        const { deskripsi } = req.body;
        const { stock } = req.body;
        const image = null; // image removed
        const penginput = req.session.user.email;
        const { kodebarang } = req.body;

        await stok.addBarang(
          namabarang,
          deskripsi,
          stock,
          image,
          penginput,
          kodebarang,
        );

        // QR code generation removed

        res.redirect('/barang');
      }
    } else {
      res.status(401);
      res.render('401', { title: '401 Error' });
    }
  },
];

const updateBarang = [
  body('kodebarang').custom(async (value, { req }) => {
    const dup = await stok.checkKodeDuplicate(value.toLowerCase());
    if (value !== req.body.oldKode && dup) {
      throw new Error('Edit barang gagal: kode barang sudah ada.');
    }
    return true;
  }),
  body('namabarang').custom(async (value, { req }) => {
    const duplicate = await stok.checkDuplicate(value.toLowerCase());
    if (value !== req.body.oldNama && duplicate) {
      throw new Error('Edit barang gagal: nama barang sudah ada.');
    }
    return true;
  }),
  // Image removed from flow
  async (req, res) => {
    if (req.session.user && (req.session.user.role === 'superadmin' || req.session.user.role === 'admin')) {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        // No image cleanup needed
        const barang = await stok.getBarang();

        res.render('barang', {
          title: 'Stok Barang',
          errors: errors.array(),
          brg: barang,
          user: req.session.user.email,
        });
      } else {
        const { namabarang } = req.body;
        const { deskripsi } = req.body;
        const { stock } = req.body;
        const image = null;
        const { kodebarang } = req.body;
        const { oldKode } = req.body;
        const { idbarang } = req.body;

        await stok.updateBarang(
          namabarang,
          deskripsi,
          stock,
          image,
          kodebarang,
          idbarang,
        );

        if (kodebarang !== oldKode) {
          const oldImgPath = `./public/uploads/${oldKode}.png`;
          if (fs.existsSync(oldImgPath)) {
            await unlinkAsync(oldImgPath);
          }

          // QR code regeneration removed
        }

        res.redirect('/barang');
      }
    } else {
      res.status(401);
      res.render('401', { title: '401 Error' });
    }
  },
];

const deleteBarang = async (req, res) => {
  if (req.session.user && (req.session.user.role === 'superadmin' || req.session.user.role === 'admin')) {
    const image = await stok.getImage(req.params.id);
    const kode = await stok.getKode(req.params.id);
    await stok.delBarang(req.params.id);
    // await bmasuk.delBarangMasukId(req.params.id);
    // await bkeluar.delBarangKeluarId(req.params.id);
    if (image) {
      const imgPath = `./public/uploads/${image}`;
      if (fs.existsSync(imgPath)) {
        await unlinkAsync(imgPath);
      }
    }
      // QR PNG cleanup removed
    res.redirect('/barang');
  } else {
    res.status(401);
    res.render('401', { title: '401 Error' });
  }
};

module.exports = {
  getBarang,
  getBarangDetail,
  addBarang,
  updateBarang,
  deleteBarang,
};
