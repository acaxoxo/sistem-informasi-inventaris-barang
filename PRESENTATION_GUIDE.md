# 📊 Presentation Guide - Sistem Informasi Inventaris Barang

Panduan lengkap untuk mempresentasikan sistem inventaris barang dalam laporan atau demo.

---

## 🎯 Poin Presentasi Utama

### 1. **Latar Belakang & Tujuan**
- **Masalah**: Pengelolaan inventaris manual yang rentan kesalahan, sulit tracking, dan tidak ada audit trail
- **Solusi**: Sistem web-based dengan role-based access control untuk manajemen inventaris yang efisien
- **Tujuan**:
  - Otomasi pencatatan stok barang
  - Tracking transaksi masuk/keluar
  - Multi-user dengan permission yang berbeda
  - Audit trail lengkap untuk keamanan data

### 2. **Fitur Utama**

#### a. Autentikasi & Role-Based Access Control (RBAC)
- **6 Role Berbeda**: Superadmin, Admin, Operator, User, Supplier, Viewer
- **Single Login Portal**: Semua user login di satu tempat
- **Security**: Password hashing dengan bcrypt, session management

#### b. Master Data Barang
- CRUD lengkap untuk Superadmin/Admin
- Tracking siapa yang menginput barang (`penginput`)
- Kode barang unique untuk identifikasi

#### c. Transaksi Barang Masuk
- Pencatatan barang yang masuk ke gudang
- Otomatis update stok (+)
- Snapshot data untuk integritas historis

#### d. Transaksi Barang Keluar
- Pencatatan barang yang keluar dari gudang
- Validasi stok sebelum transaksi
- Otomatis update stok (-)

#### e. User Management (Superadmin Only)
- Kelola akun pengguna
- Ubah role user
- Reset password

#### f. Activity Logging
- Setiap HTTP request tercatat
- Audit trail lengkap
- Monitoring aktivitas user

---

## 🗂️ Struktur Database (ERD)

### Entitas (5 Tabel):

```
┌─────────────────┐
│     USERS       │
├─────────────────┤
│ PK id           │
│    email (UK)   │
│    password     │
│    role         │
└────────┬────────┘
         │
         │ (1:N)
         ├──────────────────────────────┐
         │                              │
         ▼                              ▼
┌─────────────────┐            ┌─────────────────┐
│     STOCK       │            │     MASUK       │
├─────────────────┤            ├─────────────────┤
│ PK idbarang     │◄───┐       │ PK idmasuk      │
│    namabarang   │    │       │ FK idbarang     │
│    deskripsi    │    │ (1:N) │    tanggal      │
│    stock        │    │       │    qty          │
│    kodebarang   │    │       │    keterangan   │
│    penginput    │    │       │    penginput    │
└─────────────────┘    │       │    (snapshots)  │
         │             │       └─────────────────┘
         │             │
         │ (1:N)       │
         ▼             │
┌─────────────────┐    │
│     KELUAR      │    │
├─────────────────┤    │
│ PK idkeluar     │────┘
│ FK idbarang     │
│    tanggal      │
│    qty          │
│    penerima     │
│    penginput    │
│    (snapshots)  │
└─────────────────┘

        LOG
   ─────────────
   PK idlog
      date
      usr (FK)
      method
      endpoint
      status_code
```

### Relasi Penting:
- **Users → Stock/Masuk/Keluar** (1:N) via `penginput`
- **Stock → Masuk/Keluar** (1:N) via `idbarang`
- **Soft Foreign Key**: Menggunakan email/ID tanpa constraint DB untuk fleksibilitas
- **Snapshot Mechanism**: `namabarang_m/k`, `kodebarang_m/k` untuk integritas historis

---

## 🎬 Demo Flow (Skenario End-to-End)

### Skenario 1: Supplier Menambah Barang Masuk

**Setup Awal:**
1. Superadmin sudah membuat barang "Laptop Dell" dengan kode "DELL001", stok awal = 0
2. Superadmin sudah set role user `supplier@email.com` = 'supplier'

**Flow Presentasi:**
```
1. Login sebagai Supplier
   Email: supplier@email.com
   Password: password
   
2. Dashboard Supplier
   ✓ Lihat statistik barang
   ✓ Menu: Dashboard, Stok Barang, Barang Masuk (NO Barang Keluar untuk supplier)
   ✗ Tidak ada menu Users & Logs
   
3. Klik "Barang Masuk"
   ✓ Tampil tabel transaksi historis
   ✓ Ada tombol "Tambah Barang Masuk"
   
4. Tambah Transaksi
   - Pilih barang: DELL001 - Laptop Dell
   - Qty: 10
   - Keterangan: "Pengadaan dari PT. XYZ"
   - Submit
   
5. Hasil
   ✓ Transaksi tersimpan di tabel `masuk`
   ✓ Stok barang berubah: 0 → 10
   ✓ Log tercatat: supplier@email.com POST /barangmasuk [302]
   ✗ Supplier TIDAK bisa edit/delete transaksi
```

### Skenario 2: Admin Mengeluarkan Barang

**Flow Presentasi:**
```
1. Login sebagai Admin
   Email: admin@email.com
   Password: admin123
   
2. Dashboard Admin
   ✓ Lihat statistik lengkap
   ✓ Menu: Dashboard, Stok, Barang Masuk, Barang Keluar, Account
   ✗ Tidak ada Users & Logs (beda dengan Superadmin)
   
3. Klik "Barang Keluar"
   ✓ Tampil tabel transaksi keluar
   ✓ Ada tombol "Tambah Barang Keluar"
   
4. Tambah Transaksi Keluar
   - Pilih barang: DELL001 - Laptop Dell (stok saat ini: 10)
   - Qty: 3
   - Penerima: "PT. ABC untuk project X"
   - Submit
   
5. Backend Validation
   ✓ Cek: stock (10) >= qty (3)? YES
   ✓ Proses transaksi
   
6. Hasil
   ✓ Transaksi tersimpan di tabel `keluar`
   ✓ Stok barang berubah: 10 → 7
   ✓ Log tercatat: admin@email.com POST /barangkeluar [302]
   ✓ Admin BISA edit/delete transaksi
```

### Skenario 3: Validasi Stok Tidak Cukup

**Flow Presentasi:**
```
1. Admin coba tambah transaksi keluar
   - Pilih barang: DELL001 (stok: 7)
   - Qty: 20 (LEBIH DARI STOK!)
   - Penerima: "Customer"
   - Submit
   
2. Backend Validation
   ✗ Cek: stock (7) >= qty (20)? NO
   
3. Hasil
   ✗ Error: "Stok tidak mencukupi"
   ✗ TIDAK ada perubahan di database
   ✓ Stok tetap: 7
```

### Skenario 4: Superadmin Monitoring Aktivitas

**Flow Presentasi:**
```
1. Login sebagai Superadmin
   Email: superadmin@email.com
   Password: superadmin123
   
2. Akses Menu "Logs"
   ✓ Hanya Superadmin yang bisa akses
   
3. Lihat Activity Log
   - supplier@email.com POST /barangmasuk [302] - 2025-11-25 10:30
   - admin@email.com POST /barangkeluar [302] - 2025-11-25 10:45
   - admin@email.com POST /barangkeluar [400] - 2025-11-25 10:50 (yang gagal)
   
4. Benefit
   ✓ Audit trail lengkap
   ✓ Tracking siapa melakukan apa dan kapan
   ✓ Debugging error
```

---

## 💡 Poin Kekuatan Sistem

### 1. **Security & Authentication**
- ✅ Password hashing dengan bcrypt (salt round 10)
- ✅ Session-based authentication
- ✅ Role-based access control (6 roles)
- ✅ Input validation dengan express-validator
- ✅ Case-insensitive login (email normalization)

### 2. **Data Integrity**
- ✅ Snapshot mechanism untuk historical data
- ✅ Stock validation sebelum transaksi keluar
- ✅ Atomic transactions (stock update bersamaan dengan transaksi)
- ✅ Audit trail lengkap di tabel `log`
- ✅ Soft foreign keys untuk fleksibilitas

### 3. **User Experience**
- ✅ Responsive UI dengan AdminLTE (Bootstrap 4)
- ✅ DataTables untuk pagination & search
- ✅ Select2 untuk dropdown dengan search
- ✅ Dark mode support
- ✅ Moment.js untuk format tanggal Indonesia

### 4. **Scalability & Maintainability**
- ✅ MVC architecture (separation of concerns)
- ✅ Modular code structure
- ✅ PostgreSQL untuk database enterprise-grade
- ✅ Environment variables untuk konfigurasi
- ✅ ESLint untuk code quality

---

## 🛠️ Tech Stack yang Digunakan

### Backend:
- **Node.js** - Runtime JavaScript
- **Express.js** - Web framework (MVC pattern)
- **PostgreSQL** - Relational database
- **bcrypt** - Password hashing
- **cookie-session** - Session management
- **express-validator** - Input validation
- **morgan** - HTTP request logger

### Frontend:
- **AdminLTE** - Admin dashboard template (Bootstrap 4)
- **EJS** - Template engine
- **jQuery** - DOM manipulation
- **DataTables** - Table enhancement
- **Select2** - Enhanced dropdown
- **Moment.js** - Date formatting

---

## 📈 Alur Data Flow (DFD)

### Level 0 (Context Diagram):
```
┌──────────┐
│ Pengguna │
└────┬─────┘
     │ Login, Input Data
     ▼
┌─────────────────────────┐
│ SISTEM INVENTARIS       │
│ - Autentikasi           │
│ - Kelola Master Data    │
│ - Kelola Transaksi      │
│ - Logging & Monitoring  │
└────┬────────────────────┘
     │ Dashboard, Reports
     ▼
┌──────────┐
│ Pengguna │
└──────────┘
```

### Level 1:
```
User → [1.0 Login] → Session → [2.0 Dashboard]
                                      ↓
User → [3.0 Kelola Stok] → DB (stock) → Response
User → [4.0 Transaksi Masuk] → DB (masuk + stock update) → Response
User → [5.0 Transaksi Keluar] → Validasi → DB (keluar + stock update) → Response
Superadmin → [6.0 Kelola Users] → DB (users) → Response
Superadmin → [7.0 Lihat Logs] → DB (log) → Response
```

---

## 🎓 Learning Outcomes

Dari project ini, saya mempelajari:

1. **Full-Stack Development**
   - Backend API dengan Express.js
   - Database design & normalization
   - Frontend templating dengan EJS

2. **Security Best Practices**
   - Password hashing
   - Session management
   - Input validation & sanitization
   - SQL injection prevention

3. **Software Architecture**
   - MVC pattern
   - Separation of concerns
   - Code modularity

4. **Database Management**
   - PostgreSQL administration
   - Transaction management
   - Foreign key relationships
   - Data integrity constraints

5. **User Management**
   - Role-based access control
   - Permission management
   - Audit trail implementation

---

## 🚀 Demo Checklist

Sebelum presentasi/demo, pastikan:

- [ ] Database sudah di-setup (`npm run setup-db`)
- [ ] Default users sudah tersedia dan password benar
- [ ] Aplikasi berjalan di `localhost:3000`
- [ ] Prepare data dummy untuk demo (minimal 3-5 barang)
- [ ] Test semua role sebelumnya
- [ ] Screenshot siap (Dashboard, Table, Transactions)
- [ ] Browser dalam keadaan clean (clear cache/cookies)

---

## 📝 Q&A Preparation

**Pertanyaan yang Mungkin Muncul:**

**Q: Mengapa menggunakan soft foreign key?**
A: Untuk fleksibilitas dan menjaga integritas data historis. Jika user dihapus, data transaksi lama tetap ada dengan email penginput tersimpan.

**Q: Bagaimana sistem mencegah stok negatif?**
A: Validasi di backend sebelum transaksi keluar diproses. Jika `stock < qty`, transaksi ditolak dengan error message.

**Q: Apa fungsi snapshot (namabarang_m, kodebarang_m)?**
A: Menyimpan data barang saat transaksi dibuat. Jika nama/kode barang di master data berubah, data historis tetap akurat.

**Q: Bagaimana cara membedakan permission antar role?**
A: Di setiap controller, ada pengecekan `req.session.user.role` untuk menentukan akses. Di view, tombol aksi ditampilkan/disembunyikan berdasarkan role.

**Q: Apakah sistem sudah production-ready?**
A: Sistem sudah fungsional untuk skala kecil-menengah. Untuk production, perlu penambahan: HTTPS, rate limiting, backup otomatis, dan testing lebih komprehensif.

---

## 📚 Referensi Dokumentasi

- **[README.md](./README.md)** - Quick start guide & setup
- **[SKENARIO_SISTEM.md](./SKENARIO_SISTEM.md)** - Dokumentasi lengkap dalam Bahasa Indonesia
- **Database Schema** - Lihat section ERD di README atau SKENARIO_SISTEM

---

**Good luck dengan presentasi! 🎉**
