const db = require('./db');

const User = {
    create: (email, password, callback) => {
        const query = 'INSERT INTO users (email, password) VALUES (?, ?)';
        db.run(query, [email, password], function(err) {
            callback(err);
        });
    },

    findByEmail: (email, callback) => {
        const query = 'SELECT * FROM users WHERE email = ?';
        db.get(query, [email], (err, row) => {
            if (err) {
                callback(err);
            } else {
                callback(null, row);
            }
        });
    }
};

module.exports = User;