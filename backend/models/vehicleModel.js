const db = require('./db');

const Vehicle = {
    getAll: (callback) => {
        db.all('SELECT * FROM vehicles', [], callback);
    },

    getById: (id, callback) => {
        db.get('SELECT * FROM vehicles WHERE id = ?', [id], callback);
    },

    create: (data, callback) => {
        const { marca, modelo, anio, imagen, calificacion, precio, disponible } = data;
        const query = `
      INSERT INTO vehicles (marca, modelo, anio, imagen, calificacion, precio, disponible)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `;
        db.run(query, [marca, modelo, anio, imagen, calificacion, precio, disponible], callback);
    }
};

module.exports = Vehicle;