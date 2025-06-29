const db = require('./db');

const Alquiler = {
    crear: (vehiculo_id, email_usuario, fecha, callback) => {
        db.run(
            'INSERT INTO alquileres (vehiculo_id, email_usuario, fecha) VALUES (?, ?, ?)', [vehiculo_id, email_usuario, fecha],
            callback
        );
    }
};

module.exports = Alquiler;