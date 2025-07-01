const db = require('../models/db');

exports.crearAlquiler = (req, res) => {
    const { vehiculo_id, email_usuario } = req.body;
    const fecha = new Date().toISOString();

    if (!vehiculo_id || !email_usuario) {
        return res.status(400).json({ message: 'Faltan datos' });
    }

    db.run(
        'INSERT INTO alquileres (vehiculo_id, email_usuario, fecha) VALUES (?, ?, ?)', [vehiculo_id, email_usuario, fecha],
        (err) => {
            if (err) return res.status(500).json({ message: 'Error al guardar alquiler' });
            res.json({ message: 'Alquiler registrado exitosamente' });
        }
    );
};

exports.obtenerPorEmail = (req, res) => {
    const email = req.params.email;

    const query = `
    SELECT v.* FROM alquileres a
    JOIN vehicles v ON a.vehiculo_id = v.id
    WHERE a.email_usuario = ?
  `;

    db.all(query, [email], (err, rows) => {
        if (err) {
            return res.status(500).json({ message: 'Error al obtener alquileres' });
        }
        res.json(rows);
    });
};