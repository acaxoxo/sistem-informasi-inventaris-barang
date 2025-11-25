# Sistem Informasi Inventaris Barang

Aplikasi manajemen inventaris berbasis web dengan sistem role-based access control. Dibangun menggunakan Node.js, Express.js, PostgreSQL, dan EJS.

## 📖 Dokumentasi Lengkap

Untuk penjelasan detail tentang arsitektur sistem, workflow, dan business logic, lihat:
- **[SKENARIO_SISTEM.md](./SKENARIO_SISTEM.md)** - Dokumentasi lengkap dalam Bahasa Indonesia

---

## Table of Contents

- [Setup Awal](#setup-awal)
- [Menjalankan Aplikasi](#menjalankan-aplikasi)
- [Login & Autentikasi](#login--autentikasi)
- [Role & Permission](#role--permission)
- [Database Schema](#database-schema)
- [Tech Stack](#tech-stack)
- [Screenshots](#screenshots)
- [License](#license)

## Setup Awal

### Prerequisites

- [Git](https://git-scm.com/downloads)
- [Node.js](https://nodejs.org/) (v16 atau lebih baru)
- [PostgreSQL](https://www.postgresql.org/download/) (v12 atau lebih baru)

**Windows users**: Pastikan PostgreSQL tools sudah ada di system PATH. [Lihat instruksi](https://www.commandprompt.com/education/how-to-set-windows-path-for-postgres-tools/).

### Instalasi

```bash
# 1. Clone repository
git clone https://github.com/savareyhano/Sistem-Informasi-Inventaris-Barang.git
cd Sistem-Informasi-Inventaris-Barang

# 2. Install dependencies
npm install

# 3. Setup environment variables
cp .env.example .env
# Edit .env sesuai konfigurasi PostgreSQL Anda

# 4. Buat database
npm run setup-db
```

## Menjalankan Aplikasi

```bash
npm start
```

Akses aplikasi di [http://localhost:3000](http://localhost:3000)

---

## Login & Autentikasi

### Default Credentials

Setelah `npm run setup-db`, gunakan akun berikut:

| Email | Password | Role | Akses |
|-------|----------|------|-------|
| superadmin@email.com | superadmin123 | Superadmin | Full access (termasuk Users & Logs) |
| admin@email.com | admin123 | Admin | CRUD Barang & Transaksi |
| user@email.com | password | User | View Barang, Add Transaksi |

### Reset Password Default (Opsional)

Jika database sudah ada dan ingin reset password default:

```bash
npm run reset-default-users
```

### Registrasi User Baru

User baru bisa mendaftar di `/register` dengan role default **User**. Untuk mengubah role:

```sql
-- Login ke PostgreSQL
psql -U username -d database_name

-- Ubah role user
UPDATE users SET role = 'admin' WHERE email = 'user@example.com';
-- Role available: superadmin, admin, operator, user, supplier, viewer
```

---

## Role & Permission

Sistem mendukung 6 role berbeda dengan permission yang spesifik:

| Role | Stok Barang | Barang Masuk | Barang Keluar | Users | Logs |
|------|-------------|--------------|---------------|-------|------|
| **Superadmin** | ✅ Full CRUD | ✅ Full CRUD | ✅ Full CRUD | ✅ | ✅ |
| **Admin** | ✅ Full CRUD | ✅ Full CRUD | ✅ Full CRUD | ❌ | ❌ |
| **Operator** | 👁️ View | ➕ Add | ➕ Add | ❌ | ❌ |
| **User** | 👁️ View | ➕ Add | ➕ Add | ❌ | ❌ |
| **Supplier** | 👁️ View | ➕ Add | 👁️ View | ❌ | ❌ |
| **Viewer** | 👁️ View | 👁️ View | 👁️ View | ❌ | ❌ |

### Detail Role:

- **Superadmin**: Akses penuh ke semua fitur termasuk manajemen user dan logs
- **Admin**: CRUD penuh untuk master data dan transaksi (tidak bisa akses Users & Logs)
- **Operator/User**: Bisa melihat stok dan menambah transaksi masuk/keluar
- **Supplier**: Fokus pada supply chain - hanya bisa menambah barang masuk
- **Viewer**: Read-only untuk monitoring dan reporting

### Security Features:

- Password di-hash dengan bcrypt (salt round 10)
- Session management dengan `cookie-session`
- Role-based access control di setiap endpoint
- Input validation dengan `express-validator`

---## Database Schema

### Tabel Utama (5):

1. **users** - Autentikasi & otorisasi
   - `id` (PK), `email` (UNIQUE), `password` (bcrypt), `role`

2. **stock** - Master data barang
   - `idbarang` (PK), `namabarang`, `deskripsi`, `stock`, `kodebarang` (UNIQUE), `penginput`

3. **masuk** - Transaksi barang masuk
   - `idmasuk` (PK), `idbarang` (FK), `tanggal`, `qty`, `keterangan`, `penginput`
   - Snapshot: `namabarang_m`, `kodebarang_m`

4. **keluar** - Transaksi barang keluar
   - `idkeluar` (PK), `idbarang` (FK), `tanggal`, `qty`, `penerima`, `penginput`
   - Snapshot: `namabarang_k`, `kodebarang_k`

5. **log** - HTTP activity logs
   - `idlog` (PK), `date`, `usr`, `method`, `endpoint`, `status_code`

### Relasi:

- Users (1) → (N) Stock, Masuk, Keluar, Log
- Stock (1) → (N) Masuk, Keluar

**Catatan**: Sistem menggunakan soft foreign keys (email/ID sebagai text) untuk fleksibilitas. Snapshot mechanism menjaga integritas data historis.

Untuk ERD lengkap dan business rules, lihat [SKENARIO_SISTEM.md](./SKENARIO_SISTEM.md).

---

## Tech Stack

**Backend:**
- Node.js + Express.js (MVC pattern)
- PostgreSQL (Database)
- bcrypt (Password hashing)
- cookie-session (Session management)
- express-validator (Input validation)

**Frontend:**
- AdminLTE (Bootstrap 4)
- EJS (Template engine)
- DataTables, Select2, Moment.js

---## Screenshots

### Dashboard
![Dashboard](https://user-images.githubusercontent.com/32730327/273454645-93f713e4-ae39-46f9-8557-5403794b8104.png)

### Table View
![Table](https://user-images.githubusercontent.com/32730327/273454711-420e7794-6de7-4a96-bd93-51c745c4e983.png)

### Dark Mode
![Dark Mode](https://user-images.githubusercontent.com/32730327/273454814-4f1d843c-59bf-4469-bb28-92ebf73f9caa.png)

---

## License

This project is licensed under the [GNU General Public License v3.0](https://github.com/savareyhano/Sistem-Informasi-Inventaris-Barang/blob/main/LICENSE).
