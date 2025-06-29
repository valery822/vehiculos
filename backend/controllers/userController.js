const User = require('../models/userModel');

exports.register = (req, res) => {
    const { email, password } = req.body;
    User.create(email, password, (err) => {
        if (err) {
            return res.status(400).json({ message: 'Usuario ya registrado' });
        }
        res.json({ message: 'Usuario registrado correctamente' });
    });
};

exports.login = (req, res) => {
    const { email, password } = req.body;
    User.findByEmail(email, (err, user) => {
        if (!user || user.password !== password) {
            return res.status(401).json({ message: 'Credenciales inválidas' });
        }
        res.json({ message: 'Inicio de sesión exitoso', user });
    });
};