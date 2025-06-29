const Vehicle = require('../models/vehicleModel');

exports.getAllVehicles = (req, res) => {
    Vehicle.getAll((err, rows) => {
        if (err) return res.status(500).json({ message: 'Error al obtener vehículos' });
        res.json(rows);
    });
};

exports.getVehicleById = (req, res) => {
    const id = req.params.id;
    Vehicle.getById(id, (err, row) => {
        if (err || !row) return res.status(404).json({ message: 'Vehículo no encontrado' });
        res.json(row);
    });
};

exports.createVehicle = (req, res) => {
    Vehicle.create(req.body, (err) => {
        if (err) return res.status(500).json({ message: 'Error al crear vehículo' });
        res.json({ message: 'Vehículo creado correctamente' });
    });
};