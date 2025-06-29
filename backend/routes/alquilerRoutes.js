const express = require('express');
const router = express.Router();
const alquilerController = require('../controllers/alquilerController');

router.post('/', alquilerController.crearAlquiler);
router.get('/:email', alquilerController.obtenerPorEmail);

module.exports = router;