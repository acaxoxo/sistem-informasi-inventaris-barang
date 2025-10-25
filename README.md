# Sistem Informasi Inventaris Barang

An inventory management application. This is my final project for WGS Bootcamp Batch 4.

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
  - [Print QR Code](#print-qr-code)
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
- **Integrated Bulk QR Code Generator**: Enables the creation of QR codes in bulk for selected items, complete with customization options for resizing and printing
<!-- Camera scan feature removed -->

## Screenshots

### Dashboard

![Dashboard](https://user-images.githubusercontent.com/32730327/273454645-93f713e4-ae39-46f9-8557-5403794b8104.png)

### Table

![Table](https://user-images.githubusercontent.com/32730327/273454711-420e7794-6de7-4a96-bd93-51c745c4e983.png)

### Print QR Code

![Print QR](https://user-images.githubusercontent.com/32730327/279402658-b86975e8-857c-46ee-9fa6-0501d59afde6.png)

<!-- Scan QR section removed: camera scanning is no longer available -->

### Dark Mode

![Dark Mode](https://user-images.githubusercontent.com/32730327/273454814-4f1d843c-59bf-4469-bb28-92ebf73f9caa.png)

## License

This project is licensed under the [GNU General Public License v3.0](https://github.com/savareyhano/Sistem-Informasi-Inventaris-Barang/blob/main/LICENSE).
