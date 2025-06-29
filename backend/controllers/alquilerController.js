exports.obtenerPorEmail = (req, res) => {
    const email = req.params.email;

    const query = `
    SELECT v.* FROM alquileres a
    JOIN vehicles v ON a.vehiculo_id = v.id
    WHERE a.email_usuario = ?
  `;

    const db = require('../models/db');
    db.all(query, [email], (err, rows) => {
        if (err) return res.status(500).json({ message: 'Error al obtener alquileres' });
        res.json(rows);
    });
};