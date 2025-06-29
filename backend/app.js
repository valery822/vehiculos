const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const userRoutes = require('./routes/userRoutes');
const vehicleRoutes = require('./routes/vehicleRoutes');
const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());
app.use('/api/users', userRoutes);
app.use('/api/vehicles', vehicleRoutes);

app.get('/', (req, res) => {
    res.send('API de Alquiler de Autos funcionando 🚗');
});

app.listen(PORT, () => {
    console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
const alquilerRoutes = require('./routes/alquilerRoutes');
app.use('/api/alquileres', alquilerRoutes);