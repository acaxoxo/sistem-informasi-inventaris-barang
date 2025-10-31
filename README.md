# Sistem Informasi Inventaris Barang

An inventory management application. This is my final project for WGS Bootcamp Batch 4.

## 📖 Documentation

For a comprehensive explanation of the system architecture, workflow scenarios, and detailed business logic, see:

**[📄 SKENARIO_SISTEM.md](./SKENARIO_SISTEM.md)** - Complete system scenario documentation in Indonesian, including:
- Authentication and registration flow
- Role-based access control details
- Master data management workflow
- Transaction processing (incoming/outgoing)
- User management and logging
- End-to-end usage scenarios for all roles
- Security and validation mechanisms

This document provides the narrative context needed to understand how all components work together.

---

## Table of Contents

- [First Time Setup](#first-time-setup)
  - [Prerequisite](#prerequisite)
  - [Installation](#installation)
- [Running Locally](#running-locally)
- [Authentication & Login](#authentication--login)
  - [Default Login Credentials](#default-login-credentials)
  - [Creating New Users](#creating-new-users)
  - [User Registration](#user-registration)
- [Roles & Permissions](#roles--permissions)
- [Main Features](#main-features)
- [Screenshots](#screenshots)
  - [Dashboard](#dashboard)
  - [Table](#table)
  - [Dark Mode](#dark-mode)
- [License](#license)

## First Time Setup

### Prerequisite

- [Git](https://git-scm.com/downloads)
- [Node](https://nodejs.org/en/download/current)
- [PostgreSQL](https://www.postgresql.org/download/)

Make sure your system PATH includes Postgres tools. For Windows, [see instructions here](https://www.commandprompt.com/education/how-to-set-windows-path-for-postgres-tools/).

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/savareyhano/Sistem-Informasi-Inventaris-Barang.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Sistem-Informasi-Inventaris-Barang
   ```

3. Create a `.env` file (further configuration needed to match your Postgres database settings):

   ```bash
   cp .env.example .env
   ```

4. Install the dependencies:

   ```bash
   npm install
   ```

5. Create the database:

   ```bash
   npm run setup-db
   ```

## Running Locally

1. Start the project:

   ```bash
   npm start
   ```

2. Visit [http://localhost:3000](http://localhost:3000) (this may vary depending on the `HOSTNAME` and `PORT` values you set in the `.env` file).

## Authentication & Login

The application uses a role-based authentication system. **All users log in through the same login page** at [http://localhost:3000/login](http://localhost:3000/login). The system automatically determines your permissions based on your account's role in the database.

### How to Login

1. Start the application: `npm start`
2. Open your browser and go to [http://localhost:3000](http://localhost:3000)
3. You'll be redirected to the login page
4. Enter your **email** and **password**
5. Click "Masuk" (Login)
6. The system will redirect you to the dashboard with permissions based on your role

**Important:** There is only ONE login page for all users. Your role (superadmin, admin, operator, user, supplier, or viewer) is stored in the database and determines what features you can access after logging in.

### Default Login Credentials

After running the database setup (`npm run setup-db`), you can log in with these default accounts:

| Email | Password | Role | What You'll See After Login |
|-------|----------|------|----------------------------|
| superadmin@email.com | superadmin123 | superadmin | Full access: Dashboard, Inventory, Transactions, **Users**, **Logs** |
| admin@email.com | admin123 | admin | Dashboard, Inventory (full CRUD), Transactions (full CRUD) |
| user@email.com | password | user | Dashboard, Inventory (view), Transactions (add only) |
| usr@email.com | password | user | Dashboard, Inventory (view), Transactions (add only) |

**Note:** The default setup doesn't include operator, supplier, or viewer accounts. You need to create them or change an existing user's role (see below).

#### Reset default users without recreating the database (optional)

If your database already exists and you just want to align the default accounts and passwords with the table above, run:

```bash
npm run reset-default-users
```

This will upsert these four accounts by email with the documented passwords and roles:

- superadmin@email.com → superadmin123
- admin@email.com → admin123
- user@email.com → password
- usr@email.com → password

No other data is changed.

### Testing Different Roles

To test operator, supplier, or viewer roles, you can change an existing user's role:

```sql
-- Login to PostgreSQL and connect to your database
psql -U your_username -d your_database_name

-- Change user@email.com to operator
UPDATE users SET role = 'operator' WHERE email = 'user@email.com';

-- Or change to supplier
UPDATE users SET role = 'supplier' WHERE email = 'user@email.com';

-- Or change to viewer
UPDATE users SET role = 'viewer' WHERE email = 'user@email.com';
```

Then log in with that email and the same password to see the different permissions!

### Creating New Users

There are two ways to create new users in the system:

#### 1. User Registration (Self Sign-Up)

New users can register themselves through the registration page:

1. Navigate to [http://localhost:3000/register](http://localhost:3000/register)
2. Enter your email address
3. Create a password (minimum 6 characters)
4. Confirm your password
5. Click "Daftar" (Register)

**Note:** Self-registered users are automatically assigned the `user` role. To assign different roles (admin, operator, supplier, viewer), a superadmin must update the role  in the database.

#### 2. Database Creation (Manual)

Superadmins can also create users directly in PostgreSQL:

```sql
-- Insert a new user (password is hashed with bcrypt, see example below)
INSERT INTO users (email, password, role) 
VALUES ('newuser@example.com', '$2b$10$hashedpasswordhere', 'user');
```

To hash a password for manual insertion, you can use Node.js:

```javascript
const bcrypt = require('bcrypt');
const password = 'yourpassword';
bcrypt.hash(password, 10).then(hash => console.log(hash));
```

### User Registration

The system includes a public registration endpoint at `/register` where new users can sign up:

- **URL**: `/register` (GET/POST)
- **Access**: Public (no login required)
- **Default Role**: All registered users start with the `user` role
- **Auto-login**: After successful registration, users are automatically logged in

**To disable public registration**, remove or comment out the registration routes in `src/routes/authRoutes.js`.

## Main Features
## Roles & Permissions

The application supports six different user roles, each with specific permissions:

### Role Overview

| Role | Inventory View | Inventory Edit | Barang Masuk | Barang Keluar | User Management | Logs |
|------|----------------|----------------|--------------|---------------|-----------------|------|
| **Superadmin** | ✅ | ✅ | ✅ Add/Edit/Delete | ✅ Add/Edit/Delete | ✅ | ✅ |
| **Admin** | ✅ | ✅ | ✅ Add/Edit/Delete | ✅ Add/Edit/Delete | ❌ | ❌ |
| **Operator** | ✅ | ❌ | ✅ Add only | ✅ Add only | ❌ | ❌ |
| **User** | ✅ | ❌ | ✅ Add only | ✅ Add only | ❌ | ❌ |
| **Supplier** | ✅ | ❌ | ✅ Add only | ❌ View only | ❌ | ❌ |
| **Viewer** | ✅ | ❌ | ❌ View only | ❌ View only | ❌ | ❌ |

### Detailed Role Descriptions

#### 🔴 Superadmin
- **Full system access**
- Manage users and view application logs
- Complete CRUD operations on inventory and transactions
- Access all features and menus

#### 🟠 Admin
- **Inventory and transaction management**
- Full CRUD operations on inventory items (Stok Barang)
- Full CRUD operations on transactions (Barang Masuk/Keluar)
- Cannot access User Management or Application Logs

#### 🟡 Operator (Petugas Gudang)
- **Transaction handling**
- View inventory and details (read-only)
- Add new incoming and outgoing transactions
- Cannot edit/delete transactions
- Cannot modify inventory master data

#### 🟢 User
- **Basic transaction access**
- View inventory and details (read-only)
- Add new incoming and outgoing transactions
- Cannot edit/delete transactions
- Cannot modify inventory master data

#### 🔵 Supplier
- **Supply management**
- View inventory (read-only)
- Add Barang Masuk (incoming stock) only
- View Barang Keluar but cannot add/edit
- Cannot modify inventory master data

#### ⚪ Viewer
- **Read-only access**
- View inventory, transactions, and details
- Cannot add, edit, or delete anything
- Reporting and monitoring purposes only

### Changing User Roles

Assign or change a user's role in PostgreSQL:

```sql
-- Set a user as superadmin
UPDATE users SET role = 'superadmin' WHERE email = 'admin@example.com';

-- Set a user as admin
UPDATE users SET role = 'admin' WHERE email = 'manager@example.com';

-- Set a user as operator (warehouse staff)
UPDATE users SET role = 'operator' WHERE email = 'staff@example.com';

-- Set a user as user (default role)
UPDATE users SET role = 'user' WHERE email = 'employee@example.com';

-- Set a user as supplier
UPDATE users SET role = 'supplier' WHERE email = 'supplier@example.com';

-- Set a user as viewer (read-only)
UPDATE users SET role = 'viewer' WHERE email = 'viewer@example.com';
```

### Security Notes

- Passwords are hashed using bcrypt with a salt round of 10
- Sessions are managed using `cookie-session` middleware
- All routes check authentication status before granting access
- Role-based access control is enforced at the controller level

## Main Features

- **Role-Based Authentication System**: Six distinct user roles (superadmin, admin, operator, user, supplier, viewer) with granular permission control
- **User Registration**: Self-service registration endpoint for new users
<!-- QR features removed (QR generation and scanning are no longer available) -->

## Database Schema & ERD

This section explains the database structure, entities, attributes, and relationships to help you create an Entity-Relationship Diagram (ERD).

### Database Overview

The system uses **PostgreSQL** as the database management system. The database consists of 5 main tables:
- `users` - User accounts and authentication
- `stock` - Master data for inventory items
- `masuk` - Incoming transaction records
- `keluar` - Outgoing transaction records
- `log` - HTTP activity logs

### Entities and Attributes

#### 1. Users (Authentication & Authorization)

**Table name:** `users`

| Attribute | Type | Constraints | Description |
|-----------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY, AUTO INCREMENT | Unique user identifier |
| email | TEXT | NOT NULL, UNIQUE | User's email address (login username) |
| password | TEXT | NOT NULL | Bcrypt-hashed password (salt round 10) |
| role | TEXT | NOT NULL | User role: 'superadmin', 'admin', 'operator', 'user', 'supplier', 'viewer' |

**Business Rules:**
- Email must be unique and valid
- Password is never stored in plaintext (bcrypt hashing)
- Role determines access permissions throughout the system
- Default role for self-registration is 'user'

**Notes:**
- Supplier is NOT a separate entity; it's identified by `role = 'supplier'` in the users table
- Same applies to other roles (operator, viewer, etc.)

---

#### 2. Stock (Master Inventory Data)

**Table name:** `stock`

| Attribute | Type | Constraints | Description |
|-----------|------|-------------|-------------|
| idbarang | INTEGER | PRIMARY KEY, AUTO INCREMENT | Unique item identifier |
| namabarang | TEXT | NOT NULL | Item name |
| deskripsi | TEXT | | Item description |
| stock | INTEGER | NOT NULL, DEFAULT 0 | Current stock quantity |
| image | TEXT | | Image filename (deprecated, not used in current version) |
| penginput | TEXT | | Email of user who created this item (soft FK → users.email) |
| kodebarang | TEXT | UNIQUE (recommended) | Unique item code for identification |

**Business Rules:**
- `stock` should never be negative (enforced by transaction logic)
- `kodebarang` should be unique to avoid conflicts
- `penginput` stores the email of the creator (soft foreign key)

**Notes:**
- `image` column exists in schema but is no longer used (image upload feature removed)
<!-- QR code generation removed -->

---

#### 3. Masuk (Incoming Transactions)

**Table name:** `masuk`

| Attribute | Type | Constraints | Description |
|-----------|------|-------------|-------------|
| idmasuk | INTEGER | PRIMARY KEY, AUTO INCREMENT | Unique transaction identifier |
| idbarang | INTEGER | FK (logical) → stock.idbarang | Reference to inventory item |
| tanggal | TIMESTAMP WITH TIME ZONE | DEFAULT CURRENT_TIMESTAMP | Transaction date and time |
| keterangan | TEXT | NOT NULL | Notes about the transaction (source, reason, etc.) |
| qty | INTEGER | NOT NULL, > 0 | Quantity of items received |
| namabarang_m | TEXT | | Snapshot of item name at transaction time |
| penginput | TEXT | | Email of user who recorded this transaction (soft FK → users.email) |
| kodebarang_m | TEXT | | Snapshot of item code at transaction time |

**Business Rules:**
- `qty` must be positive (> 0)
- When a transaction is created, `stock.stock` is increased by `qty`
- When a transaction is edited, stock is adjusted by the difference (new qty - old qty)
- When a transaction is deleted, `stock.stock` is decreased by `qty`
- Snapshots (`namabarang_m`, `kodebarang_m`) preserve historical data even if master item changes

**Notes:**
- Foreign key constraint is logical (not enforced by database) but managed by application
- Snapshots ensure audit trail remains accurate

---

#### 4. Keluar (Outgoing Transactions)

**Table name:** `keluar`

| Attribute | Type | Constraints | Description |
|-----------|------|-------------|-------------|
| idkeluar | INTEGER | PRIMARY KEY, AUTO INCREMENT | Unique transaction identifier |
| idbarang | INTEGER | FK (logical) → stock.idbarang | Reference to inventory item |
| tanggal | TIMESTAMP WITH TIME ZONE | DEFAULT CURRENT_TIMESTAMP | Transaction date and time |
| penerima | TEXT | NOT NULL | Recipient name or department |
| qty | INTEGER | NOT NULL, > 0 | Quantity of items issued |
| namabarang_k | TEXT | | Snapshot of item name at transaction time |
| penginput | TEXT | | Email of user who recorded this transaction (soft FK → users.email) |
| kodebarang_k | TEXT | | Snapshot of item code at transaction time |

**Business Rules:**
- `qty` must be positive (> 0)
- Before creating a transaction, system validates that `stock.stock >= qty`
- When a transaction is created, `stock.stock` is decreased by `qty`
- When a transaction is edited, stock is adjusted by the difference (old qty - new qty)
- When a transaction is deleted, `stock.stock` is increased by `qty`
- Cannot create outgoing transaction if stock is insufficient

**Notes:**
- Same snapshot mechanism as `masuk` for historical integrity
- Stock validation prevents negative inventory

---

#### 5. Log (HTTP Activity Logs)

**Table name:** `log`

| Attribute | Type | Constraints | Description |
|-----------|------|-------------|-------------|
| idlog | INTEGER | PRIMARY KEY, AUTO INCREMENT | Unique log identifier |
| date | TIMESTAMP WITH TIME ZONE | DEFAULT CURRENT_TIMESTAMP | Request timestamp |
| usr | TEXT | | Email of user who made the request (soft FK → users.email) |
| method | TEXT | | HTTP method (GET, POST, PUT, DELETE) |
| endpoint | TEXT | | URL path accessed |
| status_code | TEXT | | HTTP response status code (200, 302, 404, 500, etc.) |

**Business Rules:**
- Logs are append-only (no edit/delete through UI)
- Only Superadmin can view logs
- Used for audit trail and debugging

**Notes:**
- `usr` can be null for unauthenticated requests (like viewing login page)
- Logged automatically by morgan middleware

---

### Relationships and Cardinality

#### Relationship Diagram (Textual)

```
Users (1) ──────< (N) Stock
  └─ via stock.penginput (soft FK to users.email)

Users (1) ──────< (N) Masuk
  └─ via masuk.penginput (soft FK to users.email)

Users (1) ──────< (N) Keluar
  └─ via keluar.penginput (soft FK to users.email)

Users (1) ──────< (N) Log
  └─ via log.usr (soft FK to users.email)

Stock (1) ──────< (N) Masuk
  └─ via masuk.idbarang (logical FK to stock.idbarang)

Stock (1) ──────< (N) Keluar
  └─ via keluar.idbarang (logical FK to stock.idbarang)
```

#### Detailed Relationships

1. **Users → Stock (One-to-Many)**
   - One user can create many inventory items
   - Relationship field: `stock.penginput` → `users.email`
   - Type: Soft foreign key (no database constraint)
   - Business rule: When viewing stock, system can show who created each item

2. **Users → Masuk (One-to-Many)**
   - One user can record many incoming transactions
   - Relationship field: `masuk.penginput` → `users.email`
   - Type: Soft foreign key
   - Business rule: System tracks who recorded each incoming transaction

3. **Users → Keluar (One-to-Many)**
   - One user can record many outgoing transactions
   - Relationship field: `keluar.penginput` → `users.email`
   - Type: Soft foreign key
   - Business rule: System tracks who recorded each outgoing transaction

4. **Users → Log (One-to-Many)**
   - One user can generate many log entries
   - Relationship field: `log.usr` → `users.email`
   - Type: Soft foreign key (can be NULL for anonymous requests)
   - Business rule: Superadmin can track all activities by user

5. **Stock → Masuk (One-to-Many)**
   - One inventory item can have many incoming transactions
   - Relationship field: `masuk.idbarang` → `stock.idbarang`
   - Type: Logical foreign key (not enforced by database constraint)
   - Business rule: Each incoming transaction increases the stock of the referenced item
   - **Cardinality:** 1 Stock : 0..N Masuk (an item can have zero or more incoming transactions)

6. **Stock → Keluar (One-to-Many)**
   - One inventory item can have many outgoing transactions
   - Relationship field: `keluar.idbarang` → `stock.idbarang`
   - Type: Logical foreign key (not enforced by database constraint)
   - Business rule: Each outgoing transaction decreases the stock of the referenced item
   - **Cardinality:** 1 Stock : 0..N Keluar (an item can have zero or more outgoing transactions)

---

### Why Soft Foreign Keys?

The system uses **soft foreign keys** (storing email or ID as text without database constraints) for the following reasons:

1. **Flexibility:** Easier to handle edge cases like user deletion without cascading issues
2. **Historical Integrity:** Even if a user is deleted, their `penginput` email remains in historical records
3. **Legacy Design:** Original schema was designed this way; adding constraints requires migration

**Recommended Improvement for ERD:**
- Show these as proper foreign key relationships in your ERD
- Add a note that they are "logical/soft FKs managed by application"
- Consider suggesting explicit FK constraints as future enhancement:
  ```sql
  ALTER TABLE stock ADD CONSTRAINT fk_stock_penginput 
    FOREIGN KEY (penginput) REFERENCES users(email) ON DELETE SET NULL;
  
  ALTER TABLE masuk ADD CONSTRAINT fk_masuk_idbarang 
    FOREIGN KEY (idbarang) REFERENCES stock(idbarang) ON DELETE CASCADE;
  
  ALTER TABLE masuk ADD CONSTRAINT fk_masuk_penginput 
    FOREIGN KEY (penginput) REFERENCES users(email) ON DELETE SET NULL;
  
  -- Similar for keluar and log tables
  ```

---

### ERD Summary for Your Diagram

**Entities (5):**
1. **Users** - PK: id, Attributes: email (UK), password, role
2. **Stock** - PK: idbarang, Attributes: namabarang, deskripsi, stock, kodebarang (UK), penginput
3. **Masuk** - PK: idmasuk, FKs: idbarang, penginput, Attributes: tanggal, qty, keterangan, snapshots
4. **Keluar** - PK: idkeluar, FKs: idbarang, penginput, Attributes: tanggal, qty, penerima, snapshots
5. **Log** - PK: idlog, FK: usr, Attributes: date, method, endpoint, status_code

**Relationships (6):**
- Users (1) → (N) Stock via penginput
- Users (1) → (N) Masuk via penginput
- Users (1) → (N) Keluar via penginput
- Users (1) → (N) Log via usr
- Stock (1) → (N) Masuk via idbarang
- Stock (1) → (N) Keluar via idbarang

**Key Constraints to Show:**
- Users.email: UNIQUE
- Stock.kodebarang: UNIQUE (recommended)
- All FKs should be drawn with proper crow's foot notation (1:N)
- All timestamps: DEFAULT CURRENT_TIMESTAMP
- All qty fields: > 0 (check constraint)
- Stock.stock: >= 0 (business rule enforced by application)

**Additional Notes for ERD:**
- Mark `penginput` fields as "soft FK" with dashed lines or annotation
- Show snapshots (`namabarang_m/k`, `kodebarang_m/k`) as separate attributes
- Indicate that `image` in Stock is deprecated
- Use different colors/shapes for different entity types (user management, inventory, transactions, logs)

---

### Example ERD Scenario

**Use Case: Supplier adds incoming transaction**

1. Supplier (role='supplier') in `users` table logs in
2. Supplier creates a new record in `masuk` table:
   - `idbarang` = 5 (references existing item in `stock`)
   - `penginput` = 'supplier@email.com' (from session)
   - `qty` = 10
   - `namabarang_m`, `kodebarang_m` = snapshot from `stock` where `idbarang=5`
3. System updates `stock` table:
   - `UPDATE stock SET stock = stock + 10 WHERE idbarang = 5`
4. System logs the request in `log` table:
   - `usr` = 'supplier@email.com'
   - `method` = 'POST'
   - `endpoint` = '/barangmasuk'
   - `status_code` = '302'

This single transaction involves 4 tables (users, stock, masuk, log) and demonstrates the interconnected nature of the system.

---

For a detailed narrative explanation of how the system works end-to-end, see [SKENARIO_SISTEM.md](./SKENARIO_SISTEM.md).

## Screenshots

### Dashboard

![Dashboard](https://user-images.githubusercontent.com/32730327/273454645-93f713e4-ae39-46f9-8557-5403794b8104.png)

### Table

![Table](https://user-images.githubusercontent.com/32730327/273454711-420e7794-6de7-4a96-bd93-51c745c4e983.png)

<!-- QR printing and scanning sections removed: QR features are no longer available -->

### Dark Mode

![Dark Mode](https://user-images.githubusercontent.com/32730327/273454814-4f1d843c-59bf-4469-bb28-92ebf73f9caa.png)

## License

This project is licensed under the [GNU General Public License v3.0](https://github.com/savareyhano/Sistem-Informasi-Inventaris-Barang/blob/main/LICENSE).
