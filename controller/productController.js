const express = require('express');
const router = express.Router();
const db = require('../config/db');

// Datos de Demo (se usan si la BD no está disponible)
const demoProducts = [
    { id: 1, codigo_fabrica: 'HND-001', nombre: 'Kit de Arrastre Honda CB190R', categoria_id: 3, marca_id: 'Honda', precio_venta: 180.00, stock: 15, stock_minimo: 5, imagen_url: 'https://m.media-amazon.com/images/I/71u9S+I1xDL._AC_SL1500_.jpg' },
    { id: 2, codigo_fabrica: 'HND-002', nombre: 'Bujía NGK Iridium CPR8EAIX-9', categoria_id: 5, marca_id: 'NGK', precio_venta: 45.00, stock: 50, stock_minimo: 10, imagen_url: 'https://m.media-amazon.com/images/I/61mD+I2U0sL._AC_SL1000_.jpg' },
    { id: 3, codigo_fabrica: 'BJJ-001', nombre: 'Filtro de Aceite Pulsar NS200', categoria_id: 1, marca_id: 'Bajaj', precio_venta: 18.00, stock: 30, stock_minimo: 5, imagen_url: 'https://m.media-amazon.com/images/I/61r56m+qL8L._AC_SL1000_.jpg' },
    { id: 4, codigo_fabrica: 'BJJ-002', nombre: 'Pastillas de Freno Delanteras NS200', categoria_id: 2, marca_id: 'Bajaj', precio_venta: 45.00, stock: 20, stock_minimo: 5, imagen_url: 'https://m.media-amazon.com/images/I/71o0W1G3yEL._AC_SL1500_.jpg' },
    { id: 5, codigo_fabrica: 'YMH-001', nombre: 'Aceite Yamalube 10W40 4T', categoria_id: 6, marca_id: 'Yamaha', precio_venta: 35.00, stock: 4, stock_minimo: 10, imagen_url: 'https://m.media-amazon.com/images/I/61P0f9S6XHL._AC_SL1500_.jpg' },
    { id: 6, codigo_fabrica: 'YMH-002', nombre: 'Cadena de Tracción 428H-132L', categoria_id: 3, marca_id: 'Yamaha', precio_venta: 75.00, stock: 15, stock_minimo: 3, imagen_url: 'https://m.media-amazon.com/images/I/71u9S+I1xDL._AC_SL1500_.jpg' },
    // ... más productos para la muestra
];

// Generar 40 productos para la muestra si no hay BD
for(let i=7; i<=42; i++) {
    demoProducts.push({
        id: i,
        codigo_fabrica: `REF-0${i}`,
        nombre: `Repuesto de Muestra #${i}`,
        categoria_id: (i % 6) + 1,
        marca_id: ['Honda', 'Bajaj', 'Yamaha', 'Hero', 'TVS'][i % 5],
        precio_venta: (Math.random() * 200 + 10).toFixed(2),
        stock: Math.floor(Math.random() * 30),
        stock_minimo: 5,
        imagen_url: 'https://m.media-amazon.com/images/I/71u9S+I1xDL._AC_SL1500_.jpg'
    });
}

// Obtener todos los productos
router.get('/', async (req, res) => {
    try {
        const result = await db.query('SELECT * FROM productos WHERE activo = true ORDER BY id DESC');
        res.json(result.rows);
    } catch (err) {
        console.warn('⚠️ Base de datos no detectada. Cargando modo DEMO para la muestra.');
        res.json(demoProducts); // Servir datos de demo si falla la BD
    }
});

// Obtener un producto por código
router.get('/:codigo', async (req, res) => {
    try {
        const { codigo } = req.params;
        const result = await db.query('SELECT * FROM productos WHERE codigo_fabrica = $1', [codigo]);
        if (result.rows.length === 0) return res.status(404).json({ message: 'Producto no encontrado' });
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: 'Error al buscar producto' });
    }
});

// Crear o Actualizar producto (Soporta imágenes y stock mínimo)
router.post('/', async (req, res) => {
    const { codigo_fabrica, nombre, precio_venta, stock, categoria_id, marca_id, imagen_url, stock_minimo } = req.body;
    try {
        const result = await db.query(
            `INSERT INTO productos (codigo_fabrica, nombre, precio_venta, stock, categoria_id, marca_id, imagen_url, stock_minimo) 
             VALUES ($1, $2, $3, $4, $5, $6, $7, $8) 
             ON CONFLICT (codigo_fabrica) DO UPDATE SET 
                nombre = EXCLUDED.nombre, 
                precio_venta = EXCLUDED.precio_venta, 
                stock = EXCLUDED.stock, 
                imagen_url = EXCLUDED.imagen_url,
                stock_minimo = EXCLUDED.stock_minimo
             RETURNING *`,
            [codigo_fabrica, nombre, precio_venta, stock, categoria_id, marca_id, imagen_url, stock_minimo]
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: 'Error al procesar el producto en el servidor', details: err.message });
    }
});

module.exports = router;
