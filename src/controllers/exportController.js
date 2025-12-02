const XLSX = require('xlsx');
const moment = require('moment');
const stok = require('../queries/stockBarangQuery');
const bmasuk = require('../queries/barangMasukQuery');
const bkeluar = require('../queries/barangKeluarQuery');

// Export Stock Barang to Excel
const exportStock = async (req, res) => {
  try {
    const barang = await stok.getBarang();

    // Prepare data for Excel
    const data = barang.map((item, index) => ({
      No: index + 1,
      'Kode Barang': item.kodebarang,
      'Nama Barang': item.namabarang,
      Deskripsi: item.deskripsi,
      Kategori: item.kategori || '-',
      Satuan: item.satuan || 'pcs',
      Stok: item.stock,
      'Harga Beli': item.harga_beli || 0,
      'Harga Jual': item.harga_jual || 0,
      'Min Stock': item.min_stock || 5,
      Penginput: item.penginput,
    }));

    // Create workbook and worksheet
    const wb = XLSX.utils.book_new();
    const ws = XLSX.utils.json_to_sheet(data);

    // Set column widths
    ws['!cols'] = [
      { wch: 5 },  // No
      { wch: 15 }, // Kode Barang
      { wch: 30 }, // Nama Barang
      { wch: 40 }, // Deskripsi
      { wch: 15 }, // Kategori
      { wch: 10 }, // Satuan
      { wch: 10 }, // Stok
      { wch: 15 }, // Harga Beli
      { wch: 15 }, // Harga Jual
      { wch: 12 }, // Min Stock
      { wch: 25 }, // Penginput
    ];

    XLSX.utils.book_append_sheet(wb, ws, 'Stok Barang');

    // Generate buffer
    const buf = XLSX.write(wb, { type: 'buffer', bookType: 'xlsx' });

    // Set response headers
    res.setHeader('Content-Disposition', `attachment; filename=Stok_Barang_${moment().format('YYYY-MM-DD_HHmmss')}.xlsx`);
    res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

    res.send(buf);
  } catch (error) {
    console.error('Export stock error:', error);
    res.status(500).send('Error exporting data');
  }
};

// Export Barang Masuk to Excel
const exportBarangMasuk = async (req, res) => {
  try {
    const barangMasuk = await bmasuk.getBarangMasuk();

    // Prepare data for Excel
    const data = barangMasuk.map((item, index) => ({
      No: index + 1,
      Tanggal: moment(item.tanggal).format('DD/MM/YYYY HH:mm'),
      'Kode Barang': item.kodebarang_m,
      'Nama Barang': item.namabarang_m,
      Qty: item.qty,
      Satuan: item.satuan || 'pcs',
      Keterangan: item.keterangan,
      Penginput: item.penginput,
    }));

    // Create workbook and worksheet
    const wb = XLSX.utils.book_new();
    const ws = XLSX.utils.json_to_sheet(data);

    // Set column widths
    ws['!cols'] = [
      { wch: 5 },  // No
      { wch: 20 }, // Tanggal
      { wch: 15 }, // Kode Barang
      { wch: 30 }, // Nama Barang
      { wch: 10 }, // Qty
      { wch: 10 }, // Satuan
      { wch: 40 }, // Keterangan
      { wch: 25 }, // Penginput
    ];

    XLSX.utils.book_append_sheet(wb, ws, 'Barang Masuk');

    // Generate buffer
    const buf = XLSX.write(wb, { type: 'buffer', bookType: 'xlsx' });

    // Set response headers
    res.setHeader('Content-Disposition', `attachment; filename=Barang_Masuk_${moment().format('YYYY-MM-DD_HHmmss')}.xlsx`);
    res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

    res.send(buf);
  } catch (error) {
    console.error('Export barang masuk error:', error);
    res.status(500).send('Error exporting data');
  }
};

// Export Barang Keluar to Excel
const exportBarangKeluar = async (req, res) => {
  try {
    const barangKeluar = await bkeluar.getBarangKeluar();

    // Prepare data for Excel
    const data = barangKeluar.map((item, index) => ({
      No: index + 1,
      Tanggal: moment(item.tanggal).format('DD/MM/YYYY HH:mm'),
      'Kode Barang': item.kodebarang_k,
      'Nama Barang': item.namabarang_k,
      Qty: item.qty,
      Satuan: item.satuan || 'pcs',
      Penerima: item.penerima,
      Penginput: item.penginput,
    }));

    // Create workbook and worksheet
    const wb = XLSX.utils.book_new();
    const ws = XLSX.utils.json_to_sheet(data);

    // Set column widths
    ws['!cols'] = [
      { wch: 5 },  // No
      { wch: 20 }, // Tanggal
      { wch: 15 }, // Kode Barang
      { wch: 30 }, // Nama Barang
      { wch: 10 }, // Qty
      { wch: 10 }, // Satuan
      { wch: 40 }, // Penerima
      { wch: 25 }, // Penginput
    ];

    XLSX.utils.book_append_sheet(wb, ws, 'Barang Keluar');

    // Generate buffer
    const buf = XLSX.write(wb, { type: 'buffer', bookType: 'xlsx' });

    // Set response headers
    res.setHeader('Content-Disposition', `attachment; filename=Barang_Keluar_${moment().format('YYYY-MM-DD_HHmmss')}.xlsx`);
    res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

    res.send(buf);
  } catch (error) {
    console.error('Export barang keluar error:', error);
    res.status(500).send('Error exporting data');
  }
};

module.exports = {
  exportStock,
  exportBarangMasuk,
  exportBarangKeluar,
};
