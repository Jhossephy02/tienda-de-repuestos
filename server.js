const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
require('dotenv').config();

const app = express();

// Middlewares
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

// Servir archivos estáticos de la vista
app.use(express.static('view'));
// Servir archivos estáticos de los controladores para el frontend
app.use('/controller', express.static('controller'));

// Redirección de la raíz y /home a la tienda virtual (store.html)
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/view/store.html');
});

app.get('/home', (req, res) => {
    res.sendFile(__dirname + '/view/store.html');
});

// Rutas de la API
app.use('/api/productos', require('./controller/productController'));
app.use('/api/ventas', require('./controller/salesController'));

// Manejador de errores global para el servidor
app.use((err, req, res, next) => {
    console.error('💥 Error Crítico del Servidor:', err.stack);
    res.status(500).json({
        error: 'Algo salió mal en el servidor',
        message: err.message
    });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`🚀 Servidor MotoStock Pro corriendo en http://localhost:${PORT}`);
});
