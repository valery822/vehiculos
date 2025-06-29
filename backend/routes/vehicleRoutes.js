const express = require('express');
const router = express.Router();
const vehicleController = require('../controllers/vehicleController');

// Obtener todos los autos
router.get('/', vehicleController.getAllVehicles);

// Obtener auto por ID
router.get('/:id', vehicleController.getVehicleById);

// Crear auto nuevo
router.post('/', vehicleController.createVehicle);

module.exports = router;