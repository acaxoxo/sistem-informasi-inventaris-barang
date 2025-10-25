require('dotenv').config();
const { Client } = require('pg');
const bcrypt = require('bcrypt');

async function run() {
  const client = new Client({
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    host: process.env.PGHOST,
    port: process.env.PGPORT,
    database: process.env.PGDATABASE,
  });
  await client.connect();

  const targets = [
    { email: 'superadmin@email.com', password: 'superadmin123' },
    { email: 'admin@email.com', password: 'admin123' },
    { email: 'user@email.com', password: 'password' },
    { email: 'usr@email.com', password: 'password' },
  ];

  const results = await Promise.all(
    targets.map(async ({ email, password }) => {
      const r = await client.query('SELECT password FROM users WHERE email = $1', [email]);
      if (!r.rows.length) {
        return `${email}: NOT FOUND`;
      }
      const ok = await bcrypt.compare(password, r.rows[0].password);
      return `${email}: ${ok ? 'OK' : 'FAIL'}`;
    }),
  );
  results.forEach((line) => console.log(line));

  await client.end();
}

run().catch((e) => {
  console.error('Error:', e);
  process.exit(1);
});
