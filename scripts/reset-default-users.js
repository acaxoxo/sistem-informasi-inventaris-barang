/*
  Reset or create default users without recreating the database.
  - Reads DB connection from .env (PGHOST, PGPORT, PGUSER, PGPASSWORD, PGDATABSE)
  - Upserts users by email with desired roles and passwords
*/

require('dotenv').config();
const { Pool } = require('pg');
const bcrypt = require('bcrypt');

const USERS = [
  { email: 'superadmin@email.com', password: 'superadmin123', role: 'superadmin' },
  { email: 'admin@email.com', password: 'admin123', role: 'admin' },
  { email: 'user@email.com', password: 'password', role: 'user' },
  { email: 'usr@email.com', password: 'password', role: 'user' },
];

function getPool() {
  const config = {
    host: process.env.PGHOST || 'localhost',
    port: Number(process.env.PGPORT || 5432),
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    database: process.env.PGDATABASE,
    ssl: process.env.PGSSL === 'true' ? { rejectUnauthorized: false } : undefined,
  };
  return new Pool(config);
}

async function upsertUser(client, { email, password, role }) {
  const hash = await bcrypt.hash(password, 10);

  const { rows } = await client.query('SELECT id FROM users WHERE email = $1 LIMIT 1', [email]);
  if (rows.length > 0) {
    const { id } = rows[0];
    await client.query('UPDATE users SET password = $1, role = $2 WHERE id = $3', [hash, role, id]);
    return { email, action: 'updated', role };
  }
  await client.query('INSERT INTO users (email, password, role) VALUES ($1, $2, $3)', [email, hash, role]);
  return { email, action: 'created', role };
}

async function run() {
  console.log('Resetting default users...');
  const pool = getPool();
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    const results = [];
    for (let i = 0; i < USERS.length; i += 1) {
      // sequentially process each user to ensure stable output
      // eslint-disable-next-line no-await-in-loop
      const res = await upsertUser(client, USERS[i]);
      results.push(res);
    }
    await client.query('COMMIT');

    console.log('\nResults:');
    results.forEach((r) => {
      console.log(`- ${r.email} -> ${r.action} [role=${r.role}]`);
    });
    console.log('\n✅ Done. You can now login using the documented default credentials.');
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('❌ Error:', err.message);
    process.exitCode = 1;
  } finally {
    client.release();
    await pool.end();
  }
}

run().catch((e) => {
  console.error('❌ Failed:', e.message);
  process.exit(1);
});
