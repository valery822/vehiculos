const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('autos.db');


db.serialize(() => {
    db.run(`
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT UNIQUE,
      password TEXT
    );
  `);

    db.run(`
    CREATE TABLE IF NOT EXISTS vehicles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      marca TEXT,
      modelo TEXT,
      anio INTEGER,
      imagen TEXT,
      calificacion REAL,
      precio INTEGER,
      disponible BOOLEAN
    );
  `);
    db.run(`
  CREATE TABLE IF NOT EXISTS alquileres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vehiculo_id INTEGER,
    email_usuario TEXT,
    fecha TEXT
  );
`);

});

module.exports = db;